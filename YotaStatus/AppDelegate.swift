//
//  AppDelegate.swift
//  YotaStatus
//
//  Created by Roman Faizullin on 21.06.15.
//  Copyright (c) 2015 Roman Faizullin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "yota")
            button.action = Selector("togglePopover:")
        }
        popover.contentViewController = InfoViewController(nibName: "InfoViewController", bundle: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func showPopover(sender: AnyObject?){
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSMinYEdge)
        }
    }
    
    func closePopover(sender: AnyObject?){
        popover.performClose(sender)
    }
    
    func togglePopover(sender: AnyObject?){
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func rightClick(sender: AnyObject?) {
        print("right click\n")
    }

}

