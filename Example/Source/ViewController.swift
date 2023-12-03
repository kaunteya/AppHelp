//
//  ViewController.swift
//  MyGreatApp
//
//  Created by Kauntey Suryawanshi on 22/11/23.
//

import Cocoa
import AppHelp

class ViewController: NSViewController {


    @IBAction func btnpress(_ sender: Any) {
        AppHelp.shared.showWindow(selected: "Everything")
    }
    
    @IBAction func formatedHelpbutton(_ sender: Any) {
        AppHelp.shared.showWindow(selected: "Big")
    }
}

