//
//  TimeModule.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/29.
//
import Foundation



enum Weekday: Int {
   
    case sunday = 0 , tuesday, wednesday, thursday, friday, saturday, monday
    static let allCases: [Weekday] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    var strings: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
    var shortString: String {
        return "\(self.strings.prefix(3))"
    }
}

enum TimeSymbol: String {
    case AM
    case PM
}

fileprivate struct Str4Format {
    //Date
    static let year: String = "yyyy" //4 digit, padding
    static let mouth: String = "MM" //2 digit, padding
    static let day: String = "dd" //2 digit, padding
    static let weekday: String = "EEEE" // The wide name of the week
    //Time
    static let for12: String = "a" //AM or PM
    static let hour12: String = "hh" //2 digit, padding
    static let hour24: String = "HH" //2 digit, padding
    static let minute: String = "mm" //2 digit, padding
}

enum FormatStyle {
    case Time12
    case Time24
    var onlyDate: String {
        return "\(Str4Format.year)/\(Str4Format.mouth)/\(Str4Format.day)"
    }
    var onlyTime: String {
        switch self {
        case .Time12:
            return "\(Str4Format.hour12):\(Str4Format.minute)"
        case .Time24:
            return "\(Str4Format.hour12):\(Str4Format.minute)"
        }
    }
    var both: String {
        return "\(self.onlyDate), \(self.onlyTime)"
    }
    var weekday: String {
        return "\(Str4Format.weekday)"
    }
}

fileprivate struct Convertor {
    static func toString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale.current)
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: date)
    }
    static func toDate(string: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale.current)
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.date(from: string)
    }
}

struct Gain {
    //parse into string
    static func weekday(date: Date) -> Weekday {
        let dateString: String = Convertor.toString(date: date, format: FormatStyle.Time24.weekday)
        guard let weekday = Weekday.allCases.first(where: { $0.strings == dateString }) else {
            fatalError("The input Date() not including weekday infomation!")
        }
        return weekday
    }
    static func onlyDate(date: Date, format: FormatStyle = .Time24) -> String {
        return Convertor.toString(date: date, format: format.onlyDate)
    }
    static func onlyTime(date: Date, format: FormatStyle = .Time24) -> String {
        return Convertor.toString(date: date, format: format.onlyTime)
    }
    static func dateTime(date: Date, format: FormatStyle = .Time24) -> String {
        return Convertor.toString(date: date, format: format.both)
    }
}

struct Calc {
    //calculate interval between 2 Date()
    //static func interval(startDate: Date, endDate: Date, format: FormatStyle = .Time24) ->
    //calculate interval between 2 DateComponents()
}

struct From {
    //from string to Date()
    static func onlyDate(dateString: String) -> Date {
        guard let returnDate = Convertor.toDate(string: dateString, format: FormatStyle.Time24.onlyDate) else {
            fatalError("The input string not including date infomation!")
        }
        return returnDate
    }
    static func onlyTime(dateString: String, format: FormatStyle = .Time24) -> Date {
        guard let returnDate = Convertor.toDate(string: dateString, format: format.onlyTime) else {
            fatalError("The input string not including time infomation!")
        }
        return returnDate
    }
    static func dateTime(dateString: String, format: FormatStyle = .Time24) -> Date {
        guard let returnDate = Convertor.toDate(string: dateString, format: format.both) else {
            fatalError("The input string not including date and time infomation!")
        }
        return returnDate
    }
    //from int to DateComponents()
    static func onlyDate(year: Int, month: Int, day: Int) -> DateComponents {
        return DateComponents(year: year, month: month, day: day)
    }
    static func onlyTime(hour: Int, mins: Int) -> DateComponents {
        return DateComponents(hour: hour, minute: mins)
    }
    static func dateTime(year: Int, month: Int, day: Int, hour: Int, mins: Int) -> DateComponents {
        return DateComponents(year: year, month: month, day: day, hour: hour, minute: mins)
    }
    //for int to Date()
    static func onlyDate(year: Int, month: Int, day: Int) -> Date {
        guard let returnDate = Calendar.current.date(from: onlyDate(year: year, month: month, day: day)) else {
            fatalError("The input string not including date infomation!")
        }
        return returnDate
    }
    static func onlyTime(hour: Int, mins: Int) -> Date {
        guard let returnDate = Calendar.current.date(from: onlyTime(hour: hour, mins: mins) ) else {
            fatalError("The input string not including date infomation!")
        }
        return returnDate
    }
    static func dateTime(year: Int, month: Int, day: Int, hour: Int, mins: Int) -> Date {
        guard let returnDate = Calendar.current.date(from: dateTime(year: year, month: month, day: day, hour: hour, mins: mins) ) else {
            fatalError("The input string not including date infomation!")
        }
        return returnDate
    }
}
