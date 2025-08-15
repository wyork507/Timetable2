//
//  Assignment.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/15.
//

import Foundation
import SwiftData

enum AssignmentType: String {
    case assignment
    case quiz
    case exam
    case fieldwork
}


@Model
class Assignment {
    @Attribute(.unique)
    var id: UUID
    @Relationship(inverse: \Course.assignment)
    var course: Course
    var type: AssignmentType
    var dueDate: Date
    var submit: String
    var isDone: Bool
    var note: String
    
    init(course: Course, type: AssignmentType, dueDate: Date, note: String, submit: String = "Online Course Platform") {
        self.id = UUID()
        self.course = course
        self.type = type
        self.dueDate = dueDate
        self.isDone = false
        self.note = note
    }
}
