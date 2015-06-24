//
//  SettingsData.swift
//  YotaStatus
//
//  Created by Roman Faizullin on 23.06.15.
//  Copyright (c) 2015 Roman Faizullin. All rights reserved.
//

import Cocoa

class SettingsData {
    static let sharedInstance = SettingsData()
    
    var ip: String {
        willSet {
            let storedSettings = NSUserDefaults.standardUserDefaults()
            storedSettings.setObject(newValue, forKey: "IP")
        }
    }
    var period: Int {
        willSet {
            let storedSettings = NSUserDefaults.standardUserDefaults()
            storedSettings.setObject(newValue, forKey: "Period")
        }
    }
    
    init() {
        let storedSettings = NSUserDefaults.standardUserDefaults()
        
        if let currentip = storedSettings.stringForKey("IP"){
            self.ip = currentip
        }
        else {
            storedSettings.setObject("status.yota.ru", forKey: "IP")
            self.ip = "192.168.0.1"
        }
        
        if let currentperiod = storedSettings.integerForKey("Period") as Int!{
            self.period = currentperiod
        }
        else {
            storedSettings.setObject("2", forKey: "Period")
            self.period = 2
        }
    }
}
