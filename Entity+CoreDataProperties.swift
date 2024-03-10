//
//  Entity+CoreDataProperties.swift
//  Timetable2
//
//  Created by 王祐顥 on 2024/1/12.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var code: String?
    @NSManaged public var time: Data?

}

extension Entity : Identifiable {

}
