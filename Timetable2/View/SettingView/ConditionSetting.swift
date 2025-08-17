//
//  Condition.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//

import SwiftUI
import Observation

private let schools: [String:String] = ["National Taiwan Normal University" : "NTNU" , "National Taiwan University" : "NTU" , "National Taiwan University of Science and Technology": "NTUST"]
private let periods: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "A", "B", "C", "D", "E", "F", "G", "H", "I"]

struct ConditionSetting: View {
    @AppStorage(UserPreferenceOld.Condition.totalCourse.path) var totalCourse: Int = 15
    @AppStorage(UserPreferenceOld.Condition.courseLength.path) var courseLength: Int = 50
    @AppStorage(UserPreferenceOld.Condition.intervals.path) var intervals: Int = 10
    @AppStorage(UserPreferenceOld.Condition.isNameForPeriods.path) var isNameForPeriods: Bool = true
    @AppStorage(UserPreferenceOld.Condition.isSchool.path) var isSchool: Bool = true
    
    @State private var isEditLength: Bool = false
    @State private var viewingNameForPeriods: Bool = false
    @State private var viewingSchoolList: Bool = false
    
    var body: some View {
        NavigationStack{
            List {
                Section {
                    HStack {
                        VStack {
                            Text("Lessons")
                                .font(.subheadline)
                            HStack(alignment: .bottom) {
                                Text("\(totalCourse)")
                                Text("/ day")
                                    .font(.footnote)
                            }
                        }.frame(minWidth: 80.0)
                        Spacer()
                        VStack {
                            Text("Length")
                                .font(.subheadline)
                            HStack(alignment: .bottom) {
                                Text("\(courseLength)")
                                Text("mins")
                                    .font(.footnote)
                            }
                        }.frame(minWidth: 80.0)
                        Spacer()
                        VStack {
                            Text("Breaking")
                                .font(.subheadline)
                            HStack(alignment: .bottom) {
                                Text("\(intervals)")
                                Text("mins")
                                    .font(.footnote)
                            }
                        }.frame(minWidth: 80.0)
                    }.padding(.horizontal, 5.0)
                } footer: {
                    HStack {
                        Spacer()
                        Button(action: {
                            isEditLength.toggle()
                        }) {
                            Text("Edit Value")
                                .font(.footnote)
                        }
                    }
                }.sheet(isPresented: $isEditLength) {
                    ValueEditor(totalCourse: $totalCourse, courseLength: $courseLength, intervals: $intervals)
                        .presentationDetents([.medium])
                }
                Section {
                    Toggle("Custom Period Name",isOn: $isNameForPeriods)
                    NavigationLink {
                        PeriodNameEditor(editable: $isNameForPeriods, total: $totalCourse)
                    } label: {
                        if isNameForPeriods {
                            Label("Edit Names", systemImage: "doc.badge.gearshape")
                        } else {
                            Label("View Names", systemImage: "doc")
                        }
                    }
                } header: { Text("Periods") } footer: {
                    Text("You can set the name for every period, this change the name showing in timetable.")
                }
                Section(){
                    Toggle("School",isOn: $isSchool)
                    NavigationLink {
                        SchoolEditor(editable: $isSchool)
                    } label: {
                        if isSchool {
                            Label("Edit Schools", systemImage: "rectangle.badge.plus")
                        } else {
                            Label("View Schools", systemImage: "rectangle")
                        }
                    }
                } header: { Text("Schools") } footer: {
                    Text("")
                }
            }
            .navigationTitle("Lessons")
        }
    }
}

fileprivate struct ValueEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var totalCourse: Int
    @Binding var courseLength: Int
    @Binding var intervals: Int
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Lessons per Day")
                    HStack {
                        SliderView(min: 8, max: 20, step: 1, value: Double(totalCourse), bindValue: $totalCourse)
                        Text("lessons").frame(width: 75)
                    }
                }
                Section {
                    Text("Lesson length")
                    HStack {
                        SliderView(min: 40, max: 180, step: 5, value: Double(courseLength), bindValue: $courseLength)
                        Text("minutes").frame(width: 75)
                    }
                }
                Section {
                    Text("Default breaking interval")
                    HStack {
                        SliderView(min: 0, max: 20, step: 1, value: Double(intervals), bindValue: $intervals)
                        Text("minutes").frame(width: 75)
                    }
                }
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Editor")
                }
                ToolbarItem (placement: .topBarTrailing) {
                    Button("Done") {dismiss()}
                }
            }
        }
    }
}

fileprivate struct PeriodNameEditor: View {
    @Binding private var isEditable: Bool
    @Binding private var total: Int
    @State private var editIndex: Int?
    @State private var editText: String = ""
    @State private var stringSeries: [String] = UserDefaults.standard.array(forKey: UserPreferenceOld.Condition.nameForPeriods.path) as? [String] ?? periods
    private let numberWidth: CGFloat = 40.0
    private let buttonWidth: CGFloat = 60.0
    
    
    init(editable: Binding<Bool>, total: Binding<Int>) {
        _isEditable = editable
        _total = total
    }
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("No.")
                        .frame(width: numberWidth)
                    Text("Period Name")
                }
                ForEach(0..<total, id: \.self) { index in
                    if isEditable {
                        if index == editIndex {
                            HStack {
                                Text("\(index + 1).")
                                    .frame(width: 40)
                                TextField("New Name", text: $editText)
                                Button(action: { saveEdit() }) {
                                    Text("Done")
                                        .frame(width: 60)
                                }
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        } else {
                            HStack {
                                Text("\(index + 1).")
                                    .frame(width: 40)
                                Text("\(stringSeries[index])")
                                Spacer()
                                Button(action: { startEditing(index: index) }) {
                                    Text("Edit")
                                        .frame(width: 60)
                                }
                            }
                        }
                    } else {
                        HStack {
                            Text("\(index + 1).")
                                .frame(width: 40)
                            Text("\(stringSeries[index])")
                            Spacer()
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Name Editor")
        }
        if !isEditable {
            Label("Read Only", systemImage: "exclamationmark.triangle")
        }
    }
    func startEditing(index: Int) {
        editIndex = index
        editText = stringSeries[index]
    }
    
    func saveEdit() {
        if let index = editIndex, !editText.isEmpty {
            stringSeries[index] = editText
            editIndex = nil
            UserDefaults.standard.set(stringSeries, forKey: UserPreferenceOld.Condition.nameForPeriods.path)
            stringSeries = (UserDefaults.standard.array(forKey: UserPreferenceOld.Condition.nameForPeriods.path) as? [String])!
        }
    }
}

fileprivate struct SchoolEditor: View {
    @Binding private var isEditable: Bool
    @State private var editIndex: Int?
    @State private var editText: String = ""
    @State private var schoolList: [String:String] = UserDefaults.standard.dictionary(forKey: UserPreferenceOld.Condition.schools.path) as? [String:String] ?? schools
    
    @State private var newSchool: String = ""
    @State private var newSchoolAbbr: String = ""
    @State private var previousSchoolList: [String:String] = [:]
    @State private var showingDeleteAlert = false
    @State private var deleteKey: String?
    
    private let abbrWidth: CGFloat   = 70.0
    private let buttonWidth: CGFloat = 60.0
    
    init(editable: Binding<Bool>) {
        _isEditable = editable
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(Array(schoolList.keys.sorted()), id: \.self) { key in
                        HStack {
                            ScrollView(.horizontal){
                                Text("\(key)")
                            }
                            Text(", \(schoolList[key]!)")
                            
                            Button(action: {
                                deleteSchool(key: key)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                } header: { Text("School List") } footer: {
                    Text("Scroll to viewing school full name")
                }
                Section {
                    HStack {
                        TextField("Full Name", text: $newSchool)
                        TextField("(Abbr)", text: $newSchoolAbbr)
                            .frame(width: abbrWidth)
                        Button(action: addNewSchool) {
                            Text("Add")
                        }
                    }
                } header: { Text("Add New School") } footer: {
                    Text("Text only")
                }
            }
            .navigationTitle("School List Edit")
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Delete School"),
                    message: Text("Are you sure you want to delete this school?"),
                    primaryButton: .destructive(Text("Delete")) {
                        reallyDeleteSchool()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    func addNewSchool() {
        if !newSchool.isEmpty && !newSchoolAbbr.isEmpty {
            schoolList[newSchool] = newSchoolAbbr
            newSchool = ""
            newSchoolAbbr = ""
            syncChange()
        }
    }
    
    func deleteSchool(key: String) {
        deleteKey = key
        showingDeleteAlert = true
    }
    
    func reallyDeleteSchool() {
        if let key = deleteKey {
            schoolList[key] = nil
            syncChange()
        }
    }
    
    func syncChange() {
        UserDefaults.standard.set(schoolList, forKey: UserPreferenceOld.Condition.schools.path)
        schoolList = (UserDefaults.standard.dictionary(forKey: UserPreferenceOld.Condition.schools.path) as? [String:String])!
    }
}

struct TimeEditor: View {
    @State private var selectedDate = Date()
    var body: some View {
        Form{
            VStack {
                DatePicker("選擇時間", selection: $selectedDate, displayedComponents: .hourAndMinute)
                //.labelsHidden() // 隱藏標籤，讓DatePicker看起來更簡潔
                    .datePickerStyle(.compact)
            }
            .padding()
        }
    }

    func timeString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

#Preview("Major") {
    ConditionSetting()
}

#Preview("Value Edit") {
    ValueEditor(totalCourse: .constant(20), courseLength: .constant(50), intervals: .constant(20))
}

#Preview("Period Editor") {
    PeriodNameEditor(editable: .constant(false), total: .constant(15))
}

#Preview("School Editor") {
    SchoolEditor(editable: .constant(true))
}

#Preview("Time Editor") {
    TimeEditor()
}
