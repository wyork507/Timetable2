//
//  NotificationSetting.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/15.
//

import SwiftUI

struct NotificationSetting: View {
    @State private var Toogle: Bool = false
    @State private var reminderTime: Int = 20
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    Toggle(isOn: $Toogle) {
                        Label("Push Notification", systemImage: "message")
                    }
                }
                Section(){
                    Toggle(isOn: $Toogle) {
                        Text("Classroom Reminder")
                        Text("\(reminderTime) mins before lesson")
                    }
                    GroupBox(label: Text("Time adjustment")) {
                        
                        SliderView(min: 0, max: 20, step: 1, value: 20.0, bindValue: $reminderTime)
                    }
                    Toggle(isOn: $Toogle) {
                        Text("Task Reminder")
                        Text("\(reminderTime) mins before lesson")
                    }
                    GroupBox(label: Text("Time adjustment")) {
                        Text("a")
                    }
                    Text("Exam Reminder")
                    GroupBox() {
                        Toggle(isOn: $Toogle) {
                            Text("Open")
                            Text("\(reminderTime) mins before lesson")
                        }
                        //time picker
                    }
                }
            }
            .navigationTitle("Notification")
        }
    }
}

#Preview {
    NotificationSetting()
}
