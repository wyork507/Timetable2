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
    var timetable: Timetables
    
    var name: String
    var abbr: String
    var professor: String
    var classroom: String
    var campus: String?
    
    var dayNum: Int // 0-6
    var periods: [Period]
    
    @Relationship(deleteRule: .nullify)
    var school: School
    @Relationship(deleteRule: .cascade)
    var assignment: [Assignment]
    
    init(timetable: Timetables, name: String, abbr: String, professor: String, classroom: String, dayNum: Int, periods: [Period], school: School, campus: String? = nil) {
        self.createTime = Date()
        self.timetable = timetable
        self.name = name
        self.abbr = abbr
        self.professor = professor
        self.classroom = classroom
        self.dayNum = dayNum
        self.periods = periods
        self.school = school
        self.assignment = []
        
        if let campus = campus,
           school.campuses.contains(campus){
            self.campus = campus
        } else {
            fatalError("Invalid campus for \(school.name)")
        }
    }
}
