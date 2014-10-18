//
//  LightViewController.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/11/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import UIKit

class LightViewController: UIViewController {

    let kMinStep: Int = 10
    var light: Lights!

    var hueLabel = UILabel()
    var saturationLabel = UILabel()
    var brightnessLabel = UILabel()
    
    var hueSlider = UISlider()
    var saturationSlider = UISlider()
    var brightnessSlider = UISlider()
    
    var onOffSwitch = UISwitch()
    
    let kSpacing: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = light.name
        
        onOffSwitch.addTarget(self, action: "switchChanged:", forControlEvents: .ValueChanged)
        self.view.addSubview(onOffSwitch)
        
        hueLabel.text = "Hue"
        hueLabel.numberOfLines = 1
        hueLabel.font = UIFont(name: "STHeitiTC-Light", size: 16)
        self.view.addSubview(hueLabel)
        
        saturationLabel.text = "Saturation"
        saturationLabel.numberOfLines = 1
        saturationLabel.font = UIFont(name: "STHeitiTC-Light", size: 16)
        self.view.addSubview(saturationLabel)
        
        brightnessLabel.text = "Brightness"
        brightnessLabel.numberOfLines = 1
        brightnessLabel.font = UIFont(name: "STHeitiTC-Light", size: 16)
        self.view.addSubview(brightnessLabel)
        
        hueSlider.minimumValue = 0
        hueSlider.maximumValue = 65535
        hueSlider.addTarget(self, action: "hueSliderChanged:", forControlEvents: .ValueChanged)
        
        saturationSlider.minimumValue = 0
        saturationSlider.maximumValue = 255
        saturationSlider.addTarget(self, action: "saturationSliderChanged:", forControlEvents: .ValueChanged)
        
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 255
        brightnessSlider.addTarget(self, action: "brightnessSliderChanged:", forControlEvents: .ValueChanged)
        
        self.view.addSubview(hueSlider)
        self.view.addSubview(saturationSlider)
        self.view.addSubview(brightnessSlider)
        
        autoLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.hueSlider.setValue(Float(light.hue), animated: false)
        self.saturationSlider.setValue(Float(light.sat), animated: false)
        self.brightnessSlider.setValue(Float(light.bri), animated: false)
        self.onOffSwitch.setOn(light.state!, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func autoLayout() {
        
        hueLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        let hueLabelCenterX = NSLayoutConstraint(item: hueLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let hueLabelTop = NSLayoutConstraint(item: hueLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 64+20)
        self.view.addConstraints([hueLabelCenterX, hueLabelTop])
        
        hueSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        let hueSliderLeading = NSLayoutConstraint(item: hueSlider, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 10)
        let hueSliderTrailing = NSLayoutConstraint(item: hueSlider, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: -10)
        let hueSliderTop = NSLayoutConstraint(item: hueSlider, attribute: .Top, relatedBy: .Equal, toItem: hueLabel, attribute: .Bottom, multiplier: 1, constant: kSpacing)
        self.view.addConstraints([hueSliderLeading, hueSliderTrailing, hueSliderTop])
        
        saturationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        let saturationLabelCenterX = NSLayoutConstraint(item: saturationLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let saturationLabelTop = NSLayoutConstraint(item: saturationLabel, attribute: .Top, relatedBy: .Equal, toItem: hueSlider, attribute: .Bottom, multiplier: 1, constant: kSpacing)
        self.view.addConstraints([saturationLabelCenterX, saturationLabelTop])
        
        saturationSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        let saturationSliderLeading = NSLayoutConstraint(item: saturationSlider, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 10)
        let saturationSliderTrailing = NSLayoutConstraint(item: saturationSlider, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: -10)
        let saturationSliderTop = NSLayoutConstraint(item: saturationSlider, attribute: .Top, relatedBy: .Equal, toItem: saturationLabel, attribute: .Bottom, multiplier: 1, constant: kSpacing)
        self.view.addConstraints([saturationSliderLeading, saturationSliderTrailing, saturationSliderTop])
        
        brightnessLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        let brightnessLabelCenterX = NSLayoutConstraint(item: brightnessLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let brightnessLabelTop = NSLayoutConstraint(item: brightnessLabel, attribute: .Top, relatedBy: .Equal, toItem: saturationSlider, attribute: .Bottom, multiplier: 1, constant: kSpacing)
        self.view.addConstraints([brightnessLabelCenterX, brightnessLabelTop])
        
        brightnessSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        let brightnessSliderLeading = NSLayoutConstraint(item: brightnessSlider, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 10)
        let brightnessSliderTrailing = NSLayoutConstraint(item: brightnessSlider, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1, constant: -10)
        let brightnessSliderTop = NSLayoutConstraint(item: brightnessSlider, attribute: .Top, relatedBy: .Equal, toItem: brightnessLabel, attribute: .Bottom, multiplier: 1, constant: kSpacing)
        self.view.addConstraints([brightnessSliderLeading, brightnessSliderTrailing, brightnessSliderTop])
        
        onOffSwitch.setTranslatesAutoresizingMaskIntoConstraints(false)
        let onOffSwitchCenterX = NSLayoutConstraint(item: onOffSwitch, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let onOffSwitchTop = NSLayoutConstraint(item: onOffSwitch, attribute: .Top, relatedBy: .Equal, toItem: brightnessSlider, attribute: .Bottom, multiplier: 1, constant: kSpacing)
        self.view.addConstraints([onOffSwitchCenterX, onOffSwitchTop])
        
        
        
    }
    
    func hueSliderChanged(sender: UISlider) {
        let newValue = Int(sender.value)
        if newValue > light.hue + kMinStep || newValue < light.hue - kMinStep {
            light.hue = newValue
            BridgeManager.sharedInstance.changeColor(newValue, lightID: light.modelid!)
        }
    }
    
    func saturationSliderChanged(sender: UISlider) {
        let newValue = Int(sender.value)
        if newValue > light.sat + kMinStep || newValue < light.sat - kMinStep {
            light.sat = newValue
            BridgeManager.sharedInstance.changeSaturation(newValue, lightID: light.modelid!)
        }
        
    }

    func brightnessSliderChanged(sender: UISlider) {
        let newValue = Int(sender.value)
        if newValue > light.bri + kMinStep || newValue < light.bri - kMinStep {
            light.bri = newValue
            BridgeManager.sharedInstance.changeBrightness(newValue, lightID: light.modelid!)
        }
        
    }
    
    func switchChanged(sender: UISwitch) {
        light.state = onOffSwitch.on
        BridgeManager.sharedInstance.configureLight(light.modelid!, state: onOffSwitch.on)
    }
    
    
//    func sliderChanged(sender: UISlider) {
//        hue = Int(slider.value)
//        if hue > configuredHue + kMinStep || hue < configuredHue - kMinStep {
//            configuredHue = hue
//            bridgeManager.changeColor(hue, lightID: "3")
//        }
//        sat = Int(satSlider.value)
//        if sat > configuredSat + kMinStep || sat < configuredSat - kMinStep {
//            configuredSat = sat
//            bridgeManager.changeSaturation(sat, lightID: "3")
//        }
//    }

}
