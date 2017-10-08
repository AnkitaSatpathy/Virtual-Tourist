//
//  Pin+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 07/10/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double

}
