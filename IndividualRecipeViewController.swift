//
//  IndividualRecipeViewController.swift
//  MealPlanner
//
//  Created by Claw on 10/28/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit
import AFNetworking

class IndividualRecipeViewController: UIViewController {
    
    

    @IBOutlet weak var recipenameLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var ingredientlistLabel: UILabel!
    
    var recipe: [NSDictionary]!
    var recipeID = String.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://food2fork.com/api/search?key=7e1cd92e04fda52d2520cfc3046b9f4b&rId\(recipeID)")!
        
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            { (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                print(json)
         self.recipe = json["recipe"] as! [NSDictionary]

//        recipenameLabel = recipe["title"] as! String
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
