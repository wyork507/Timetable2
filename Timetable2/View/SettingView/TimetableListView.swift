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
    
    @State private var newName = ""
    @State private var newStart = Date()
    @State private var newEnd = Date()
    @State private var tempTimetable = Timetables()
    
    @State private var isAdding = false
    
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
                                        Text(timetable.start.formatted(date: .numeric, time: .omitted))
                                            .font(.callout)
                                        Text(timetable.end.formatted(date: .numeric, time: .omitted))
                                            .font(.callout)
                                    }
                                } label: {
                                    VStack {
                                        Text(timetable.name)
                                        Text("Created at \(timetable.createDate.formatted(date: .long, time: .omitted)), contains \(timetable.holidays.count.description) holiday(s).")
                                            .font(.caption2)
                                    }
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
                        DatePicker("Start", selection: $newStart, displayedComponents: .date)
                        DatePicker("End", selection: $newEnd, displayedComponents: .date)
                        NavigationLink {
                            TimetableDetailView(timetable: $tempTimetable)
                        } label: {
                            Button("Continue") {
                                tempTimetable = Timetables(
                                    newName,
                                    start: newStart,
                                    end: newEnd
                                )
                            }
                        }.disabled(newName.isEmpty || newStart < newEnd)
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
    
    private func saveContext(_ timetable: Timetables) {
        context.insert(timetable)
        try? context.save()
        newName = ""
        newEnd = Date()
        newStart = Date()
        isAdding = false
        tempTimetable = .init()
    }
}

#Preview {
    TimetableListView()
        .modelContainer(for: Timetables.self, inMemory: true)
}
