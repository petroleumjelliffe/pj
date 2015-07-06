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
    @IBOutlet var stop:UIButton?
    @IBOutlet var start:UIButton?
    @IBOutlet var readout:UITextField?
    @IBOutlet var laps:UITableView?
    
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
        let cell = self.laps?.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath)
        
        let x = Stopwatch.lapTimes[indexPath.row]
        
        cell?.textLabel?!.text = x
        cell?.textLabel?!.font = UIFont.systemFontOfSize(11.0)
        
        return cell! as! UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Stopwatch.lapTimes.count
        
    }
    
    
    @IBAction func startTimer(sender:AnyObject) {  //start button
        
        if !Stopwatch.isCounting {
            //start the timer
            let aSelector:Selector = "updateTimer"
            Stopwatch.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
            Stopwatch.startTimer()
            
            //change start time label
            start?.setTitle("Lap", forState: UIControlState.Normal)
            stop?.setTitle("Stop", forState: UIControlState.Normal)
            
        } else {//it's already running, save a lap
            //lap the timer
            Stopwatch.lap()
            laps?.reloadData()

        }
        
        //toggle the function of the button
        
        //
        
    }
    
    func updateTimer() {
        print(Stopwatch.getTotalElapsedTime())
        readout!.text = Stopwatch.getTotalElapsedTime() as String
        
    }
    
    @IBAction func lapTimer(sender:AnyObject) {  //lap button
        Stopwatch.lap()
        laps?.reloadData()
    }
    
    @IBAction func stopTimer(sender:AnyObject) {  //stop  button
        
        if Stopwatch.timer.valid {
            //stop if timer is running
            Stopwatch.stopTimer()
            
            //update button's label to "reset"
            stop?.setTitle("Reset", forState: UIControlState.Normal)
            start?.setTitle("Start", forState: UIControlState.Normal)
        } else {
            //reset timer if it's already stopped
            Stopwatch.resetTimer()
            
            //zero out the readout
            readout!.text = "00:00.00"
            laps?.reloadData()
            stop?.setTitle("Stop", forState: UIControlState.Normal)
        }
        //timer?.text="00:00:00"
    }
}