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
                                TimetableDetailView(timetable: timetable, isPresented: .constant(true))
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
            AddNewTimetalbeView(isPresented: $isAdding)
        }
    }
}

fileprivate struct AddNewTimetalbeView: View {
    @Environment(\.modelContext) private var context
    @Binding var isPresented: Bool
    
    @State private var newName: String = ""
    @State private var newStart = Date()
    @State private var newEnd = Date()
    
    @State private var tempTimetable: Timetables? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Add Timetable") {
                    TextField("Name", text: $newName, prompt: Text("Enter a name"))
                        .frame(width: .infinity)
                    DatePicker("Start", selection: $newStart, displayedComponents: .date)
                    DatePicker("End", selection: $newEnd, displayedComponents: .date)
                    NavigationLink("Continue") {
                        TimetableDetailView(
                            timetable: tempTimetable ?? Timetables(newName, start: newStart, end: newEnd),
                            isPresented: $isPresented
                        ).interactiveDismissDisabled(true)
                    }.disabled(newName.isEmpty || newStart >= newEnd || isContain(newName))
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private func isContain(_ name: String) -> Bool {
        if let result = try? context.fetchCount(
            FetchDescriptor(predicate: #Predicate<Timetables> { $0.name == name })
        ) as Int? {
            return result > 0
        } else {
            return false
        }
    }
}

#Preview("TimetableListView") {
    TimetableListView()
        .modelContainer(for: Timetables.self, inMemory: true)
}

#Preview("AddNewTimetalbeView") {
    AddNewTimetalbeView(isPresented: .constant(true))
}
