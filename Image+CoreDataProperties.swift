//
//  Image+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 07/10/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var url: String?
    @NSManaged public var image: NSData?

}
