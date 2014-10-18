//
//  CDMgr.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/15/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import Foundation
import CoreData

private let _sharedCDMgrInstance = CDMgr()

class CDMgr {
    
    var context: NSManagedObjectContext!
    
    init() {}
    
    class var sharedInstance: CDMgr {
        return _sharedCDMgrInstance
    }
    
    func savePreset(name: String, hue: Double, sat: Double, bri: Double) {
        
        println(__FUNCTION__)
        
        var preset = NSEntityDescription.insertNewObjectForEntityForName("LightPreset", inManagedObjectContext: context) as LightPreset
        preset.name = name
        preset.hue = hue
        preset.saturation = sat
        preset.brightness = bri
        context.save(nil)
    }
    
    func procurePresets() -> [LightPreset] {
        let fetchRequest = NSFetchRequest(entityName: "LightPreset")
        fetchRequest.fetchBatchSize = 0
        var objects = self.context.executeFetchRequest(fetchRequest, error: nil) as [LightPreset]
        return objects
    }
}