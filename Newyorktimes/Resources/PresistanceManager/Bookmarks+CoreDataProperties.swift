//
//  Bookmarks+CoreDataProperties.swift
//  
//
//  Created by omair khan on 22/11/2021.
//
//

import Foundation
import CoreData


extension Bookmarks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmarks> {
        return NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var link: String?
    @NSManaged public var title: String?

}
