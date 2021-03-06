//
//  ViewController.swift
//  pj
//
//  Created by Peter Jelliffe on 6/29/15.
//  Copyright (c) 2015 Peter Jelliffe. All rights reserved.
//

import UIKit
import CoreMotion


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var button:UIButton?
    @IBOutlet var stop:UIButton?
    @IBOutlet var start:UIButton?
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
        
        var x = stopwatch.lapTimes[indexPath.row]
        
        cell?.textLabel?.text = x
        cell?.textLabel?.font = UIFont.systemFontOfSize(11.0)


        
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
            
            //change start time label
            start?.setTitle("Lap", forState: UIControlState.Normal)
            stop?.setTitle("Stop", forState: UIControlState.Normal)
            
            //        init the pedometer
            if(CMPedometer.isStepCountingAvailable()){
                
                //            let fromDate = NSDate(timeIntervalSinceReferenceDate: )
                stopwatch.pedoMeter.startPedometerUpdatesFromDate(NSDate()) { (data: CMPedometerData!, error) -> Void in
                    println("init: \(data)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if(error == nil){
                            //                        let lapString = "\(self.formatTimes(x) as String), \(data.numberOfSteps) steps"
                        } else {
                            println("error: \(error)")
                        }
                    })
                }
            }

            
        } else {//it's already running, save a lap
            //lap the timer
            stopwatch.lap({ () -> (Void) in
                laps?.reloadData()
            })

        }
        
        //toggle the function of the button
        
        //
        
    }
    
    func updateTimer() {
        println(stopwatch.getTotalElapsedTime())
        readout!.text = stopwatch.getTotalElapsedTime() as String
        
    }
    
    @IBAction func lapTimer(sender:AnyObject) {  //lap button
        
        
        stopwatch.lap({})
        
        laps?.reloadData()
        
        

        
        
        
        
        
        
        
    }
    @IBAction func stopTimer(sender:AnyObject) {  //stop  button
        
        if stopwatch.timer.valid {
            //stop if timer is running
            stopwatch.stopTimer()
            
            //update button's label to "reset"
            stop?.setTitle("Reset", forState: UIControlState.Normal)
            start?.setTitle("Start", forState: UIControlState.Normal)


        } else {
            //reset timer if it's already stopped
            stopwatch.resetTimer()
            
            //zero out the readout
            readout!.text = "00:00.00"
            
            laps?.reloadData()

            stop?.setTitle("Stop", forState: UIControlState.Normal)

            
        }
        //timer?.text="00:00:00"
        
    }
    
    
    
    
}