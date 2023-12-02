//
//  HelpManager.swift
//  MyGreatApp
//
//  Created by Kauntey Suryawanshi on 23/11/23.
//

import Cocoa
import SwiftUI

public class AppHelp: NSObject, NSWindowDelegate {
    public static var shared = AppHelp()
    var helpModel: HelpModel = HelpModel()

    private var windowTitle = ""

    private var window: NSWindow?

    public func initialise(title: String, scheme: String?) {
        windowTitle = title
        helpModel.scheme = scheme
    }

    public func setTopics(_ topics: [HelpTopic]) {
        helpModel.items = topics
    }

    func getWindow() -> NSWindow {
        if let window {
            return window
        }
        let window = NSWindow(contentRect: .zero, styleMask: [.titled, .closable, .resizable, .fullSizeContentView], backing: .buffered, defer: false)
        window.delegate = self
        window.isReleasedWhenClosed = false
        let helpView = HelpContainerView().environmentObject(helpModel)
        window.contentViewController = NSHostingController(rootView: helpView)
        window.title = windowTitle
        window.center()
        return window
    }

    public func showWindow(selected: String? = nil) {
        helpModel.selectedTopic = selected
        window = getWindow()
        let helpView = HelpContainerView().environmentObject(helpModel)
        window?.contentViewController = NSHostingController(rootView: helpView)
        window?.makeKeyAndOrderFront(nil)
    }

    public func windowWillClose(_ notification: Notification) {
        if let w = notification.object as? NSWindow, w === self.window {
            self.window = nil
        }
    }
}

extension String: LocalizedError {}
