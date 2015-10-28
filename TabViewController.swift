//
//  TabViewController.swift
//  MealPlanner
//
//  Created by Claw on 10/22/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    
    var weeklynavViewController: UIViewController!
    var browsenavViewController: UIViewController!
    var myrecipesViewController: UIViewController!
    var favoritesnavViewController: UIViewController!
    
    var viewControllers: [UIViewController]!
    
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        
        weeklynavViewController = storyboard.instantiateViewControllerWithIdentifier("WeeklyNavViewController")
        browsenavViewController = storyboard.instantiateViewControllerWithIdentifier("BrowseNavViewController")
        myrecipesViewController = storyboard.instantiateViewControllerWithIdentifier("MyRecipesViewController")
        favoritesnavViewController = storyboard.instantiateViewControllerWithIdentifier("FavoritesNavViewController")
        
        viewControllers = [weeklynavViewController, browsenavViewController, myrecipesViewController, favoritesnavViewController]
        
        buttons[selectedIndex].selected = true
        didpressTab(buttons[selectedIndex])
        
        NSNotificationCenter.defaultCenter().addObserverForName("ResetTabController", object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            self.didpressTab(self.buttons[0])
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didpressTab(sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].selected = false
        
        let previousVC = viewControllers[previousIndex]
        previousVC.willMoveToParentViewController(nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.selected = true
        
        let vc = viewControllers[selectedIndex]
        
        addChildViewController(vc)
        
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        vc.didMoveToParentViewController(self)
        
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
