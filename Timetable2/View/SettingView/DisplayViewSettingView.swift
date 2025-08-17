//
//  DisplayViewSettingView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/17.
//

import SwiftUI

struct DisplayViewSettingView: View {
    @State private var statusSetting = UserPreference.Display.Status()
    @State private var layoutSetting = UserPreference.Display.Layout()
    
    private var weekdaySymbols: [String] { get {
        Calendar.current.weekdaySymbols
    }}
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Status") {
                    Picker("First Day of Week", selection: $statusSetting.firstDay) {
                        ForEach(0..<7) { i in
                            Text(weekdaySymbols[i]).tag(i)
                        }
                    }
                    NavigationLink {
                        List {
                            ForEach($statusSetting.enabledDays.indices, id: \.self) { i in
                                Toggle(weekdaySymbols[i], isOn: $statusSetting.enabledDays[i])
                            }
                        }.navigationTitle("Enabled Days")
                    } label: {
                        LabeledContent {
                            EmptyView()
                        } label: {
                            Text("Enabled Days")
                        }
                    }
                    Toggle("Show Period Time", isOn: $statusSetting.showPeriodTime)
                }
                Section("Layout") {
                    Toggle("Horizontal Line",isOn: $layoutSetting.isHorizontalLine)
                    Toggle("Vertical Line", isOn: $layoutSetting.isVerticalLine)
                    Toggle("Show Week Sequence", isOn: $layoutSetting.showWeekSequence)
                }
            }
        }.navigationTitle(Text("Viewing Setting"))
    }
}

#Preview {
    DisplayViewSettingView()
}
