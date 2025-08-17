//
//  TimetableSetting.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/15.
//

import SwiftUI
import SwiftData

fileprivate let loc = UserPreferenceOld.Timetable.self


struct TimetableSetting: View {
    @AppStorage(loc.active.path)                private var activeTimetable: String = "N/A"
    @AppStorage(loc.Week.firstDay.path)         private var firstDay: Int = 1
    @AppStorage(loc.Week.isHorizontalLine.path) private var isHorizontalLine: Bool = false
    @AppStorage(loc.Week.isVerticalLine.path)   private var isVerticalLine: Bool = false
    @AppStorage(loc.DispInfo.isFullName.path)   private var isFullName: Bool = false
    @AppStorage(loc.DispInfo.isTime.path)       private var isTime: Bool = false
    @AppStorage(loc.DispInfo.isSchool.path)     private var isSchool: Bool = false
    @AppStorage(loc.DispInfo.isClassroom.path)  private var isClassroom: Bool = false
    @AppStorage(loc.DispInfo.isProfessor.path)  private var isProfessor: Bool = false
    @AppStorage(loc.DispInfo.isWeek.path)       private var isWeek: Bool = false
    
    @State private var Toogle: Bool = false
    @State private var selectedDay: Weekday = .monday
    @State private var selectedSemester = "112-1"
        let semesters = ["112-1", "112-2"]
    
    var body: some View {
        NavigationStack{
            List {
                Section {
                    Picker("Active Timetable", selection: $activeTimetable) {
                        ForEach(semesters, id: \.self) {
                            Text($0)
                        }
                    }
                    NavigationLink {
                        TimetableManager()
                    } label: {
                        Label("Manage Timetables", systemImage: "doc.badge.gearshape")
                    }
                }
                Section(header: Text("Weekview")) {
                    Picker("First Day of Week", selection: $selectedDay) {
                        ForEach(Weekday.allCases, id: \.self) {
                            Text($0.strings)
                        }
                    }.onChange(of: selectedDay, {
                        firstDay = selectedDay.rawValue
                    })
                    
                    // NavigationLink(destination: UnderConstruction(), label: {
                    //     LabeledContent("Enabled Days") {
                    //         Text("abc")}
                    // })
                    
                    NavigationLink {
                        EnabledDayEditor()
                    } label: {
                        Label("Enabled Days", systemImage: "calendar.badge.checkmark")
                    }
                }
                
                Section(header: Text("View Layout")) {
                    Toggle(isOn: $isHorizontalLine) {
                        Label("Horizontal Line", systemImage: "square.split.1x2")
                    }
                    Toggle(isOn: $isVerticalLine) {
                        Label("Vertical Line", systemImage: "square.split.2x1")
                    }
                    NavigationLink {
                        PeriodGroupEditor()
                    } label: {
                        Label("Period Groups", systemImage: "rectangle.grid.1x2.fill")
                    }
                }
                Section(header: Text("Display Infomation")){
                    HStack {
                        Text("Name")
                        Spacer()
                        Picker("Name Style", selection: $isFullName){
                            Text("Full Name").tag(true)
                            Text("Abbreviation").tag(false)
                        }
                        .pickerStyle(.palette)
                        .frame(width: 200)
                    }
                    Toggle("Period Time", isOn: $isTime)
                    Toggle("School", isOn: $isSchool)
                    Toggle("Classroom", isOn: $isClassroom)
                    Toggle("Professor", isOn: $isProfessor)
                    Toggle("Weeks", isOn: $isWeek)
                }
                
            }
            .navigationTitle("Timetable")
        }
    }
}
fileprivate struct TimetableManager: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var timetable: [Timetables]
    
    @State private var isShowingAddItemSheet = false
    @State private var isShowingDeleteAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(timetable) {timetable in
                    NavigationLink {
                        TimetableEditor(timetable: timetable)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(timetable.name)
                                    .font(.headline)
                            }
                            HStack {
                                Text(timetable.start, style: .date)
                                Text("~")
                                Text(timetable.end, style: .date)
                            }.font(.footnote)
                        }
                    }
                }.onDelete { indexSet in
                    isShowingDeleteAlert = true
                    let timetableToDelete = timetable[indexSet.first!]
                    modelContext.delete(timetableToDelete)
                }
            }
            .navigationTitle("Timetable Manager")
            .sheet(isPresented: $isShowingAddItemSheet) {
                AddTimetableSheet()
                    .presentationDetents([.medium])
            }
            .toolbar() {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingAddItemSheet = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
    }
}

fileprivate struct AddTimetableSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = .now
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Name")
                    TextField("Adding a new name", text: $name)
                }
                DatePicker("Start", selection: $startDate, displayedComponents: .date)
                DatePicker("End", selection: $endDate, displayedComponents: .date)
            }
            .navigationTitle("New Timetable")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        let timetable = Timetables(name: name, start: startDate, end: endDate)
                        context.insert(timetable)
                    }
                }
            }
        }
    }
}

fileprivate struct TimetableEditor: View {
    @Bindable var timetable: Timetables
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Name")
                    TextField("Adding a new name", text: $timetable.name)
                }
                DatePicker("Start", selection: $timetable.start, displayedComponents: .date)
                DatePicker("End", selection: $timetable.end, displayedComponents: .date)
                Text("Created at \(Gain.dateTime(date: timetable.createDate, format: .Time24)).")
            }
            .navigationTitle("Timetable Editor")
            Text("Created at \(Gain.dateTime(date: timetable.createDate, format: .Time24)).")
        }
    }
}



fileprivate struct EnabledDayEditor: View {
    @AppStorage("\(loc.Week.enabledDay.path)0") var enabledDay0: Bool = false
    @AppStorage("\(loc.Week.enabledDay.path)1") var enabledDay1: Bool = true
    @AppStorage("\(loc.Week.enabledDay.path)2") var enabledDay2: Bool = true
    @AppStorage("\(loc.Week.enabledDay.path)3") var enabledDay3: Bool = true
    @AppStorage("\(loc.Week.enabledDay.path)4") var enabledDay4: Bool = true
    @AppStorage("\(loc.Week.enabledDay.path)5") var enabledDay5: Bool = true
    @AppStorage("\(loc.Week.enabledDay.path)6") var enabledDay6: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Toggle(isOn: $enabledDay1) {
                    Label(Weekday(rawValue: 1)!.strings, systemImage: "1.circle")
                }
                Toggle(isOn: $enabledDay2) {
                    Label(Weekday(rawValue: 2)!.strings, systemImage: "2.circle")
                }
                Toggle(isOn: $enabledDay3) {
                    Label(Weekday(rawValue: 3)!.strings, systemImage: "3.circle")
                }
                Toggle(isOn: $enabledDay4) {
                    Label(Weekday(rawValue: 4)!.strings, systemImage: "4.circle")
                }
                Toggle(isOn: $enabledDay5) {
                    Label(Weekday(rawValue: 5)!.strings, systemImage: "5.circle")
                }
                Toggle(isOn: $enabledDay6) {
                    Label(Weekday(rawValue: 6)!.strings, systemImage: "6.circle")
                }
                Toggle(isOn: $enabledDay0) {
                    Label(Weekday(rawValue: 0)!.strings, systemImage: "7.circle")
                }
            }
            .listStyle(.plain)
            .navigationTitle("Enabled Day Editor")
        }
    }
}

fileprivate struct PeriodGroupEditor: View {
    var body: some View {
        NavigationStack {
            Text("Hello")
        }
    }
}

#Preview("Major") {
    TimetableSetting()
}

#Preview("Timetable Manager") {
    TimetableManager()
}

#Preview("Enabled Day Editor"){
    EnabledDayEditor()
}

#Preview("Group Editor") {
    PeriodGroupEditor()
}
