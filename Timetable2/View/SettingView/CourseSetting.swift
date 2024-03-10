//
//  CourseSetting.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/15.
//

import SwiftUI

struct CourseSetting: View {
    @State private var Toogle: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    NavigationLink {
                        UnderConstruction()
                    } label: {
                        Label("Manage Courses", systemImage: "doc.badge.gearshape")
                    }
                    NavigationLink {
                        UnderConstruction()
                    } label: {
                        //input from school system, the gruadation standar, bla
                        Label("Input / Output Courses", systemImage: "doc.on.clipboard")
                    }
                }
                Section(header: Text("Sync")){
                    NavigationLink {
                        UnderConstruction()
                    } label: {
                        Label("Google Drive", systemImage: "g.circle")
                    }
                    NavigationLink {
                        UnderConstruction()
                    } label: {
                        Label("iCloud", systemImage: "icloud")
                    }
                }
            }.navigationTitle("Courses")
        }
    }
}

#Preview {
    CourseSetting()
}

/*
@Model
class Course: Identifiable{
    @Attribute(.unique) var createTime: Date
    @Attribute var courseDetails: Details
    
    init(createTime: Date, courseDetails: Details) {
        self.createTime = createTime
        self.courseDetails = courseDetails
    }
}

extension Course{
    struct Details: Codable {
        var courseInfo: CourseInformation
        var courseTime: CourseTime
        var courseLoc: CourseLocation
    }
}

struct CourseInformation: Codable {
    var semester: Int
    var code: String
    var credit: Float
    var name: String
    var isInterSchool: Bool
}

struct CourseTime: Codable, Hashable {
    var day: Int
    var period: [Int]
}

struct CourseLocation: Codable {
    var school: String?
    var branch: String?
    var classroom: String
}
*/
