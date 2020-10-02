//
//  PageTurnTimer.swift
//  Runner
//
//  Created by Joe Kletz on 02/10/2020.
//

import Foundation


class PageTurnTimer : NSObject{
    let text:StoryText
    
    var timeStart : Double
    var secondsPassed = 0
    
    init(text:StoryText) {
        self.text = text
        
        //timer.fire()
        let startInterval = Date().timeIntervalSince1970
        print(startInterval)
        timeStart = startInterval * 1000
        print(timeStart)
    }
    
    
    
    func endTimer() { // Perhaps add page in here
//         let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        let endInterval = Date().timeIntervalSince1970
        let endMillis = endInterval * 1000
        
        let timeInMillis = Int(endMillis - timeStart)
        print("Milli: \(timeInMillis)")
    }
    
    let couplet = [(2,234),(234,78)]
    
    
    
    //Create timer
    //Create struct that keeps list of pages and time on each page
    
//    let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
   
    
//    @objc
//    func fireTimer(){
//        secondsPassed += 1
//        print("Seconds : \(secondsPassed)")
//    }
    
}

extension TimeInterval {
     var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }

    private var seconds: Int {
        return Int(self) % 60
    }

    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

    private var hours: Int {
        return Int(self) / 3600
    }

    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
}
