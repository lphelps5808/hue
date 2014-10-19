//
//  Lights.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/7/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import Foundation

@objc protocol LightsDelegateProtocol {
    func didChangeState()
}

class Lights {
    
    weak var delegate: LightsDelegateProtocol?
    
    var modelid : String?
    var name : String?
    var state : Bool?
    var hue: Int! {
        didSet {
            self.delegate?.didChangeState()
        }
    }
    var bri: Int! {
        didSet {
            self.delegate?.didChangeState()
        }
    }
    var sat: Int! {
        didSet {
            self.delegate?.didChangeState()
        }
    }
    
    var description: String {
        get {
            var string = ""
            if let name = self.name {
                string += "\(name) "
            }
            if let state = self.state {
                string += "\(state) "
            }
            if let modelid = self.modelid {
                string += "\(modelid) "
            }
            string += "\(hue)"
            return string + NSString(string: "\n")
        }
    }
    
    init(modelid: String?, name: String?, state: Bool?, hue: Int, bri: Int, sat: Int) {
        self.modelid = modelid
        self.name = name
        self.state = state
        self.hue = hue
        self.bri = bri
        self.sat = sat
    }
    
}