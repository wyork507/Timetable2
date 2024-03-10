//
//  DayView.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/24.
//

import SwiftUI
import SwiftData

struct DayView: View {
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            //iPhone end
            NavigationStack {
                CourseRow()
            }
            .listStyle(.plain)
        } else {
            //iPad & mac end
        }
    }
}

private struct CourseRow: View {
    @State private var courseInfo: CourseInfo = CourseInfo()
    
    var body: some View {
        List {
            ForEach(Array(zip(courseInfo.period, courseInfo.periodTime)), id: \.0) { key, value in
                LessonRow(lessonNumber: key, lessonTime: value, courseInfo: courseInfo)
            }
        }
        .refreshable {
            reload()
        }
    }
    private func reload() {
        courseInfo = CourseInfo()
    }
}

private struct CourseInfo {
    let name: String = "文明的變遷"
    let classroom: String = "TR-514"
    let school: String = "NTUST"
    let period: [String] = ["3", "4"]
    let periodTime: [String] = ["10:20 - 11:10", "11:20 - 12:10"]
    let professor: String = "何思眯"
}


private struct LessonRow: View {
    private let lessonNumber: String
    private let lessonTime: String
    private let courseInfo: CourseInfo
    @State private var isViewTime: Bool    = UserDefaults.standard.bool(forKey: UserPreference.Timetable.DispInfo.isTime.path)
    @State private var isSchool: Bool      = UserDefaults.standard.bool(forKey: UserPreference.Timetable.DispInfo.isSchool.path)
    @State private var isProfessor: Bool   = UserDefaults.standard.bool(forKey: UserPreference.Timetable.DispInfo.isProfessor.path)
    
    init(lessonNumber: String = "3", lessonTime: String = "10:20 - 11:10", courseInfo: CourseInfo = CourseInfo()) {
        self.lessonNumber = lessonNumber
        self.lessonTime = lessonTime
        self.courseInfo = courseInfo
        self.reload()
    }
    //for phone end
    private var hasBottomSpace: Bool { return (self.isSchool || self.isViewTime) }
    private var totalHeight: Double { return self.hasBottomSpace ? 50.0 : 30.0}
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            //iPhone end
            VStack {
                HStack {
                    HStack(spacing: 0.0) {
                        VStack {
                            Text(lessonNumber)
                                .font(.title2)
                                .frame(height: 30.0)
                                .padding(.horizontal, 8.0)
                                .foregroundStyle(.white)
                                .background(Color.gray.opacity(0.8))
                            if hasBottomSpace {
                                Text(courseInfo.classroom)
                                    .font(.caption)
                                .bold()
                            }
                        }.frame(width: 60.0)
                        Rectangle()
                            .frame(width: 8.0)
                            .foregroundColor(Color.green)
                    }.frame(height: totalHeight)
                    VStack {
                        HStack (alignment: .bottom) {
                            Text(courseInfo.name)
                                .font(.title)
                            Spacer()
                            if isProfessor {
                                Rectangle()
                                    .frame(width: 2.0)
                                    .foregroundColor(Color.gray)
                                VStack (alignment: .leading, spacing: 0.0) {
                                    Text("Professor")
                                        .font(.caption2)
                                        .frame(alignment: .leading)
                                    Text(courseInfo.professor)
                                        .font(.subheadline)
                                }.frame(width: 60.0)
                            }
                            if !hasBottomSpace {
                                Rectangle()
                                    .frame(width: 2.0)
                                    .foregroundColor(Color.gray)
                                Text(courseInfo.classroom)
                                    .font(.caption)
                                    .frame(width: 60.0)
                            }
                        }.frame(height: 30.0)
                        if hasBottomSpace {
                            HStack (alignment: .firstTextBaseline) {
                                if isSchool {
                                    Text("in \(courseInfo.school)")
                                        .font(.caption)
                                }
                                if isViewTime {
                                    Text("at \(lessonTime)")
                                        .font(.caption)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            .frame(height: totalHeight)
        } else {
            //iPad & mac end
            HStack {
                Text(lessonNumber)
                    .font(.largeTitle)
                    .frame(height: 80.0)
                    .padding(.horizontal, 16.0)
                    .foregroundStyle(.white)
                    .background(Color.gray.opacity(0.8))
                Divider()
                    .frame(minWidth: 12.0)
                    .background(Color.green)
                VStack(alignment: .leading, spacing: 0.0) {
                    Text(courseInfo.name)
                        .font(.largeTitle)
                        .frame(height: 50.0)
                    HStack (alignment: .bottom){
                        
                        VStack (alignment: .leading, spacing: 0.0) {
                            HStack (alignment: .firstTextBaseline){
                                Text(courseInfo.classroom)
                                    .font(.subheadline)
                                if isSchool {
                                    Text("in \(courseInfo.school)")
                                        .font(.caption2)
                                }
                            }
                            if isViewTime {
                                Text("at \(lessonTime)")
                                    .font(.footnote)
                            }
                        }
                        if isProfessor {
                            Divider()
                                .frame(minWidth: 2.0)
                                .background(Color.gray)
                            VStack (alignment: .leading, spacing: 0.0) {
                                Text("Professor")
                                    .font(.caption2)
                                    .frame(alignment: .leading)
                                Text(courseInfo.professor)
                                    .font(.subheadline)
                            }
                        }
                    }.padding(0.0)
                }
                Spacer()
            }
            .frame(height: 100.0)
            .padding(5.0)
        }
    }
    fileprivate static func reload() {
        LessonRow().reload()
    }
    fileprivate func reload() {
        isViewTime = UserDefaults.standard.bool(forKey: UserPreference.Timetable.DispInfo.isTime.path)
        isSchool = UserDefaults.standard.bool(forKey: UserPreference.Timetable.DispInfo.isSchool.path)
        isProfessor = UserDefaults.standard.bool(forKey: UserPreference.Timetable.DispInfo.isProfessor.path)
    }
}


#Preview("Major"){
    DayView()
}

#Preview("Lesson Row"){
    LessonRow()
}

#Preview("Course Row"){
    CourseRow()
}
