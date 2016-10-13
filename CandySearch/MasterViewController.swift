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

class MasterViewController: UITableViewController {
  
  // MARK: - Properties
  var detailViewController: DetailViewController? = nil
  var candies = [Candy]()
    
  let searchController = UISearchController(searchResultsController: nil)
  //use the same view that you are searching to display results
  var filteredCandies = [Candy]()

    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCandies = candies.filter { movie in
            return movie.tags.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    
  // MARK: - View Setup
  override func viewDidLoad() {
    
    
    candies = [
        Candy(movieTitle:"Harry Potter", tags:"closeup, eye, magic", director:"Chris Columbus",timeTag:"0:10"),
        
        Candy(movieTitle:"Snow piercer", tags:"closeup, revolution", director:"Joon Ho Bong",timeTag:"0:34"),
        
        Candy(movieTitle:"Black Swan", tags:"closeup, eye, mutate", director:"Darren Aronofsky",timeTag:"0:25"),
        
        Candy(movieTitle:"Harry Potter", tags:"fight, magic", director:"Chris Columbus",timeTag:"0:26"),
        
        Candy(movieTitle:"Harry Potter", tags:"memory, magic", director:"Chris Columbus",timeTag:"1:03"),
        
        Candy(movieTitle:"Snowpiercer", tags:"closeup, torture, slave, winter", director:" Joon-ho Bong",timeTag:"0:50"),
        Candy(movieTitle:"Game of Throne", tags:"eye, horse, walker, panic", director:"David Benioff, D.B. Weiss",timeTag:"0:39"),
        Candy(movieTitle:"Ex Machina", tags:"face, touch, AI", director:"Alex Garland",timeTag:"1:08"),
        Candy(movieTitle:"Kingsman: The Secret Service", tags:"fight, church, control, music", director:"Matthew Vaughn",timeTag:"1:08"),
        
         Candy(movieTitle:"Kingsman: The Secret Service", tags:"fight, firework, music, countdown", director:"Matthew Vaughn",timeTag:"1:08"),
    ]
    
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    tableView.tableHeaderView = searchController.searchBar
 // MARK: - Don't know how to make a background image
//    self.tableView.backgroundColor =  UIColor(patternImage: UIImage!(named: "menu.png"))
    

    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.collapsed
    super.viewWillAppear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
    
   override func  preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    //MARK: -ACCESS PHOTO LIBRARY
    
     let imagePicker = UIImagePickerController()
    
    @IBAction func AddButton(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
//            let imagePicker = UIImagePickerController()
            //don't need a imagePicker.delegate  = self because this is a master-detail model
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }

    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
////        UploadVideo.image = image
//        self.dismissViewControllerAnimated(true, completion: nil);
//        let alert = UIAlertView(title: "Wow",message: "Your video has been uploaded!",delegate: nil,cancelButtonTitle: "Ok")
//        alert.show()
//        
//    }
  
  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
    
//   override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    
//        return "hot and trendy"
////        seciontitle.font = UIFont(name: "Futura", size: 38)!
//    }
  
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredCandies.count
        }
        return candies.count
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)as! CustomCell
        let movie: Candy
        if searchController.active && searchController.searchBar.text != "" {
            movie = filteredCandies[indexPath.row]
        } else {
            movie = candies[indexPath.row]
        }
        
        cell.MovieName.text = movie.movieTitle
        cell.TagName.text = movie.tags
        cell.DirectorName.text = movie.director
        cell.ThumbNail.image = UIImage(named:movie.tags)
        cell.TimeTag.text = movie.timeTag
        

        return cell
    }
  
  // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let movie: Candy
                if searchController.active && searchController.searchBar.text != "" {
                    movie = filteredCandies[indexPath.row]
                } else {
                    movie = candies[indexPath.row]
                }
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.movieView = movie
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
        

            }
        }
    }
    
}


extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

//To allow MasterViewController to respond to the search bar, it will have to implement UISearchResultsUpdating

