//
//  CourseInfo+CoreDataProperties.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//
//

import Foundation
import CoreData


extension CourseInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseInfo> {
        return NSFetchRequest<CourseInfo>(entityName: "CourseInfo")
    }

    @NSManaged public var code: String?
    @NSManaged public var credit: Int16
    @NSManaged public var interSchool: Bool
    @NSManaged public var name: String?

}

extension CourseInfo : Identifiable {

}
