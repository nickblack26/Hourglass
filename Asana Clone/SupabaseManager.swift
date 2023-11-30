//
//  SupabaseManager.swift
//  Asana Clone
//
//  Created by Nick on 6/22/23.
//

import Foundation
import Observation
import Supabase
import PostgREST
import GoTrue


@Observable
class SupabaseManger {
	var projects: [PublicProjectsModel] = []
	var starredProjects: [PublicUserFavorites] = []
	var currentTeam: PublicTeamsModel?
	var currentProject: PublicProjectsModel?
	static let shared = SupabaseManger()
	let client = SupabaseClient(supabaseURL: URL(string: "https://idesgwavccmmhoztqnfw.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlkZXNnd2F2Y2NtbWhvenRxbmZ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODc0MDQwODUsImV4cCI6MjAwMjk4MDA4NX0.ecki1tjoFG5lzhDsvxq23i7Em_OepNpIEZhqPX5CNs8")
	
	var user_session: Session? = nil
	private var user_id: UUID? = nil
	var isLoggedOut: Bool = true
	private let defaults = UserDefaults.standard
	
	init() {
		guard let accessToken = defaults.object(forKey: "accessToken") as? String else { return }
		guard let refreshToken = defaults.object(forKey: "refreshToken") as? String else { return }
		
		Task {
			do {
				try await setSession(accessToken: accessToken, refreshToken: refreshToken)
				self.user_session = try await client.auth.session
				print(user_session?.user.id)
			} catch {
				throw error
			}
		}
	}
	
	func setSession(accessToken: String, refreshToken: String) async throws {
		do {
			self.user_session = try await client.auth.setSession(accessToken: accessToken, refreshToken: refreshToken)
			defaults.set(user_session?.accessToken, forKey: "accessToken")
			defaults.set(user_session?.refreshToken, forKey: "refreshToken")
		} catch {
			print(error)
			throw error
		}
	}
	
	func signOut() async {
		do {
			try await client.auth.signOut()
		} catch {
			print(error)
		}
	}
	
	func makeRequest<T: Decodable>(_ for: T.Type, query: PostgrestTransformBuilder) async throws -> T {
		do {
			return try JSONDecoder().decode(T.self, from: try await query.execute().value)
		} catch {
			print(error)
			throw error
		}
	}
	
	func makeRequest<T: Decodable>(_ for: [T.Type], query: PostgrestTransformBuilder) async throws -> [T] {
		do {
			return try JSONDecoder().decode([T].self, from: try await query.execute().value)
		} catch {
			print(error)
			throw error
		}
	}
	
	func signIn(email: String, password: String) async {
		Task {
			do {
				self.user_session = try await client.auth.signIn(email: email, password: password)
				
				defaults.set(user_session?.accessToken, forKey: "accessToken")
				defaults.set(user_session?.refreshToken, forKey: "refreshToken")
				print("signed in!")
			} catch {
				print("### Sign Up Error: \(error)")
			}
		}
	}
	
	func getProjects() async -> [PublicProjectsModel] {
		let query = client.database
			.from("projects")
			.select(columns: "id, name, team_id: team_id(id, name)")
		
		do {
			let response: [PublicProjectsModel] = try await query.execute().value
			return response
		} catch {
			print("### Select Projects Error: \(error)")
		}
		return []
	}
	
	func getProject(id: UUID) async throws -> PublicProjectsModel {
		let query = client.database
			.from("projects")
			.select(columns: "id, name, team: team_id(id, name), sections: project_sections(id, name, section_tasks: project_tasks(task: task_id(id, name, is_complete)))")
			.eq(column: "id", value: id)
			.single()
		
		do {
			return try await makeRequest(PublicProjectsModel.self, query: query)
		} catch {
			throw error
		}
	}
	
	func getFavoritedProjects() async throws -> [PublicUserFavorites] {
		let query = client.database
			.from("user_favorites")
			.select(columns: "project_id: project_id(id, name, team_id: team_id(id, name))")
		
		do {
			return try await makeRequest([PublicUserFavorites.self], query: query)
		} catch {
			throw error
		}
	}
	
	func getTasks() async -> [PublicTasksModel] {
		let query = client.database
			.from("tasks")
			.select(columns: "id, name, is_complete, start_date, end_date, project_tasks: project_tasks(project_id: project_id(id, name))")
		
		do {
			let response: [PublicTasksModel] = try await query.execute().value
			return response
		} catch {
			print("### Select Tasks Error: \(error)")
		}
		
		return []
	}
	
	func updateTask(toUpdate: PublicTasksModel) async -> PublicTasksModel? {
		let query = client.database
			.from("tasks")
			.update(values: toUpdate, returning: .representation)
			.eq(column: "id", value: toUpdate.id)
			.select()
		
		do {
			return try await query.execute().value
		} catch {
			print("### Updating Task Error: \(error)")
		}
		
		return nil
	}
	
	func myTasks() async -> [PublicTasksModel] {
		if let id = self.user_id {
			let query = client.database
				.from("project_tasks")
				.select(columns: "task_id: task_id(id, name, is_complete)")
				.eq(column: "task_id.user_id", value: id)
			
			do {
				let response: [PublicProjectTaskModel] = try await query.execute().value
				return response.map { $0.task }
			} catch {
				print("### Select My Tasks Error: \(error)")
			}
		}
		
		return []
	}
	
	func getUser(id: UUID) async -> PublicUsersModel? {
		let query = client.database
			.from("users")
			.select()
			.eq(column: "id", value: id)
			.single()
		
		do {
			let response: PublicUsersModel = try await query.execute().value
			return response
		} catch {
			print("### Getting User Error: \(error)")
		}
		
		return nil
	}
	
	/// Update user's metadata, if a user is detected
	/// - Parameter data: serialized JSON data
	func updateUserMetadata(data: [String: AnyJSON]) async throws {
		do {
			try await client.auth.update(user: UserAttributes(data: data))
		} catch {
			throw error
		}
	}
	
//	client.storage.getBucket(id: "profiles_images")
	
	/// Gets the sessioned users infomation
	/// - Returns: User from public users table
	func getUser() async -> PublicUsersModel? {
		guard let user_id = self.user_id else { return nil }
		
		let query = client.database
			.from("users")
			.select()
			.eq(column: "id", value: user_id)
			.single()
		
		do {
			let response: PublicUsersModel = try await query.execute().value
			return response
		} catch {
			print("### Getting User Error: \(error)")
		}
		
		return nil
	}
}
