//
//  SchoolListView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/18.
//

import SwiftUI
import SwiftData

struct SchoolListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: [SortDescriptor(\School.name)], animation: .snappy)
    private var schools: [School]
    
    @State private var newName = ""
    @State private var tempSchool: School = School()
    
    @State private var isAdding = false
    
    var body: some View {
        NavigationStack {
            List {
                if schools.isEmpty {
                    ContentUnavailableView(
                        "No schools yet",systemImage: "questionmark.circle",
                        description: Text("Create your first school by tapping the plus button in the top right corner.")
                    )
                } else {
                    Section {
                        ForEach(schools) { school in
                            NavigationLink {
                                SchoolDetailView(school: Binding<School>(get: { school }, set: { _ in } ))
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(school.name)
                                    Text(school.campuses.joined(separator: ", "))
                                        .font(.caption2)
                                }
                            }
                            .frame(height: 38)
                        }
                    }
                }
            }
        }
        .navigationTitle("Schools")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAdding = true
                } label: {
                    Label("Add School", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isAdding) {
            NavigationStack {
                Form {
                    Section("Add School") {
                        TextField("Name", text: $newName, prompt: Text("Enter a name"))
                            .frame(width: .infinity)
                        NavigationLink {
                            SchoolDetailView(school: $tempSchool)
                        } label: {
                            Button("Continue") {
                                tempSchool = School(name: newName, schedule: [])
                            }
                        }.disabled(newName.isEmpty)
                    }
                    Section("Created by default") {
                        defaultSchools(.NTNU)
                        defaultSchools(.NTU)
                        defaultSchools(.NTUST)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isAdding = false
                            newName = ""
                        }
                    }
                }
            }
        }
     }
    
    private func saveContext(_ school: School) {
        context.insert(school)
        try? context.save()
        newName = ""
        isAdding = false
        tempSchool = .init()
    }
    
    @ViewBuilder
    private func defaultSchools(_ defaultsSchools: DefaultSchools) -> some View {
        Button(defaultsSchools.rawValue) {
            saveContext(School(defaultsSchools))
        }
        .disabled(schools.contains(where: { $0.name == defaultsSchools.rawValue }))
        .buttonStyle(.plain)
    }
}


#Preview {
    SchoolListView()
        .modelContainer(for: School.self, inMemory: true)
}
