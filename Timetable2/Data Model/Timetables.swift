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
    var holidays: [Date]
    
    init(createDate: Date = Date(), name: String, start: Date, end: Date) {
        self.createDate = createDate
        self.name = name
        self.start = start
        self.end = end
        self.holidays = []
    }
}
