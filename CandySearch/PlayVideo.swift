//
//  PlayVideo.swift
//  CandySearch
//
//  Created by Jia Zheng on 7/26/16.
//  Copyright © 2016 Peartree Developers. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class playVideo: UIViewController {
    var avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    
    let testpath1 = NSBundle.mainBundle().pathForResource("harry_eye", ofType:"mov")
    let testpath2 = NSBundle.mainBundle().pathForResource("snowpiercer_eye", ofType:"mov")
    let testpath3 = NSBundle.mainBundle().pathForResource("swan_eye", ofType:"mov")
    let testpath4 = NSBundle.mainBundle().pathForResource("harry_fight", ofType:"mov")
    let testpath5 = NSBundle.mainBundle().pathForResource("harry_memory", ofType:"mov")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        
        // An AVPlayerLayer is a CALayer instance to which the AVPlayer can
        // direct its visual output. Without it, the user will see nothing.
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds;
        
        //set screen width and height in variables
        let screenWidth = screenSize.width;
        let screenHeight = screenSize.height;
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        view.layer.insertSublayer(avPlayerLayer, atIndex: 0)
        
        let url = NSURL(fileURLWithPath: testpath1!);
        let playerItem = AVPlayerItem(URL: url)
        avPlayer.replaceCurrentItemWithPlayerItem(playerItem)
        
        avPlayerLayer.frame.size.height = screenHeight * 0.1;
        avPlayerLayer.frame.size.width = screenWidth * 1.0;
        //        avPlayerLayer.fullscreen = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        avPlayer.play() // Start the playback
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Layout subviews manually
        avPlayerLayer.frame = view.bounds;
    }
    
    // Force the view into landscape mode (which is how most video media is consumed.)
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [.Portrait, .PortraitUpsideDown]
    }
    
    func  videoMPMoviePlayerWillEnterFullscreen(notification:NSNotification)
    {
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue ;// UIInterfaceOrientation.LandscapeRight.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        //        avPlayer.fullscreen = true
    }
}