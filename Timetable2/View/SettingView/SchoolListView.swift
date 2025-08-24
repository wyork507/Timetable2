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
                                SchoolDetailView(school: school, isPresented: .constant(true))
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
            AddNewSchoolView(isPresented: $isAdding)
        }
     }
}

fileprivate struct AddNewSchoolView: View {
    @Environment(\.modelContext) private var context
    @Binding var isPresented: Bool
    
    @State private var newName = ""
    @State private var tempSchool: School? = nil

    var body: some View {
        NavigationStack {
            Form {
                Section("Add School") {
                    TextField("Name", text: $newName, prompt: Text("Enter a name"))
                    NavigationLink("Continue") {
                        SchoolDetailView(
                            school: tempSchool ?? School(name: newName, schedule: []),
                            isPresented: $isPresented
                        ).interactiveDismissDisabled(true)
                    }.disabled(newName.isEmpty || isContain(newName))
                }
                Section("Creating by Defaults") {
                    defaultSchools(.NTNU)
                    defaultSchools(.NTU)
                    defaultSchools(.NTUST)
                }
            }
            .navigationTitle("Add School")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func defaultSchools(_ defaultsSchools: DefaultSchools) -> some View {
        Button(defaultsSchools.rawValue) {
            save(School(defaultsSchools))
        }
        .disabled(isContain(defaultsSchools.rawValue))
        .buttonStyle(.plain)
    }
    
    private func isContain(_ name: String) -> Bool {
        if let result = try? context.fetchCount(
            FetchDescriptor(predicate: #Predicate<School> {$0.name == name})
        ) as Int? {
            return result > 0
        } else {
            return false
        }
    }
    
    private func save(_ school: School?) {
        guard let school: School = school else {
            fatalError("Invalid school")
        }
        context.insert(school)
        try? context.save()
        isPresented = false
    }
}

#Preview("SchoolListView") {
    NavigationStack {
        SchoolListView()
            .modelContainer(for: School.self, inMemory: true)
    }
}

#Preview("AddNewSchoolView") {
    AddNewSchoolView(isPresented: .constant(true))
}
