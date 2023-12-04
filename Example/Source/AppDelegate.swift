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

    func applicationWillFinishLaunching(_ notification: Notification) {
        NSAppleEventManager.shared().setEventHandler(
            self,
            andSelector: #selector(AppDelegate.handleURLEvent(_:withReply:)),
            forEventClass: AEEventClass(kInternetEventClass),
            andEventID: AEEventID(kAEGetURL)
        )
    }

    /// Gets called when the App launches/opens via URL
    @objc func handleURLEvent(_ event: NSAppleEventDescriptor, withReply reply: NSAppleEventDescriptor) {
        guard
            let eventURL = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue,
            let component = URLComponents(string: eventURL)
        else { return }
        if component.host == "help" {
            if let gg = component.path.split(separator: "/").first {
                AppHelp.shared.showWindow(selected: String(gg))
            }
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        AppHelp.shared.initialise(title: "Example app Help", scheme: "mygreatapp") {
            HelpTopic(markdownFileName: "Welcome")
            HelpTopic(markdownFileName: "Everything")
            HelpGroup("Purchase") {
                HelpTopic(id: "contact", title: "Contact Us", view: AnyView(ContactView()))
            }
            HelpTopic(markdownFileName: "Formatting")
        }
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @IBAction func showHelp(_ sender: Any?) {
        AppHelp.shared.showWindow(selected: "welcome")
    }
}
