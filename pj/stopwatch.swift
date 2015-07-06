//
//  model.swift
//  pj
//
//  Created by Peter Jelliffe on 7/1/15.
//  Copyright (c) 2015 Peter Jelliffe. All rights reserved.
//

import Foundation
import CoreMotion


class Stopwatch:NSObject {
    var startTime = NSTimeInterval()
    
    
    var timer = NSTimer()  //external objects call setintervalwith
    
    var isCounting:Bool = false
    
    var accumulatedTime: NSTimeInterval = 0
    
    var lapTimes = [String]()
    
    var recordedLaps = [NSTimeInterval]()
    

    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()

    
    func getTotalElapsedTime() -> NSString {
        
        //calculate elapsed time
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime:NSTimeInterval = currentTime - startTime + accumulatedTime
        
        println("current time: \(currentTime)")
        println("start time: \(self.startTime)")
        println("elapsed time: \(elapsedTime)")
        
        
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
        println("x = \(x)")
        
        //caluclate steps taken
        if(CMPedometer.isStepCountingAvailable()){
            let fromDate = NSDate(timeIntervalSinceReferenceDate: self.recordedLaps.last!)
            let toDate = NSDate(timeIntervalSinceReferenceDate: lapInterval)
            
            self.pedoMeter.queryPedometerDataFromDate(fromDate, toDate: toDate) { (data : CMPedometerData!, error) -> Void in
                println(data)
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    if(error == nil){
                        
                        //wait for # of steps to be returned, then update the lapTimes array
                        let lapString = "\(self.formatTimes(x) as String), \(data.numberOfSteps) steps"
                        println(lapString)
                        self.lapTimes.append(lapString)
                        

                    }
                }
                
            }

        }
        
//        lapTimes.append(formatTimes(x) as String)

        //add the current time as a lap timestamp
        println(lapInterval)
        recordedLaps.append(lapInterval)
        

    }
    
    func startTimer() {
        //get the time stoppwatch was started
        let fromDate = NSDate()
        let x = fromDate.timeIntervalSinceReferenceDate
        self.startTime = x
        
        self.isCounting = true
        
        
        if(CMPedometer.isStepCountingAvailable()){
            
//            let fromDate = NSDate(timeIntervalSinceReferenceDate: )
            self.pedoMeter.startPedometerUpdatesFromDate(fromDate) { (data: CMPedometerData!, error) -> Void in
                println("data: \(data)")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if(error == nil){
//                        let lapString = "\(self.formatTimes(x) as String), \(data.numberOfSteps) steps"
                    } else {
                        println("error: \(error)")
                    }
                })
            }
        }

        
        
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
