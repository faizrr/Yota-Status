//
//  SettingsViewController.swift
//  YotaStatus
//
//  Created by Roman Faizullin on 21.06.15.
//  Copyright (c) 2015 Roman Faizullin. All rights reserved.
//

import Cocoa

class SettingsViewController: NSWindowController {

    @IBOutlet weak var address: NSTextField!
    @IBOutlet weak var period: NSTextField!
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        address.stringValue = SettingsData.sharedInstance.ip
        period.stringValue = String(SettingsData.sharedInstance.period)
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        SettingsData.sharedInstance.ip = address.stringValue
        if let t = period.stringValue.toInt() as Int! {
            SettingsData.sharedInstance.period = t
        }
        
    }
}
