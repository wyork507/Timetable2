//
//  School.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/15.
//

import Foundation
import SwiftData

@Model
class School {
    var name: String
    var schedule: [Period]
    var campuses: [String]
    
    init(name: String, schedule: [Period]) {
        self.name = name
        self.schedule = schedule
        self.campuses = []
    }
    
    init(_ schoolName: DefaultSchools) {
        self.name = schoolName.rawValue
        self.schedule = parseSchdules4School(school: schoolName)
        self.campuses = {
            switch schoolName {
            case .NTNU:
                return ["Gongguan", "Heping", "Linkou"]
            case .NTU:
                return ["Main", "Shuiyuan", "Downtowm", "Chupei", "Yuilin"]
            case .NTUST:
                return ["Main", "Huaxia"]
            }
        }()
    }
}

struct Period: Codable {
    var name: String
    var start: Date
    var end: Date
}

// MARK: Read & Process Default
fileprivate func parseSchdules4School(school: DefaultSchools) -> [Period] {
    struct PlistPeriodsData: Codable {
        let Name: String
        let Start: String
        let End: String
    }
    
    typealias PlistData = [String: [PlistPeriodsData]]
    
    guard let path = Bundle.main.path(forResource: "DefaultSchools", ofType: "plist"),
          let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
          let plistData = try? PropertyListDecoder().decode(PlistData.self, from: data) else {
        fatalError("Error for parsing DefaultSchools.plist")
    }
    
    guard let rawSchedule = plistData[school.abbr] else {
        fatalError("Invalid school name: \(school.abbr) , valid names are: NTNU, NTU, NTUST")
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    let schdule = rawSchedule.map { plistPeriod in
        guard let start = dateFormatter.date(from: plistPeriod.Start),
              let end = dateFormatter.date(from: plistPeriod.End) else {
            fatalError("Failed to parse data for period: \(plistPeriod.Name)")
        }
        return Period(name: plistPeriod.Name, start: start, end: end)
    }
    
    return schdule
}
