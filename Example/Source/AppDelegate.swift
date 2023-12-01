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
        AppHelp.shared.initialise(title: "Quick Note Help", scheme: "quicknote")
        
        AppHelp.shared.setTopics([
            try! .init(markdownFileName: "Everything"),
            try! .init(markdownFileName: "DemoNote"),
            try! .init(markdownFileName: "Big"),
            .init(id: "contact", title: "Contact Us", view: AnyView(ContactView()))
        ])
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @IBAction func showHelp(_ sender: Any?) {
//        AppHelp.shared.showWindow(selected: .iCloudHelp)
    }
}
