//
//  Period.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/30.
//

import Foundation
import SwiftData

@Model
class Timetables {
    var createDate: Date
    var name: String
    var start: Date
    var end: Date
    var holidays: [Holiday]
    
    @Relationship(deleteRule: .deny)
    var courses: [Course]
    
    var isVoid: Bool
    
    init(_ name: String, start: Date, end: Date) {
        self.createDate = Date()
        self.name = name
        self.start = start
        self.end = end
        self.holidays = []
        self.courses = []
        self.isVoid = false
    }
    
    init() {
        self.createDate = Date()
        self.name = "N/A"
        self.start = Date()
        self.end = Date()
        self.holidays = []
        self.courses = []
        self.isVoid = true
    }
}

struct Holiday: Codable {
    var name: String
    var start: Date
    var end: Date
    
    var getDates: [Date] {
        var dates: [Date] = []
        var date = start
        while date <= end {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        return dates
    }
}
