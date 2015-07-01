//
//  model.swift
//  pj
//
//  Created by Peter Jelliffe on 7/1/15.
//  Copyright (c) 2015 Peter Jelliffe. All rights reserved.
//

import Foundation

class Stopwatch:NSObject {
    var startTime = NSTimeInterval()
    
    var timer2 = NSTimer()
    
    var state:Int = 0
    
    var accumulatedTime = NSTimeInterval()
    
    var lapTimes = [String]()
    

    
    func updateTime() -> NSString {
        
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
        
        return  "\(strMinutes):\(strSeconds).\(strFraction)"
        
    }
    
    func toggleTimer() {
    
        if (self.state == 0) {
        if self.timer2.valid {
            let aSelector:Selector = "updateTime"
            self.timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            self.startTime = NSDate.timeIntervalSinceReferenceDate()
            }
        } else {
        
        
        timer2.invalidate()
        
        
        }
    }
    
    func toggleState() {
        self.state = (++self.state) % 2

    }
    
    func addTime(time:NSString) {
        self.lapTimes.append(time as String)
        
        
    }
    
    func lap() {
        
        if !timer2.valid {
            let aSelector:Selector = "updateTime"
            timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
        

    }

    
}
