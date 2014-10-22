//
//  TableViewController.swift
//  LauraHueApp
//
//  Created by Laura Phelps on 10/10/14.
//  Copyright (c) 2014 Laura Phelps. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    final var dataSource: [Lights] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "addDataToTableView", forControlEvents: .ValueChanged)
        
        addDataToTableView()
    }

    func addDataToTableView() {
        BridgeManager.sharedInstance.seeLights { (lights, error) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error != nil {
                    BridgeManager.sharedInstance.errorController("THIS IS WRONG", presenter: self)
                } else {
                    self.dataSource = lights!
                    self.tableView.reloadData()
                    
                    if self.refreshControl?.refreshing == true {
                        self.refreshControl?.endRefreshing()
                    }
                }
            })
            
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        let lightObject = dataSource[indexPath.row]
        cell.textLabel?.text = "(\(lightObject.modelid!)) " + lightObject.name!
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
//        cell.backgroundColor = UIColor.redColor()
//        cell.contentView.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension // only when targeting >= iOS 8
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("lightDetailSegue", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let light = self.dataSource[tableView.indexPathForSelectedRow()!.row]
        
        if segue.identifier == "lightDetailSegue" {
            let destinationViewController = segue.destinationViewController as LightTableViewController
            destinationViewController.light = light
        }
    }


}
