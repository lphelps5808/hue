//
//  BridgeManager.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/7/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import Foundation
import UIKit

private let _bridgeManagerSharedInstance = BridgeManager()

class BridgeManager {
    
    let urlAddress = "http://192.168.5.119/api/newdeveloper"
    let lightsAddress = "http://192.168.5.119/api/newdeveloper/lights"
    var opQueue = NSOperationQueue()
    
    class var sharedInstance: BridgeManager {
        return _bridgeManagerSharedInstance
    }
    
    func showErrorController(message : String, presenter: UIViewController) {
        let alert = UIAlertController(title: "We're Sorry", message: message, preferredStyle: .Alert)
        let actionObj = UIAlertAction(title: "Okay", style: .Default) { (action) -> Void in
            presenter.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(actionObj)
        presenter.presentViewController(alert, animated: true, completion: nil)
    }
    
    func seeLights(completion: ([Lights]?, NSError?) -> Void) {
        var lightsURL : NSURL = NSURL(string: lightsAddress)
        var request : NSURLRequest = NSURLRequest(URL: lightsURL)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: opQueue) { (response, data, error) -> Void in
            if error == nil {
                var lights: [Lights] = []
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String:AnyObject] {
                    for (key, value) in json {
                        var on: Bool = false
                        var hue: Int = 0
                        var bri: Int = 0
                        var sat: Int = 0
                        if let state = value["state"] as? [String:AnyObject] {
                            if let potentialOn = state["on"]! as? Int {
                                if potentialOn == 1 {
                                    on = true
                                }
                            }
                            hue = state["hue"]! as Int
                            bri = state["bri"]! as Int
                            sat = state["sat"]! as Int
                        }
                        lights.append(Lights(modelid: key, name: value["name"] as String?, state: on, hue: hue, bri: bri, sat : sat))
                    }
                    completion(lights, nil)
                } else {
                    let error = NSError(domain: "com.laura.hue", code: 2, userInfo: nil)
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    func configureLight(lightID: String, state: Bool) {
        let urlString = urlAddress + "/lights/\(lightID)/state"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        
        let dictionaryBody = ["on" : state]
        let data = NSJSONSerialization.dataWithJSONObject(dictionaryBody, options: nil, error: nil)!
        request.HTTPBody = data
        
        NSURLConnection.sendAsynchronousRequest(request, queue: opQueue) { (response, data, error) -> Void in
            let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)!
            println(json)
        }
    }
    
    func changeColor(hue: Int, lightID: String){
        let urlString = urlAddress + "/lights/\(lightID)/state"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
    
        let dictionaryC = ["hue" : hue]
        let data = NSJSONSerialization.dataWithJSONObject(dictionaryC, options: nil, error: nil)!
        request.HTTPBody = data
        
        NSURLConnection.sendAsynchronousRequest(request, queue: opQueue) { (response, data, error) -> Void in
            let json : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)!
            
            //println(json)
        }
    }
    
    func changeSaturation(sat: Int, lightID: String){
        let urlString = urlAddress + "/lights/\(lightID)/state"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        
        let dictionaryS = ["sat" : sat]
        
        let satData = NSJSONSerialization.dataWithJSONObject(dictionaryS, options: nil, error: nil)!
        request.HTTPBody = satData
        
       NSURLConnection.sendAsynchronousRequest(request, queue: opQueue) { (response, data, error) -> Void in
            let json : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)!
            
            println(json)
        }
    }
    
    
    func changeBrightness(bri: Int, lightID: String){
        let urlString = urlAddress + "/lights/\(lightID)/state"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        
        let dictionaryB = ["bri" : bri]
        
        let satData = NSJSONSerialization.dataWithJSONObject(dictionaryB, options: nil, error: nil)!
        request.HTTPBody = satData
        
        NSURLConnection.sendAsynchronousRequest(request, queue: opQueue) { (response, data, error) -> Void in
            let json : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)!
        }
    }
    
    
}