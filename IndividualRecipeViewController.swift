//
//  IndividualRecipeViewController.swift
//  MealPlanner
//
//  Created by Claw on 10/28/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit
import AFNetworking

class IndividualRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var recipenameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var assignPicker: UIPickerView!
    @IBOutlet weak var mealdatePicker: UIView!
    
    var recipe: NSDictionary!
    var recipeID: String!
    var urlString: String!
    var ingredientlistArray: [String]!
    
    let pickerData = [
        ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
        ["Breakfast","Lunch","Dinner"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mealdatePicker.alpha = 0
        
        assignPicker.dataSource = self
        assignPicker.delegate = self
        
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
    
    //Picker Code
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }
    
    func updateLabel(){
        let date = pickerData[0][assignPicker.selectedRowInComponent(0)]
        let meal = pickerData[1][assignPicker.selectedRowInComponent(1)]
        displayLabel.text = date + " for " + meal
    }
    
    @IBAction func assignmealButton(sender: UIButton) {
        mealdatePicker.alpha = 1
    }

}
