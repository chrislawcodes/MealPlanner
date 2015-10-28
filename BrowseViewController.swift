//
//  BrowseViewController.swift
//  MealPlanner
//
//  Created by Claw on 10/16/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
                return 20
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath IndexPath: NSIndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCellWithIdentifier("MealCell")! as! MealCell
            
            cell.usernameLabel
            
            return cell
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
