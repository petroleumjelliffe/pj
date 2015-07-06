//
//  model.swift
//  pj
//
//  Created by Peter Jelliffe on 7/1/15.
//  Copyright (c) 2015 Peter Jelliffe. All rights reserved.
//

import Foundation


class Stopwatch:NSObject {
    static var startTime = NSTimeInterval()
    
    
    static var timer = NSTimer()  //external objects call setintervalwith
    
    static var isCounting:Bool = false
    
    static var accumulatedTime: NSTimeInterval = 0
    
    static var lapTimes = [String]()
    
    static var recordedLaps = [NSTimeInterval]()
    


    
    static func getTotalElapsedTime() -> NSString {
        
        //calculate elapsed time
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime:NSTimeInterval = currentTime - startTime + accumulatedTime
        
        print("current time: \(currentTime)")
        print("start time: \(self.startTime)")
        print("elapsed time: \(elapsedTime)")
        
        
        return formatTimes(elapsedTime)
        
        
    }
    
    static func formatTimes (timeToFormat:NSTimeInterval) -> NSString {
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
    
    static func getLapTimes() {
        
        
        
    }
    

    
    static func toggleState() {
        self.isCounting = !self.isCounting

    }
    
    static func saveLapTime(time:NSString) {
        self.lapTimes.append(time as String)
        
        
    }
    
    static func lap() {
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
    
    static func startTimer() {
        //get the time stoppwatch was started
        let x = NSDate.timeIntervalSinceReferenceDate()
        self.startTime = x
        
        self.isCounting = true
        
        //set as first lap timestamp
        recordedLaps.append(x)
    }
    
    static func stopTimer() {
        //stop the timer
        self.timer.invalidate()
        
        //save the accumulated time
        self.accumulatedTime += (NSDate.timeIntervalSinceReferenceDate()-self.startTime)
        
        self.isCounting = false
    }
    
    static func resetTimer() {
        //reset the accummulated time
        self.accumulatedTime = 0;
        
        //delete all saved laps
        self.lapTimes.removeAll(keepCapacity: false)
        self.recordedLaps.removeAll(keepCapacity: false)
    }

    
}
