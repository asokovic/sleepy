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

    static func buildCommand(_ action: String, _ scheduleType: String, _ hours: Int, _ minutes: Int, _ date: Date) -> String? {
        
        guard hours >= 0, minutes >= 0 else {
            return nil
        }
        if scheduleType == "At", date < Date() {
            return nil
        }
        
        if scheduleType == "In" {
            let total = max((hours * 60) + minutes, 1)
            switch action {
            case "Shutdown":
                return "sudo shutdown -h +\(total)"
            case "Restart":
                return "sudo shutdown -r +\(total)"
            case "Sleep":
                return "sudo shutdown -s +\(total)"
            default:
                return nil
            }
        } else if scheduleType == "At" {
            let f = DateFormatter(); f.dateFormat = "yyMMddHHmm"
            let str = f.string(from: date)
            switch action {
            case "Shutdown":
                return "sudo shutdown -h \(str)"
            case "Restart":
                return "sudo shutdown -r \(str)"
            case "Sleep":
                return "sudo shutdown -s \(str)"
            default:
                return nil
            }
            
        }
        return nil;
    }
}
