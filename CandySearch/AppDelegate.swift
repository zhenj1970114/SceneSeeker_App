/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate, UISplitViewControllerDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    //change statusbarstyle
    UIApplication.sharedApplication().statusBarStyle = .LightContent
    
    if let customFont = UIFont(name: "Merriweather-Regular", size: 12) {
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: customFont]

    }
    
//    UINavigationBar.appearance().titleTextAttributes = [
//        
//        NSFontAttributeName: UIFont(name: "Merriweather.ttf", size: 12)!
//    ]
// return true
    
//    navigationController.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Merriweather", size: 12)!

    
    let splitViewController = window!.rootViewController as! UISplitViewController
    let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
    navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
    splitViewController.delegate = self
   
    
    UISearchBar.appearance().barTintColor = UIColor.candyGreen()
    UISearchBar.appearance().tintColor = UIColor.whiteColor()
    UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.candyGreen()
    
    //MARK:-Change nav bar style without a navigationController file
    UINavigationBar.appearance().barTintColor = UIColor(red: 0/255.0, green: 30.0/255.0, blue: 39.0/255.0, alpha: 1.0)
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    
    return true
  }
  
  // MARK: - Split view
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
    guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
    guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
    if topAsDetailController.movieView == nil {
      // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
      return true
    }
    return false
  }
  
}

extension UIColor {
  static func candyGreen() -> UIColor {
    
    return UIColor(red: 0.0/255.0, green: 142.0/255.0, blue: 132.0/255.0, alpha: 1.0)
  }
}