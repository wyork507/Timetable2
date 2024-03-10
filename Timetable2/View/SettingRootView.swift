//
//  Settings.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/15.
//

import SwiftUI

private struct SettingOption: Identifiable, Hashable, Equatable {
    var id = UUID()
    var name: String
    var view: AnyView
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: SettingOption, rhs: SettingOption) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

struct SettingRootView: View {
    @State private var selectedOption: SettingOption?
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    //@State private var isChange: Bool = false
    
    private let options = [
        SettingOption(name: "Lessons", view: AnyView(ConditionSetting())),
        SettingOption(name: "Timetable", view: AnyView(TimetableSetting())),
        SettingOption(name: "Courses", view: AnyView(CourseSetting())),
        SettingOption(name: "Notification", view: AnyView(Text("Task Notification/next class reminder"))),
        SettingOption(name: "Theme", view: AnyView(Text("Theme"))),
        SettingOption(name: "About", view: AnyView(Text("")))
    ]
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            VStack {
                List (selection: $selectedOption) {
                    ForEach(options) { option in
                        NavigationLink(value: option){
                            Text(option.name)
                        }
                    }
                }
            }
            .navigationSplitViewColumnWidth(240)
            .navigationTitle("Settings")
        } detail: {
            selectedOption?.view ?? AnyView(Text("Select a setting category"))
        } .onAppear() {
            columnVisibility = .all
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    SettingRootView()
}
