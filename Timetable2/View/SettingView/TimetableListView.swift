//
//  TimetableListView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/19.
//

import SwiftUI
import SwiftData

struct TimetableListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: [SortDescriptor(\Timetables.name)], animation: .snappy)
    private var timtables: [Timetables]
    
    @State private var isAdding = false
    @State private var newName = ""
    @State private var tempTimetable = Timetables()
    
    var body: some View {
        NavigationStack {
            List {
                if timtables.isEmpty {
                    ContentUnavailableView(
                        "No timetable yet",systemImage: "questionmark.circle",
                        description: Text("Create your first timetable by tapping the plus button in the top right corner.")
                    )
                } else {
                    Section {
                        ForEach(timtables) { timetable in
                            NavigationLink {
                                TimetableDetailView(timetable: Binding<Timetables>(get: { timetable }, set: { _ in } ))
                            } label: {
                                LabeledContent {
                                    VStack {
                                        HStack {
                                            Text("from")
                                                .font(.callout)
                                            Text(timetable.start.formatted(date: .numeric, time: .omitted))
                                                .font(.callout)
                                        }
                                        HStack {
                                            Text("to")
                                                .font(.callout)
                                            Text(timetable.end.formatted(date: .numeric, time: .omitted))
                                                .font(.callout)
                                        }
                                    }
                                } label: {
                                    Text(timetable.name)
                                    Text("Created at \(timetable.createDate.formatted(date: .numeric, time: .omitted)), contains \(timetable.holidays.count.description) holiday(s).")
                                }
                            }
                            .frame(height: 38)
                        }
                    }
                }
            }
        }
        .navigationTitle("Timetables")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAdding = true
                } label: {
                    Label("Add Timetable", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isAdding) {
            NavigationStack {
                Form {
                    Section("Add Timetable") {
                        TextField("Name", text: $newName, prompt: Text("Enter a name"))
                            .frame(width: .infinity)
                        NavigationLink {
                            TimetableDetailView(timetable: $tempTimetable)
                                .toolbar {
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Save") {
                                            saveContext(tempTimetable)
                                        }.disabled(tempTimetable.isVoid)
                                    }
                                }
                        } label: {
                            Button("Continue") {
                                tempTimetable = School(name: newName, schedule: [])
                            }
                        }.disabled(newName.isEmpty)
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
    }
    
    private func saveContext(_ timetable: Timetables) {
        context.insert(timetable)
        try? context.save()
        newName = ""
        isAdding = false
        tempTimetable = .init()
    }
}

#Preview {
    TimetableListView()
        .modelContainer(for: Timetables.self, inMemory: true)
}
