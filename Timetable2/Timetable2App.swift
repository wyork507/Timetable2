//
//  Timetable2App.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//

import SwiftUI
import SwiftData

internal let storeURL = URL.documentsDirectory.appending(path: "database.sqlite")

@main
struct Timetable2App: App {
    //let container: ModelContainer
    //
    //init() {
    //    do {
    //        let schema = Schema([Timetables.self, Course.self])
    //        let config = ModelConfiguration(url: storeURL)
    //        container = try ModelContainer(for: schema, configurations: config)
    //    } catch {
    //        fatalError("Failed to configure SwiftData container.")
    //    }
    //}
    //
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Timetables.self, Course.self, School.self, Assignment.self])
    }
}
