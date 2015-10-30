//
//  IndividualRecipeViewController.swift
//  MealPlanner
//
//  Created by Claw on 10/28/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit
import AFNetworking

class IndividualRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var recipenameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var recipe: NSDictionary!
    var recipeID: String!
    var urlString: String!
    var ingredientlistArray: [String]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        
        ingredientlistArray = []
        
        let url = NSURL(string: "http://food2fork.com/api/get?key=7e1cd92e04fda52d2520cfc3046b9f4b&rId=\(recipeID)")!
        
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            { (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                print(json)
                self.recipe = json["recipe"] as! NSDictionary
               
                self.recipenameLabel.text = self.recipe["title"] as! String
                self.urlString = self.recipe["image_url"] as! String
                self.recipeImageView.setImageWithURL(NSURL(string: self.urlString)!)
                self.ingredientlistArray = self.recipe["ingredients"] as! [String]
                self.ingredientTableView.reloadData()
                
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return ingredientlistArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(ingredientlistArray)
        print("Row \(indexPath.row)")
        var cell = ingredientTableView.dequeueReusableCellWithIdentifier("IngredientCell") as! IngredientCell
        print(indexPath.row)
        cell.ingredientLabel.text = ingredientlistArray[indexPath.row]
        return cell
        
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
