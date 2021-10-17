//
//  JokeStorage+CoreDataProperties.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 03.10.2021.
//
//

import Foundation
import CoreData


extension JokeStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JokeStorage> {
        return NSFetchRequest<JokeStorage>(entityName: "JokeStorage")
    }

    @NSManaged public var category: String?
    @NSManaged public var type: String?
    @NSManaged public var setup: String?
    @NSManaged public var delivery: String?
    @NSManaged public var joke: String?
    @NSManaged public var id: Int16
    @NSManaged public var flag: FlagsStorage?

}

extension JokeStorage : Identifiable {

}
