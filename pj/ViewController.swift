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
    
    var stopwatch = Stopwatch()
    

    
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
        
        cell?.textLabel?.text  = stopwatch.lapTimes[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopwatch.lapTimes.count
        
    }
    
    
    @IBAction func startTimer(sender:AnyObject) {  //start button
        
        
        //
        
        stopwatch.toggleTimer()
  
        
        
        stopwatch.toggleState()
        
        
        
    }
    
    func updateTimer() {
        timer!.text = stopwatch.updateTime() as String
        
    }
    
    @IBAction func lapTimer(sender:AnyObject) {  //lap button
        
        
        stopwatch.addTime( timer!.text)

        laps?.reloadData()
        
        
        stopwatch.timer2.invalidate()

  
            if !stopwatch.timer2.valid {
                let aSelector:Selector = "updateTimer"
                stopwatch.timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
                stopwatch.startTime = NSDate.timeIntervalSinceReferenceDate()
            }

        
        

        
        
        
    }
    @IBAction func stopTimer(sender:AnyObject) {  //stop  button
        
        
        stopwatch.timer2.invalidate()
        //timer?.text="00:00:00"
        
    }
    
    
    

}

