//
//  Course.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//

import Foundation
import SwiftData

private struct CourseInfo {
    let name: String = "文明的變遷"
    let classroom: String = "TR-514"
    let school: String = "NTUST"
    let period: [String] = ["3", "4"]
    let periodTime: [String] = ["10:20 - 11:10", "11:20 - 12:10"]
    let professor: String = "何思眯"
}

@Model
class Course: Identifiable{
    var createTime = Date()
    var name: String
    var abbr: String
    
    
    var periods: [Int]?
    var professor: String?
    var school: String
    var timetable: String?
    var courseDetails: Details
    
    init(createTime: Date, name: String, abbr: String, school: String, timetable: String? = nil, courseDetails: Details) {
        self.createTime = createTime
        self.name = name
        self.abbr = abbr
        self.school = school
        self.timetable = timetable
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
