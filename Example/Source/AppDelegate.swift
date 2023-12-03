//
//  AppDelegate.swift
//  MyGreatApp
//
//  Created by Kauntey Suryawanshi on 22/11/23.
//

import Cocoa
import AppHelp
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        AppHelp.shared.initialise(title: "Quick Note Help", scheme: "quicknote") {
            HelpTopic(markdownFileName: "Everything")
            HelpTopic(markdownFileName: "Big")
            HelpTopic(groupName: "Purchase", topics: [
                HelpTopic(markdownFileName: "DemoNote")
            ])
        }
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @IBAction func showHelp(_ sender: Any?) {
//        AppHelp.shared.showWindow(selected: .iCloudHelp)
    }
}
