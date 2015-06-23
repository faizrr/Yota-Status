//
//  InfoViewController.swift
//  YotaStatus
//
//  Created by Roman Faizullin on 21.06.15.
//  Copyright (c) 2015 Roman Faizullin. All rights reserved.
//

import Cocoa

class InfoViewController: NSViewController {
    
    @IBOutlet weak var settingsButton: NSButton!
    lazy var settingsWindow = SettingsViewController(windowNibName: "SettingsViewController")
    let settings = NSUserDefaults.standardUserDefaults()
    
    var ip = ""
    var period = 1
    
    @IBAction func goToSettings(sender: AnyObject) {
        settingsWindow.showWindow(sender)
    }
    
    @IBAction func exitButtonPressed(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentip = settings.stringForKey("IP"){
            ip = currentip
        }
        else {
            settings.setObject("192.168.0.1", forKey: "IP")
            ip = "192.168.0.1"
        }
        
        if let currentperiod = settings.integerForKey("Period") as Int!{
            period = currentperiod
        }
        else {
            settings.setObject("2", forKey: "Period")
            period = 2
        }
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(period), target: self, selector: Selector("update"), userInfo: nil, repeats: false)
        
    }
    
    func doSmth() {
        
    }
    
    func update() {
        
        doSmth()
        /*
        let currentperiod = settings.integerForKey("Period")
        let timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(period), target: self, selector: Selector("update"), userInfo: nil, repeats: false)
        
        
        /*
        let url = NSURL(string: "http://"+ip+"/cgi-bin/sysconf.cgi?page=ajax&action=get_status&time=1434886276974")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            
            let text = String(contentsOfFile: data, encoding: NSUTF8StringEncoding, error: <#NSErrorPointer#>)
            let lines : [String] = text.componentsSeparatedByString("\n")
            
            var a = 0
            for i in lines {
                print(i)
                a+=1
                print(a)
                println()
            }
            
        }
        task.resume()
        */
*/
    }
    
}
