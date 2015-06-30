//
//  ViewController.swift
//  pj
//
//  Created by Peter Jelliffe on 6/29/15.
//  Copyright (c) 2015 Peter Jelliffe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var button:UIButton?
    @IBOutlet var timer:UITextField?
    @IBOutlet var laps:UITableView?
    
    var startTime = NSTimeInterval()
    
    var timer2 = NSTimer()
    
    var state:Int = 0
    
    var accumulatedTime = NSTimeInterval()
    
    var lapTimes = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.laps?.dataSource = self
        self.laps?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = self.laps?.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        
        cell?.textLabel?.text  = self.lapTimes[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimes.count
        
    }
    
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime:NSTimeInterval = currentTime - startTime + accumulatedTime
        
        
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
        
        if (self.state == 0) {
            if !timer2.valid {
                let aSelector:Selector = "updateTime"
                timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
                startTime = NSDate.timeIntervalSinceReferenceDate()
            }
        } else {
            
            
            timer2.invalidate()
            
            
        }
        
        
        self.state = (++self.state) % 2
        
        
        
    }
    @IBAction func lapTimer(sender:AnyObject) {  //start button
        
        
        lapTimes.append(timer!.text!)
        
        laps?.reloadData()
        
        
        timer2.invalidate()

  
            if !timer2.valid {
                let aSelector:Selector = "updateTime"
                timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
                startTime = NSDate.timeIntervalSinceReferenceDate()
            }

        
        

        
        
        
    }
    @IBAction func stopTimer(sender:AnyObject) {  //stop  button
        
        
        timer2.invalidate()
        //timer?.text="00:00:00"
        
    }
    
    
    

}

