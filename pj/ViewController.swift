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
    @IBOutlet var readout:UITextField?
    @IBOutlet var laps:UITableView?
    
    var stopwatch = Stopwatch()  //stopwatch object
    
    
    
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
        
        var x = stopwatch.recordedLaps[indexPath.row]
        
        cell?.textLabel?.text = stopwatch.formatTimes(x) as String

        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopwatch.lapTimes.count
        
    }
    
    
    @IBAction func startTimer(sender:AnyObject) {  //start button
        
        if !stopwatch.isCounting {
            //start the timer
            let aSelector:Selector = "updateTimer"
            stopwatch.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
            stopwatch.startTimer()
        } else {
            //stop the timer
            stopwatch.stopTimer()
        }
        
        //toggle the function of the button
        
        //
        
    }
    
    func updateTimer() {
        println(stopwatch.getTotalElapsedTime())
        readout!.text = stopwatch.getTotalElapsedTime() as String
        
    }
    
    @IBAction func lapTimer(sender:AnyObject) {  //lap button
        
        
        stopwatch.lap()
        
        laps?.reloadData()
        
        

        
        
        
        
        
        
        
    }
    @IBAction func stopTimer(sender:AnyObject) {  //stop  button
        
        if stopwatch.timer.valid {
            //stop if timer is running
            stopwatch.stopTimer()
            
            //update button's label to "reset"
        } else {
            //reset timer if it's already stopped
            stopwatch.resetTimer()
            
            //zero out the readout
            readout!.text = "00:00.00"
            
        }
        //timer?.text="00:00:00"
        
    }
    
    
    
    
}