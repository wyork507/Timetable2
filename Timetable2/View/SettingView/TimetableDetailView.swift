//
//  TimetableDetailView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/19.
//

import SwiftUI
import SwiftData

struct TimetableDetailView: View {
    @Environment(\.modelContext) private var context
    @Bindable var timetable: Timetables
    @Binding var isPresented: Bool
    
    @State private var newName = ""
    @State private var newStart = Date()
    @State private var newEnd = Date()
    
    @State private var showEditHoliday = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Nmae") {
                    NavigationLink {
                        NavigationStack {
                            Form {
                                Section {
                                    TextField("Name", text: $timetable.name)
                                    DatePicker("Start", selection: $timetable.start, displayedComponents: .date)
                                    DatePicker("End", selection: $timetable.end, displayedComponents: .date)
                                }
                            }
                        }.navigationTitle(Text("Timetable Info Editor"))
                    } label: {
                        LabeledContent {
                            VStack {
                                Text(timetable.start.formatted(date: .numeric, time: .omitted))
                                    .font(.callout)
                                Text(timetable.end.formatted(date: .numeric, time: .omitted))
                                    .font(.callout)
                            }
                        } label: {
                            Text(timetable.name)
                            Text("Created at \(timetable.createDate.formatted(date: .long, time: .omitted))")
                                .font(.caption)
                            Text("Tap to edit its name and time range.")
                                .font(.caption2)
                        }
                    }.frame(height: 38)
                    
                }
                Section("Holidays") {
                    ForEach(Array(timetable.holidays.enumerated()), id: \.element.start) { index, holiday in
                        LabeledContent {
                            VStack {
                                Text(holiday.start.formatted(date: .numeric, time: .omitted))
                                    .font(.callout)
                                Text(holiday.end.formatted(date: .numeric, time: .omitted))
                                    .font(.callout)
                            }
                        } label: {
                            VStack {
                                Text("No. \(index)")
                                    .font(.caption2)
                                Text(holiday.name)
                                    .font(.headline)
                            }
                        }
                        .frame(height: 38)
                        .swipeActions(edge: .trailing) {
                            Button("Delete", systemImage: "trash") {
                                timetable.holidays.remove(at: index)
                            }.tint(.red)
                            Button("Edit", systemImage: "pencil") {
                                newName = holiday.name
                                newStart = holiday.start
                                newEnd = holiday.end
                                showEditHoliday = true
                            }
                        }
                    }
                    Button("Add Holiday", systemImage: "plus") {
                        showEditHoliday = true
                    }.frame(height: 38)
                }
                Section("Courses") {
                    if timetable.courses.isEmpty {
                        Text("No courses")
                    } else {
                        ForEach(timetable.courses, id: \.name) { course in
                            Text(course.name)
                        }
                    }
                }
            }
        }
        .navigationTitle("Timetable Detail")
        .sheet(isPresented: $showEditHoliday) {
            NavigationStack {
                Form {
                    Section {
                        TextField("Holiday Name", text: $newName)
                        HStack {
                            DatePicker("Start", selection: $newStart, displayedComponents: .date)
                            DatePicker("End", selection: $newEnd, displayedComponents: .date)
                        }
                    }
                }
                .navigationTitle("Holiday Editor")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            resetNewHoliday()
                            showEditHoliday = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let newHoliday = Holiday(name: newName, start: newStart, end: newEnd)
                            timetable.holidays.append(newHoliday)
                            timetable.holidays.sort { $0.start < $1.start } //BUG, not apply to old data
                            resetNewHoliday()
                            showEditHoliday = false
                        }
                        .disabled(newName.isEmpty || newEnd <= newStart)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    context.insert(timetable)
                    try? context.save()
                    isPresented = false
                }
            }
        }
    }
    
    private func resetNewHoliday() {
        newName = ""
        newStart = Date()
        newEnd = Date()
    }
}


#Preview {
    @Previewable @State var timetable = Timetables(
        "Test",
        start: Date(),
        end: Calendar.current.date(byAdding: DateComponents(month: 3), to: Date())!
    )
    TimetableDetailView(timetable: timetable, isPresented: .constant(true))
}
