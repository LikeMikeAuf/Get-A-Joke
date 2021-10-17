//
//  FlagsStorage+CoreDataProperties.swift
//  Get a Joke
//
//  Created by Михаил Лоюк on 03.10.2021.
//
//

import Foundation
import CoreData


extension FlagsStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlagsStorage> {
        return NSFetchRequest<FlagsStorage>(entityName: "FlagsStorage")
    }

    @NSManaged public var nsfw: Bool
    @NSManaged public var religious: Bool
    @NSManaged public var political: Bool
    @NSManaged public var racist: Bool
    @NSManaged public var sexist: Bool
    @NSManaged public var explicit: Bool
    @NSManaged public var matchingJokes: NSSet?

}

// MARK: Generated accessors for matchingJokes
extension FlagsStorage {

    @objc(addMatchingJokesObject:)
    @NSManaged public func addToMatchingJokes(_ value: JokeStorage)

    @objc(removeMatchingJokesObject:)
    @NSManaged public func removeFromMatchingJokes(_ value: JokeStorage)

    @objc(addMatchingJokes:)
    @NSManaged public func addToMatchingJokes(_ values: NSSet)

    @objc(removeMatchingJokes:)
    @NSManaged public func removeFromMatchingJokes(_ values: NSSet)

}

extension FlagsStorage : Identifiable {

}
