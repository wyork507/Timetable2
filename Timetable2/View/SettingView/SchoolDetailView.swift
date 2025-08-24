//
//  SchoolDetailView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/19.
//

import SwiftUI
import SwiftData

struct SchoolDetailView: View {
    @Environment(\.modelContext) private var context
    @Bindable var school: School
    @Binding var isPresented: Bool
    
    @State private var newCampus = ""
    
    @State private var newPeriodName = ""
    @State private var newStart = Date()
    @State private var newEnd = Date()
    
    @State private var showEditPeriod = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    Text(school.name)
                }
                Section("Campuses") {
                    ForEach(school.campuses, id:\.self) { campus in
                        Text(campus)
                    }.onDelete { indexSet in
                        school.campuses.remove(atOffsets: indexSet)
                    }
                    HStack {
                        TextField(
                            "Add Campus",
                            text: $newCampus,
                            prompt: Text("Input new campus name")
                        )
                        Button("Add", systemImage: "plus") {
                            school.campuses.append(newCampus)
                            newCampus = ""
                        }.disabled(newCampus.isEmpty)
                    }
                }
                Section("Schdule") {
                    ForEach(Array(school.schedule.sorted{ $0.start < $1.start }.enumerated()), id: \.element.name) { index, period in
                        LabeledContent {
                            VStack {
                                Text(period.start.formatted(date: .omitted, time: .shortened))
                                    .font(.callout)
                                Text(period.end.formatted(date: .omitted, time: .shortened))
                                    .font(.callout)
                            }
                        } label: {
                            VStack {
                                Text("No. \(index)")
                                    .font(.caption2)
                                Text(period.name)
                                    .font(.headline)
                            }
                        }
                        .frame(height: 38)
                        .swipeActions(edge: .trailing) {
                            Button("Delete", systemImage: "trash") {
                                school.schedule.remove(at: index)
                            }.tint(.red)
                            Button("Edit", systemImage: "pencil") {
                                newPeriodName = period.name
                                newStart = period.start
                                newEnd = period.end
                                showEditPeriod = true
                            }
                        }
                    }
                    Button("Add Period", systemImage: "plus") {
                        showEditPeriod = true
                    }.frame(height: 38)
                }
            }
        }
        .navigationTitle("School Detail")
        .sheet(isPresented: $showEditPeriod) {
            NavigationStack {
                Form {
                    Section {
                        TextField("Period Name", text: $newPeriodName)
                        HStack {
                            DatePicker("Start", selection: $newStart, displayedComponents: .hourAndMinute)
                            DatePicker("End", selection: $newEnd, displayedComponents: .hourAndMinute)
                        }
                    }
                }
                .navigationTitle("Period Editor")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            resetNewPeriod()
                            showEditPeriod = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let newPeriod = Period(name: newPeriodName, start: newStart, end: newEnd)
                            school.schedule.append(newPeriod)
                            resetNewPeriod()
                            showEditPeriod = false
                        }
                        .disabled(newPeriodName.isEmpty || newEnd <= newStart)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    context.insert(school)
                    try? context.save()
                    isPresented = false
                }
            }
        }
    }
    
    private func resetNewPeriod() {
        newPeriodName = ""
        newStart = Date()
        newEnd = Date()
    }
}


#Preview {
    @Previewable @State var school = School(.NTNU)
    NavigationStack {
        SchoolDetailView(school: school, isPresented: .constant(true))
    }
}
