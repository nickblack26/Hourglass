//
//  Asana_CloneApp.swift
//  Asana Clone
//
//  Created by Nick on 6/21/23.
//

import SwiftUI

@main
struct Asana_CloneApp: App {
	@State private var vm = UserDefaultsViewModel()
	@State private var manager = SupabaseManger()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.tint(Color("brand"))
				.background(Color("AppBG"))
				.environment(vm)
				.environment(manager)
        }
    }
}
