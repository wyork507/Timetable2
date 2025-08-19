//
//  UserPreference.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/19.
//

import Foundation

struct UserPreference {
    private static let ud: UserDefaults = .standard
    
    @Observable // MARK: Genral Settings
    class General {
        // Under DEV
        var isEnableDarkMode: Bool { didSet {
            ud.set(isEnableDarkMode, forKey: "isEnableDarkMode")
        }}
        
        // Under DEV
        var language: Locale.LanguageCode { didSet {
            ud.set(language, forKey: "language")
        }}
        
        @ObservationIgnored
        var lauguageDisplayName: String { get {
            return Locale.current.localizedString(forLanguageCode: language.identifier)!
        }}
        
        ///
        var activedTimetable: String? { didSet {
            ud.set(activedTimetable, forKey: "activedTimetable")
        }}
        
        init() {
            self.isEnableDarkMode = ud.bool(forKey: "isEnableDarkMode")
            self.language = ud.object(forKey: "language") as? Locale.LanguageCode ?? .english
            self.activedTimetable = ud.string(forKey: "activedTimetable")
        }
    }
    
    // MARK: Display Settings
    struct Display {
        @Observable // 
        class Status {
            ///
            /// Domain [0, 6]
            var firstDay: Int { didSet {
                ud.set(firstDay, forKey: "firstDay")
            }}
            
            ///
            var enabledDays: [Bool] { didSet {
                ud.set(enabledDays, forKey: "enabledDays")
            }}
            
            ///
            var showPeriodTime: Bool { didSet {
                ud.set(showPeriodTime, forKey: "showPeriodTime")
            }}
            
            init() {
                self.firstDay = ud.integer(forKey: "firstDay")
                self.enabledDays = ud.array(forKey: "enabledDays") as? [Bool] ?? Array(repeating: true, count: 7)
                self.showPeriodTime = ud.bool(forKey: "showPeriodTime")
            }
        }
        
        @Observable //
        class Layout {
            ///
            var isHorizontalLine: Bool { didSet {
                ud.set(isHorizontalLine, forKey: "isHorizontalLine")
            }}
            
            ///
            var isVerticalLine: Bool { didSet {
                ud.set(isVerticalLine, forKey: "isVerticalLine")
            }}
            
            ///
            var showWeekSequence: Bool { didSet {
                ud.set(showWeekSequence, forKey: "showWeekSequence")
            }}
            
            init() {
                self.isHorizontalLine = ud.bool(forKey: "isHorizontalLine")
                self.isVerticalLine = ud.bool(forKey: "isVerticalLine")
                self.showWeekSequence = ud.bool(forKey: "showWeekSequence")
            }
        }
        
        @Observable //
        class Infomation {
            ///
            var showFullName: Bool { didSet {
                ud.set(showFullName, forKey: "showFullName")
            }}
            
            ///
            var showProfessor: Bool { didSet {
                ud.set(showProfessor, forKey: "showProfessor")
            }}
            
            ///
            var showTime: Bool { didSet {
                ud.set(showTime, forKey: "showTime")
            }}
            
            ///
            var showPeriods: Bool { didSet {
                ud.set(showPeriods, forKey: "showPeriods")
            }}
            
            ///
            var showBranch: Bool { didSet {
                ud.set(showBranch, forKey: "showBranch")
            }}
            
            ///
            var showSchool: Bool { didSet {
                ud.set(showSchool, forKey: "showSchool")
            }}
            
            init() {
                self.showFullName = ud.bool(forKey: "showFullName")
                self.showProfessor = ud.bool(forKey: "showProfessor")
                self.showTime = ud.bool(forKey: "showTime")
                self.showPeriods = ud.bool(forKey: "showPeriods")
                self.showBranch = ud.bool(forKey: "showBranch")
                self.showSchool = ud.bool(forKey: "showSchool")
            }
        }
    }
    
    @Observable // MARK: Notification Settings
    class Notification {
        ///
        var isEnabled: Bool { didSet {
            ud.set(isEnabled, forKey: "isEnabledNotification")
        }}
        
        ///
        
        init() {
            self.isEnabled = ud.bool(forKey: "isEnabledNotification")
        }
    }
    
    @Observable // MARK: Widget Settings
    class Widget {
        
    }
}



class UserPreferenceOld {
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

enum DefaultSchools: String, Identifiable, Codable {
    case NTNU = "National Taiwan Normal University"
    case NTU = "National Taiwan University"
    case NTUST = "National Taiwan University of Science and Technology"
    
    var id: Self { self }
    var abbr: String { String(describing: self) }
}
