//
//  Image+CoreDataClass.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 07/10/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Image)
public class Image: NSManagedObject {

    convenience init(image: NSData, url: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Image", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.image = image
        self.url = url
        
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance().managedObjectContext
        
    }
}
