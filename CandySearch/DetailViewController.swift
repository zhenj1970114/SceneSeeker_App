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
import Foundation
import AVFoundation
import AVKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var candyImageView: UIImageView!
  @IBOutlet weak var DetailMovieName: UILabel!
  @IBOutlet weak var DetailDirectorName: UILabel!
  @IBOutlet weak var DetailTimeLabel: UILabel!
    
    @IBAction func downloadButton(sender: AnyObject) {
        
        let alert:UIAlertController = UIAlertController(title:"Download",message:"Saving the link of \(movieView!.movieTitle)-\(movieView!.tags) to MyClips",preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let action:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (a:UIAlertAction) -> Void in
            print("item selected!")
        }
        let action1:UIAlertAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default) { (a:UIAlertAction) -> Void in
            print("item1 selected!")
        }
        alert.addAction(action)
        alert.addAction(action1)
        
        self.presentViewController(alert, animated: true) { () -> Void in
            print("alert presented")
        }

    }
    

    //tab inside the video to pause, have not figure out how to tab again to resume
    @IBAction func PausePlayButton(sender: AnyObject) {
        if let player = self.player{
            player.pause()
        }
        else {
            player!.play()
        }
    }
    
//don't know what this part"configure view" is doing
  var movieView: Candy? {
    didSet {
      configureView()
    }
  }
  
  func configureView() {
    if let movieView = movieView {
      if let detailDescriptionLabel = detailDescriptionLabel,candyImageView = candyImageView {
            detailDescriptionLabel.text = movieView.tags
            DetailMovieName.text = movieView.movieTitle
            DetailDirectorName.text = movieView.director
            DetailTimeLabel.text = movieView.timeTag
            candyImageView.image = UIImage(named: movieView.tags)
            title = movieView.movieTitle
      }
    }
  }
    
//MARK PLAY VIDEO
  var player : AVPlayer?
  var playerViewController = AVPlayerViewController()
  var playerView = AVPlayer()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    
    func supportedInterfaceOrientations() -> Int {
                return Int(UIInterfaceOrientationMask.Landscape.rawValue)
            }
   
    
        //playvideo
        let screenSize: CGRect = UIScreen.mainScreen().bounds;
    
        //set screen width and height in variables
        let screenWidth = screenSize.width;
        let screenHeight = screenSize.height;
    
        let currentDevice: UIDevice = UIDevice.currentDevice()
        let orientation: UIDeviceOrientation = currentDevice.orientation
    
        if orientation.isLandscape {
            print("landscape")
        } else {
            print("portrait")
        }
    
    
    player = AVPlayer(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("\(movieView!.tags)", ofType:"mov")!))


    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame.size.height = screenHeight * 0.45;
    playerLayer.frame.size.width = screenWidth * 1.0;
    self.view.layer.addSublayer(playerLayer)
    player!.play()


  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        player!.play() // Start the playback
    }
  
}



