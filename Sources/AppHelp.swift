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

    /// Title is kept here as window get initialized multiple times
    private var windowTitle = ""
    private var window: NSWindow?
    
    var topics: (() -> [HelpTopic])!
    var scheme: String?

    public func initialise(title: String, scheme: String?, @HelpBuilder _ topics: @escaping () -> [HelpTopic]) {
        windowTitle = title
        self.scheme = scheme
        self.topics = topics
    }

    private func getWindow() -> NSWindow {
        if let window {
            return window
        }
        let window = NSWindow(contentRect: .zero, styleMask: [.titled, .closable, .resizable, .fullSizeContentView], backing: .buffered, defer: false)
        window.delegate = self
        window.isReleasedWhenClosed = false
        window.title = windowTitle
        window.center()
        return window
    }

    public func showWindow(selected: String? = nil) {
        window = getWindow()

        let helpView = HelpContainerView(selectedTopic: selected, topics: topics())
        window!.contentViewController = NSHostingController(rootView: helpView)
        window?.makeKeyAndOrderFront(nil)
    }

    public func windowWillClose(_ notification: Notification) {
        if let w = notification.object as? NSWindow, w === self.window {
            self.window = nil
        }
    }
}

extension String: LocalizedError {}
