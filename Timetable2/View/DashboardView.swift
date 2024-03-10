//
//  Dashboard.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/2/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedViewMode: ViewMode = .Both
    @State private var isShowingAssignment = true
    @State private var isShowingExamination = true
    @State private var isShowingPast = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Toggle(isOn: $isShowingAssignment) {
                    LabeledContent {
                        Text("3")
                    } label: {
                        Label("Assignment", systemImage: "doc")
                            .foregroundStyle(.black)
                    }
                }
                .toggleStyle(.button)
                .buttonStyle(.bordered)
                Toggle(isOn: $isShowingExamination) {
                    LabeledContent {
                        Text("3")
                    } label: {
                        Label("Examination", systemImage: "doc.text")
                            .foregroundStyle(.black)
                    }
                }
                .toggleStyle(.button)
                .buttonStyle(.bordered)
            }.padding(.horizontal)
            Divider()
            ZStack {
                List {
                    Section {
                        HStack {
                            LabeledContent {
                                Button("Done") {
                                    print("done")
                                }
                            } label: {
                                Text("繳交心得")
                                Text("due to 23:59, Today")
                            }
                        }
                    }
                    Section("in 7 days") {
                        
                    }
                    Section("Week 4") {
                        
                    }
                }.listStyle(.inset)
                VStack {
                    Spacer()
                    HStack(alignment: .bottom) {
                        Toggle(isOn: $isShowingPast, label: {
                            Label("Showing Past", systemImage: "clock.arrow.circlepath")
                                .labelStyle(.iconOnly)
                        })
                        .toggleStyle(.button)
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                }.padding()
                
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                }
            }
        }
    }
}

fileprivate enum ViewMode: String, CaseIterable {
    case Assignment
    case Examination
    case Both
    
    var tabView: AnyView {
        switch self {
        case .Assignment:
            AnyView(Text("a"))
        case .Examination:
            AnyView(Text("e"))
        case .Both:
            AnyView(Text("l"))
        }
    }
}

#Preview("Major") {
    DashboardView()
}
