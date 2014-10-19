//
//  LightTableViewController.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/14/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import UIKit

class LightTableViewController: UITableViewController {

    let kMinStep: Int = 10
    var light: Lights!
    var dataSource: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lightName = light.name {
            self.title = lightName
        }
        
        var newPresetButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "buttonPressed:")
        self.navigationItem.rightBarButtonItem = newPresetButton
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "presetCell2")
        buildDataSource()
        
    }

    func buildDataSource() {
        dataSource.removeAll(keepCapacity: false)
        var presets = CDMgr.sharedInstance.procurePresets()
        
        var controls = ["hue", "sat", "bri"]
        dataSource.append(controls)
        
        var onOff = ["on"]
        dataSource.append(onOff)
        
        if presets.count > 0 {
            var presetsArray: [LightPreset] = []
            for p in presets {
                presetsArray.append(p)
            }
            dataSource.append(presetsArray)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func buttonPressed(sender: UIBarButtonItem) {
        let av = UIAlertController(title: "Create New Favorite", message: "Save current settings as favorite?", preferredStyle: UIAlertControllerStyle.Alert)
        av.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) -> Void in
            if let nameTextField = av.textFields![0] as? UITextField {
                CDMgr.sharedInstance.savePreset(nameTextField.text, hue: Double(self.light.hue), sat: Double(self.light.sat), bri: Double(self.light.bri))
                self.buildDataSource()
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        av.addAction(saveAction)
        av.addAction(cancelAction)
        self.presentViewController(av, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dataSection: AnyObject = dataSource[indexPath.section] as AnyObject
        if indexPath.section == 0 {
            let dataObject = dataSection[indexPath.row] as String
            let cell = tableView.dequeueReusableCellWithIdentifier("lightControlCell", forIndexPath: indexPath) as LightControlTableViewCell
            if dataObject == "hue" {
                cell.controlLabel.text = "Hue"
                cell.controlSlider.minimumValue = 0
                cell.controlSlider.maximumValue = 65535
                cell.controlSlider.addTarget(self, action: "hueSliderChanged:", forControlEvents: .ValueChanged)
                cell.controlSlider.setValue(Float(light.hue), animated: false)
            } else if dataObject == "sat" {
                cell.controlLabel.text = "Saturation"
                cell.controlSlider.minimumValue = 0
                cell.controlSlider.maximumValue = 255
                cell.controlSlider.addTarget(self, action: "saturationSliderChanged:", forControlEvents: .ValueChanged)
                cell.controlSlider.setValue(Float(light.sat), animated: false)
            } else if dataObject == "bri" {
                cell.controlLabel.text = "Brightness"
                cell.controlSlider.minimumValue = 0
                cell.controlSlider.maximumValue = 255
                cell.controlSlider.addTarget(self, action: "brightnessSliderChanged:", forControlEvents: .ValueChanged)
                cell.controlSlider.setValue(Float(light.bri), animated: false)
            }
            return cell
        } else if indexPath.section == 1 {
            let dataObject = dataSection[indexPath.row] as String
            let cell = tableView.dequeueReusableCellWithIdentifier("lightOnOffCell", forIndexPath: indexPath) as LightOnOffTableViewCell
            cell.onOffSwitch.addTarget(self, action: "switchChanged:", forControlEvents: .ValueChanged)
            cell.onOffSwitch.setOn(light.state!, animated: false)
            return cell
        } else if indexPath.section == 2 {
            let dataObject = dataSection[indexPath.row] as LightPreset
            let cell = tableView.dequeueReusableCellWithIdentifier("presetCell2", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = dataObject.name
            return cell
        }
        return tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 2 {
            return true
        }
        return false
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
        light.state = sender.on
        BridgeManager.sharedInstance.configureLight(light.modelid!, state: sender.on)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 96
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section: AnyObject = dataSource[indexPath.section]
        let object: AnyObject = section[indexPath.row]
        
        if object is LightPreset {
            let preset = object as LightPreset
            BridgeManager.sharedInstance.changeColor(preset.hue, lightID: light.modelid!)
            BridgeManager.sharedInstance.changeBrightness(preset.brightness, lightID: light.modelid!)
            BridgeManager.sharedInstance.changeSaturation(preset.saturation, lightID: light.modelid!)
            
            light.bri = preset.brightness
            light.sat = preset.saturation
            light.hue = preset.hue
        }
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Light Settings:"
        } else if section == 1 {
            return "Light Status:"
        } else if section == 2 {
            return "Presets:"
        } else {
            return nil
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            var dataObject = dataSource[indexPath.section] as [LightPreset]
            
            dataObject.removeAtIndex(indexPath.row)
            dataSource[indexPath.section] = dataObject
            
            CDMgr.sharedInstance.context.deleteObject(dataObject[indexPath.row])
            CDMgr.sharedInstance.context.save(nil)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
