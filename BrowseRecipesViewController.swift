//
//  BrowseRecipesViewController.swift
//  MealPlanner
//
//  Created by Claw on 10/27/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit
import AFNetworking

class BrowseRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var browseTableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var recipenames: [String]!
    var recipes: [NSDictionary]!
    var recipeID: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        browseTableView.delegate = self
        browseTableView.dataSource = self
        
        recipes = []
        
        let url = NSURL(string: "http://food2fork.com/api/search?key=7e1cd92e04fda52d2520cfc3046b9f4b&q=shredded%20chicken")!
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            { (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                print(json)
                
                self.recipes = json["recipes"] as! [NSDictionary]
                self.browseTableView.reloadData()
                
        }
    }
    
    
    // Do any additional setup after loading the view.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return recipes.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = browseTableView.dequeueReusableCellWithIdentifier("ResultCell")! as! ResultCell
        
        let recipe = recipes[indexPath.row]
        let urlString = recipe.valueForKeyPath("image_url") as! String
        
        cell.recipenameLabel.text = recipe["title"] as! String
        cell.recipeImageView.setImageWithURL(NSURL(string: urlString)!)
        cell.recipeID = recipe["recipe_id"] as! String
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
    }
    
    @IBAction func onSearchPress(sender: AnyObject) {
        //        print(searchTextField.text!)
        //        print("http://food2fork.com/api/search?key=7e1cd92e04fda52d2520cfc3046b9f4b&q=\(searchTextField.text!)&sort=r")
        let originalSearchString = searchTextField.text!
        let escapedSearchString = originalSearchString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        print("New URL: \(escapedSearchString)")
        
        let url = NSURL(string: "http://food2fork.com/api/search?key=7e1cd92e04fda52d2520cfc3046b9f4b&q=\(escapedSearchString!)")!
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            { (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
                print(json)
                
                self.recipes = json["recipes"] as! [NSDictionary]
                self.browseTableView.reloadData()
        }
    }
    
    // Pass the recipe Id that user clicked on into the next screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! ResultCell

        if segue.identifier == "getRecipeSegue" {
            let individualRecipeViewController = segue.destinationViewController as! IndividualRecipeViewController
            individualRecipeViewController.recipeID = cell.recipeID
            print(cell.recipeID)
        }
    }
}
