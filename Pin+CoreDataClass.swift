//
//  Pin+CoreDataClass.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 07/10/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Pin)
public class Pin: NSManagedObject {
    convenience init(latitude: Double, longitude: Double, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Pin", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance().managedObjectContext
        
    }
}
