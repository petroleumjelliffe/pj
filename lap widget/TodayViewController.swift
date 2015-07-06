//
//  TodayViewController.swift
//  lap widget
//
//  Created by Peter Jelliffe on 6/29/15.
//  Copyright (c) 2015 Peter Jelliffe. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var timer:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        let aSelector:Selector = "updateTimer"
        let widgetTimer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: aSelector, userInfo: nil, repeats: true)
        widgetTimer.fire()
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    

    func updateTimer() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.timer!.text = Stopwatch.getLapTime() as String
        })
        
    }

}

/**
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

}**/
