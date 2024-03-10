//
//  ContentView.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @State private var selectedTab: Tab = .TimetableView
    @State private var tabs: [Tab] = Tab.allCases
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs, id: \.self) { tab in
                tab.tabView
                    .tabItem {
                        Image(systemName: tab.rawValue)
                        Text(tab.tabName)
                    }
                    .tag(tab)
                    .onAppear {
                        reload(tab: tab)
                    }
            }
        }
    }
    private func reload(tab: Tab) {
        tabs = Tab.allCases
    }
    
}
#Preview {
    ContentView()
}

private enum Tab: String, CaseIterable {
    case TimetableView = "tablecells"
    case AssignmentView = "doc"
    case Dashboard = "list.dash.header.rectangle"
    case SettingView = "gearshape"
    
    var tabName: String {
        switch self {
        case .TimetableView:
            return "Timetable"
        case .AssignmentView:
            return "Assignment"
        case .Dashboard:
            return "Dashboard"
        case .SettingView:
            return "Setting"
        }
    }
    
    var tabView: AnyView {
        switch self {
        case .TimetableView:
            AnyView(TimetableRootView())
        case .AssignmentView:
            AnyView(UnderConstruction())
        case .Dashboard:
            AnyView(DashboardView())
        case .SettingView:
            AnyView(SettingRootView())
        }
    }
}



/*
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self)
}
*/
