//
//  ConditionSettings.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//
import Foundation
import SwiftData
import SwiftUI

private let schools: [String] = ["National Taiwan Normal University", "National Taiwan University", "National Taiwan University of Science and Technology"]
private let periods: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "A", "B", "C", "D", "E", "F", "G", "H", "I"]

@Model
final class Condition {
    //一天節數
    var totalCourse: Int
    //一節長度
    var courseLength: Int
    //下課時長
    var intervals: Int
    //節次名？
    var isNameForPeriods: Bool
    //學校列表
    var nameForPeriods: [String]
    
    var school: [String]
    
    init(totalCourse: Int = 15, courseLength: Int = 50, intervals: Int = 10,
         isNameForPeriods: Bool = false, school: [String] = schools, periods: [String] = periods) {
        self.totalCourse = totalCourse
        self.courseLength = courseLength
        self.intervals = intervals
        self.isNameForPeriods = isNameForPeriods
        self.school = school
        self.nameForPeriods = periods
    }
}

