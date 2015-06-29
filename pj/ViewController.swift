//
//  ViewController.swift
//  pj
//
//  Created by Peter Jelliffe on 6/29/15.
//  Copyright (c) 2015 Peter Jelliffe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button:UIButton?
    @IBOutlet var timer:UITextField?
    
    var startTime = NSTimeInterval()
    
    var timer2 = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime:NSTimeInterval = currentTime - startTime
        
        let minutes = UInt8(elapsedTime/60.0)
        
        elapsedTime -= (NSTimeInterval(minutes)*60)
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        self.timer?.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        
    }
    
    @IBAction func startTimer(sender:AnyObject) {  //start button
        
        if !timer2.valid {
            let aSelector:Selector = "updateTime"
            timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
        
        
        
    }
    @IBAction func stopTimer(sender:AnyObject) {  //stop  button
        
        
        timer2.invalidate()
        timer?.text="00:00:00"
        
    }
    
    

}

