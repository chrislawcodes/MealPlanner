//
//  BrowseRecipesViewController.swift
//  MealPlanner
//
//  Created by Claw on 10/27/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit

class BrowseRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var browseTableView: UITableView!
    
    var recipenames: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        browseTableView.delegate = self
        browseTableView.dataSource = self
        
        recipenames = ["Shrimp", "Chicken", "Beef", "Salad"]
        
        let url = NSURL(string: "http://food2fork.com/api/search?key=7e1cd92e04fda52d2520cfc3046b9f4b&q=shredded%20chicken")!
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            { (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                let json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        }
    }


        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipenames.count
    
    }



    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = browseTableView.dequeueReusableCellWithIdentifier("ResultCell")! as! ResultCell
    
    
    cell.recipenameLabel.text = recipenames[indexPath.row]
    
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
