//
//  DisplayInfoSettingView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/18.
//

import SwiftUI

fileprivate let previewData = Course(
    timetable: .init("114-1",
                     start: DateComponents(year: 2025, month: 9, day: 1).date!,
                     end: DateComponents(year: 2025, month: 12, day: 20).date!),
    name: "大學入門（師大小大師）",
    abbr: "大學入門",
    professor: "小大獅",
    classroom: "誠201",
    dayNum: 3,
    periods: [School(.NTNU).schedule[3], School(.NTNU).schedule[4]],
    school: .init(.NTNU),
    campus: "Heping"
)

struct DisplayInfoSettingView: View {
    @State private var infoSetting = UserPreference.Display.Infomation()
    
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent {
                    Picker("Display Course as", selection: $infoSetting.showFullName) {
                        Text("Abbreviation").tag(false)
                        Text("Full Name").tag(true)
                    }.pickerStyle(.palette)
                } label: {
                    Text("Name as")
                        .frame(minWidth: 100, alignment: .leading)
                }
                Toggle("Professor", isOn: $infoSetting.showProfessor)
                Toggle("Time",isOn: $infoSetting.showTime)
                Toggle("Periods", isOn: $infoSetting.showPeriods)
                Toggle("Branch", isOn: $infoSetting.showBranch)
                Toggle("School", isOn: $infoSetting.showSchool)
            }
        }.navigationTitle(Text("Display Information Setting"))
    }
}

#Preview {
    DisplayInfoSettingView()
}
