//
//  Settings.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/18.
//
//  以 UserDefaults 儲存設定

import Foundation

private let schools: [String] = ["National Taiwan Normal University", "National Taiwan University", "National Taiwan University of Science and Technology"]
private let periods: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "A", "B", "C", "D", "E", "F", "G", "H", "I"]

class UserPreference {
    static let shared = UserPreference()
    private let userDefaults: UserDefaults
    
    private init() {
        userDefaults = UserDefaults.standard
    }
    
    var conditions: Conditions
    var timetable: Timetable
    
}

extension UserPreference {
    struct Conditions {
        var totalCourse: Int {
            get { return userDefaults.integer(forKey: "totalCourse") }
            set { userDefaults.set(newValue, forKey: "totalCourse") }
        }
        var intervals: Int = 0
        var isNameForPeriods: Bool
    }
}

extension UserPreference {
    class Timetable {
    }
}

