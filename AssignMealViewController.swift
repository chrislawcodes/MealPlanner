//
//  AssignMealViewController.swift
//  MealPlanner
//
//  Created by Claw on 10/16/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit

class AssignMealViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func oncancelButton(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func ondonePress(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
        
        NSNotificationCenter.defaultCenter().postNotificationName("ResetTabController", object: nil)
        
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
