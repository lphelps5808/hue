//
//  ViewController.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/7/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var light: Lights!
    
    
    
    
    let kMinStep: Int = 10
    
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var buttonOne: UIButton!
    var buttonTwo: UIButton!
    var buttonThree: UIButton!
    
    var slider: UISlider!
    var satSlider: UISlider!
    var sat: Int = 255
    var configuredSat: Int = 255
    let bridgeManager = BridgeManager()
    var hue: Int = 1000
    var configuredHue: Int = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLabel = UILabel()
        titleLabel.text = "Laura's Hue App"
        titleLabel.numberOfLines = 1
        titleLabel.backgroundColor = UIColor.redColor()
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        self.view.addSubview(titleLabel)
        
        subTitleLabel = UILabel()
        subTitleLabel.text = "Select a Light"
        subTitleLabel.numberOfLines = 1
        subTitleLabel.backgroundColor = UIColor.redColor()
        subTitleLabel.textAlignment = .Center
        subTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        self.view.addSubview(subTitleLabel)
        
        buttonOne = UIButton()
        buttonTwo = UIButton()
        buttonThree = UIButton()
        
        autoLayout()
        
//        slider.addTarget(self, action: "sliderChanged:", forControlEvents: UIControlEvents.ValueChanged)
//        satSlider.addTarget(self, action: "satSliderChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    func autoLayout() {
        
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        subTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let top = NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 30)
        let centerX = NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        self.view.addConstraints([top, centerX])
        
        let subtitleTop = NSLayoutConstraint(item: subTitleLabel, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 8)
        let subtitleCenterX = NSLayoutConstraint(item: subTitleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        self.view.addConstraints([subtitleTop, subtitleCenterX])
        
        let buttonLayoutString = "H:|-10@250-[one]-10-[two(==one)]-10-[three(==one)]-10@250-|"
        let buttonConstraints = NSLayoutConstraint.constraintsWithVisualFormat(buttonLayoutString, options: nil, metrics: nil, views: ["one" : buttonOne, "two" : buttonTwo, "three" : buttonThree])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func sliderChanged(sender: AnyObject) {
        hue = Int(slider.value)
        if hue > configuredHue + kMinStep || hue < configuredHue - kMinStep {
            configuredHue = hue
            bridgeManager.changeColor(hue, lightID: "3")
        }
        sat = Int(satSlider.value)
        if sat > configuredSat + kMinStep || sat < configuredSat - kMinStep {
            configuredSat = sat
            bridgeManager.changeSaturation(sat, lightID: "3")
        }
    }
}

