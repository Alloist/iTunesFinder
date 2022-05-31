//
//  MediaItems+CoreDataProperties.swift
//  
//
//  Created by Aliaksei Gorodji on 31.05.22.
//
//

import Foundation
import CoreData


extension MediaItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaItems> {
        return NSFetchRequest<MediaItems>(entityName: "MediaItems")
    }

    @NSManaged public var artinstName: String?
    @NSManaged public var artistId: Int64
    @NSManaged public var descriptionText: String?
    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var trackId: Int64
    @NSManaged public var trackName: String?
    @NSManaged public var wrapperType: String?

}
