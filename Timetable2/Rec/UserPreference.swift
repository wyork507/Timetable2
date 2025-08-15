//
//  UserPreference.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/19.
//

import Foundation

class UserPreference {
    enum Condition: String {
        case totalCourse
        case courseLength
        case intervals
        case isNameForPeriods
        case nameForPeriods
        case isSchool
        case schools
        var path: String {
            return "Condition.\(self.rawValue)"
        }
    }
    enum Timetable: String {
        case active
        enum Week: String {
            case firstDay
            case enabledDay
            case isHorizontalLine
            case isVerticalLine
            var path: String {
                return "Timetable.WeekView.\(self.rawValue)"
            }
        }
        enum DispInfo: String {
            case isFullName
            case isTime
            case isSchool
            case isClassroom
            case isProfessor
            case isWeek
            var path: String {
                return "Timetable.DispInfo.\(self.rawValue)"
            }
        }
        var path: String {
            return "Timetable.\(self.rawValue)"
        }
    }
}

enum DefaultSchools: String, Identifiable {
    case NTNU = "National Taiwan Normal University"
    case NTU = "National Taiwan University"
    case NTUST = "National Taiwan University of Science and Technology"
    
    var id: Self { self }
    var abbr: String { String(describing: self) }
}
