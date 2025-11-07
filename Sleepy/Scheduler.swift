//
//  Scheduler.swift
//  Sleepy
//
//  Created by Andrija Sokovic on 7. 11. 2025..
//

import Foundation

struct Scheduler {
    enum Action: String {
            case shutdown = "Shutdown"
            case restart = "Restart"
            case sleep = "Sleep"
        }

        enum ScheduleType: String {
            case inTime = "In"
            case atTime = "At"
        }

    static func buildCommand(_ action: Action, _ scheduleType: ScheduleType, _ hours: Int, _ minutes: Int, _ date: Date) -> String? {
        
        guard hours >= 0, minutes >= 0 else {
            return nil
        }
        if scheduleType == .atTime, date < Date() {
            return nil
        }
        
        if scheduleType == .inTime {
            let total = max((hours * 60) + minutes, 1)
            switch action {
            case .shutdown: 
                return "sudo shutdown -h +\(total)"
            case .restart:  
                return "sudo shutdown -r +\(total)"
            case .sleep:    
                return "sudo shutdown -s +\(total)"
            }
        } else {
            let f = DateFormatter(); f.dateFormat = "yyMMddHHmm"
            let str = f.string(from: date)
            switch action {
            case .shutdown: 
                return "sudo shutdown -h \(str)"
            case .restart:  
                return "sudo shutdown -r \(str)"
            case .sleep:    
                return "sudo shutdown -s \(str)"
            }
        }
    }
}
