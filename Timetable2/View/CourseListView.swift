//
//  WeekView.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/28.
//

import SwiftUI

struct Person: Identifiable {
    let givenName: String
    let familyName: String
    let emailAddress: String
    let id = UUID()
    
    var fullName: String { givenName + " " + familyName }
}

struct CourseListView: View {
    @State private var people = [
        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    Text("Studying Course")
                }
                Section {
                    
                } header: {
                    Text("Ended Course")
                }
            }
            .listStyle(.plain)
        }
    }
}

fileprivate struct CourseViewer: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var name: String
    
    @State private var isShowingEditorSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(name)
                        .font(.title)
                        .bold()
                        .padding(.vertical, 5.0)
                }
                Section {
                    HStack {
                        Image(systemName: "calendar")
                            .frame(width: 30.0)
                        Text(Weekday.monday.strings)
                    }
                    HStack {
                        Image(systemName: "clock")
                            .frame(width: 30.0)
                        Text("(2) 09:10 ~ 10:00")
                    }
                    HStack {
                        Image(systemName: "person")
                            .frame(width: 30.0)
                        Text("張哈星")
                    }
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .frame(width: 30.0)
                        Text("綜1001, 本部, NTNU")
                    }
                }.listRowSeparator(.hidden)
                Section("Reminder") {
                    LabeledContent {
                        Text("W8 in xx/xx , Midterm")
                    } label: {
                        Text("Next Exam")
                    }
                    LabeledContent {
                        Text("3 haven't done")
                    } label: {
                        Text("Assignment")
                    }
                }
            }.listStyle(.plain)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbar {
                if isShowingEditorSheet {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            isShowingEditorSheet = false
                        }, label: {
                            Text("Save")
                        })
                    }
                } else {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            isShowingEditorSheet = true
                        }, label: {
                            Text("Edit")
                        })
                    }
                }
            }
        }
        
    }
}

#Preview("Major") {
    CourseListView()
}

#Preview("Viewer") {
    CourseViewer(name: .constant("Course Name"))
}
