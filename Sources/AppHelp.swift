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
    var items: (() -> [HelpTopic])!

    public func initialise(title: String, scheme: String?, @HelpBuilder _ topics: @escaping () -> [HelpTopic]) {
        windowTitle = title
        helpModel.scheme = scheme
        items = topics
    }

    func getWindow() -> NSWindow {
        if let window {
            return window
        }
        let window = NSWindow(contentRect: .zero, styleMask: [.titled, .closable, .resizable, .fullSizeContentView], backing: .buffered, defer: false)
        window.delegate = self
        window.isReleasedWhenClosed = false
        let helpView = HelpContainerView(topics: items()).environmentObject(helpModel)
        window.contentViewController = NSHostingController(rootView: helpView)
        window.title = windowTitle
        window.center()
        return window
    }

    public func showWindow(selected: String? = nil) {
        helpModel.selectedTopic = selected
        window = getWindow()
        window?.makeKeyAndOrderFront(nil)
    }

    public func windowWillClose(_ notification: Notification) {
        if let w = notification.object as? NSWindow, w === self.window {
            self.window = nil
        }
    }
}

extension String: LocalizedError {}
