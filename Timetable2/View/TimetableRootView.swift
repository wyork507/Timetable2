//
//  TimetableView.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/24.
//

import SwiftUI

struct TimetableRootView: View {
    @State private var selectedTab: Subtab = .Day
    @State private var viewingTimetable: String = UserDefaults.standard.string(forKey: UserPreference.Timetable.active.path) ?? "N/A"
    
    var body: some View {
        VStack {
            NavigationStack {
                selectedTab.tabView
                    .toolbar() {
                        ToolbarItem(placement: .principal) {
                            Picker("View Type", selection: $selectedTab){
                                ForEach(Subtab.allCases, id: \.self) { tab in
                                    Text(tab.rawValue)
                                        .tag(tab)
                                }
                            }
                            .pickerStyle(.segmented)
                            .frame(width: 200)
                        }
                        ToolbarItemGroup(placement: .secondaryAction) {
                            Button("Previous Semester"){
                                //
                            }
                        }
                        ToolbarItemGroup(placement: .topBarLeading) {
                            Text(viewingTimetable)
                                .font(.title)
                                .padding(.trailing, 10.0)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

private enum Subtab: String, CaseIterable {
    case Day = "Day"
    case Week = "Week"
    case Schedule = "Schedule"
    
    var tabView: AnyView {
        switch self {
        case .Week:
            AnyView(CourseListView())
        case .Day:
            AnyView(DayView())
        case .Schedule:
            AnyView(Text("3"))
        }
    }
}

#Preview {
    TimetableRootView()
}
