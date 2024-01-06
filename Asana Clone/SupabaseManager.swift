import Foundation
import Supabase
import Observation

@Observable
final class SupabaseManager {
	// MARK: State variables
	var signedIn: Bool = false
	var user: User?
	let supabase = SupabaseClient(supabaseURL: URL(string: "https://idesgwavccmmhoztqnfw.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlkZXNnd2F2Y2NtbWhvenRxbmZ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODc0MDQwODUsImV4cCI6MjAwMjk4MDA4NX0.ecki1tjoFG5lzhDsvxq23i7Em_OepNpIEZhqPX5CNs8")
	var database: PostgrestClient {
		supabase.database
	}
	
	
	init() async {
		await getUserSession()
	}
	
	private func getUserSession() async {
		do {
			let _ = try await supabase.auth.session
			signedIn = true
			await getUser()
		} catch {
			signedIn = false
		}
	}
	
	private func getUser() async {
		do {
			self.user = try await supabase.auth.user()
		} catch {
			print(error)
		}
	}
}
