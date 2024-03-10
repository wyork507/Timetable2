//
//  CourseEditor.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//
/*
import SwiftUI
import SwiftData

// 使用 SwiftUI 來創建一個視圖，用於顯示和編輯課程信息
struct CourseView: View {
    @State private var isSho

    var body: some View {
        Form {
            Section(header: Text("課程信息")) {
                DatePicker("創建時間", selection: $course.createTime)
                TextField("學期", value: $course.courseDetails.courseInfo.semester, formatter: NumberFormatter())
                TextField("代碼", text: $course.courseDetails.courseInfo.code)
                TextField("學分", value: $course.courseDetails.courseInfo.credit, formatter: NumberFormatter())
                TextField("名稱", text: $course.courseDetails.courseInfo.name)
                Toggle("是否跨校", isOn: $course.courseDetails.courseInfo.isInterSchool)
            }

            Section(header: Text("課程時間")) {
                TextField("天", value: $course.courseDetails.courseTime.day, formatter: NumberFormatter())
                // 這裡假設你只有一個時段，如果有多個時段，你可能需要使用 ForEach 或其他方法來處理
                TextField("時段", value: $course.courseDetails.courseTime.period[0], formatter: NumberFormatter())
            }

            Section(header: Text("課程地點")) {
                TextField("學校", text: Binding(
                    get: { course.courseDetails.courseLoc.school ?? "" },
                    set: { course.courseDetails.courseLoc.school = $0.isEmpty ? nil : $0 }
                ))
                TextField("分校", text: Binding(
                    get: { course.courseDetails.courseLoc.branch ?? "" },
                    set: { course.courseDetails.courseLoc.branch = $0.isEmpty ? nil : $0 }
                ))
                TextField("教室", text: $course.courseDetails.courseLoc.classroom)
            }
        }
    }
}
*/
