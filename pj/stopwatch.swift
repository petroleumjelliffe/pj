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
    
    
    var timer = NSTimer()  //external objects call setintervalwith
    
    var isCounting:Bool = false
    
    var accumulatedTime: NSTimeInterval = 0
    
    var lapTimes = [String]()
    
    var recordedLaps = [NSTimeInterval]()
    


    
    func getTotalElapsedTime() -> NSString {
        
        //calculate elapsed time
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime:NSTimeInterval = currentTime - startTime + accumulatedTime
        
        print("current time: \(currentTime)")
        print("start time: \(self.startTime)")
        print("elapsed time: \(elapsedTime)")
        
        
        return formatTimes(elapsedTime)
        
        
    }
    
    func formatTimes (timeToFormat:NSTimeInterval) -> NSString {
        var x = timeToFormat
        var minutes = UInt(x/60.0)
        
        x -= (NSTimeInterval(minutes)*60)
        
        let seconds = UInt(x)
        
        x -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt(x * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        return  "\(strMinutes):\(strSeconds).\(strFraction)"
    }
    
    func getLapTimes() {
        
        
        
    }
    

    
    func toggleState() {
        self.isCounting = !self.isCounting

    }
    
    func saveLapTime(time:NSString) {
        self.lapTimes.append(time as String)
        
        
    }
    
    func lap() {
        //get the timestamp when Lap was pressed
        let lapInterval = NSDate.timeIntervalSinceReferenceDate()
        
        //then save the differencefrom the previous lap, if any
        let x = lapInterval - recordedLaps.last!
        print("x = \(x)")
        lapTimes.append(formatTimes(x) as String)

        //add the current time as a lap timestamp
        print(lapInterval)
        recordedLaps.append(lapInterval)
        

    }
    
    func startTimer() {
        //get the time stoppwatch was started
        let x = NSDate.timeIntervalSinceReferenceDate()
        self.startTime = x
        
        self.isCounting = true
        
        //set as first lap timestamp
        recordedLaps.append(x)
    }
    
    func stopTimer() {
        //stop the timer
        self.timer.invalidate()
        
        //save the accumulated time
        self.accumulatedTime += (NSDate.timeIntervalSinceReferenceDate()-self.startTime)
        
        self.isCounting = false
    }
    
    func resetTimer() {
        //reset the accummulated time
        self.accumulatedTime = 0;
        
        //delete all saved laps
        self.lapTimes.removeAll(keepCapacity: false)
        self.recordedLaps.removeAll(keepCapacity: false)
    }

    
}
