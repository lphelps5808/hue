//
//  LightPreset.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/15/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import Foundation
import CoreData

@objc(LightPreset)
class LightPreset: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var hue: NSNumber
    @NSManaged var brightness: NSNumber
    @NSManaged var saturation: NSNumber

}
