//
//  SleepyApp.swift
//  Sleepy
//
//  Created by Andrija Sokovic on 29. 10. 2025..
//

import SwiftUI

@main
struct SleepyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings { EmptyView() } // No settings window
    }
}
