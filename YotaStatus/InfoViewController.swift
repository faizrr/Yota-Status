//
//  InfoViewController.swift
//  YotaStatus
//
//  Created by Roman Faizullin on 21.06.15.
//  Copyright (c) 2015 Roman Faizullin. All rights reserved.
//

import Cocoa

class InfoViewController: NSViewController {
    
    // MARK: - Settings
    
    @IBOutlet weak var settingsButton: NSButton!
    lazy var settingsWindow = SettingsViewController(windowNibName: "SettingsViewController")

    @IBAction func goToSettings(sender: AnyObject) {
        settingsWindow.showWindow(sender)
    }
    
    @IBAction func exitButtonPressed(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    // MARK: - Main Interface
    
    @IBOutlet weak var sinr: NSTextField!
    @IBOutlet weak var rsrp: NSTextField!
    @IBOutlet weak var curDown: NSTextField!
    @IBOutlet weak var curUp: NSTextField!
    @IBOutlet weak var maxDown: NSTextField!
    @IBOutlet weak var maxUp: NSTextField!
    @IBOutlet weak var bytesDown: NSTextField!
    @IBOutlet weak var bytesUp: NSTextField!
    @IBOutlet weak var time: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notConnected()
        update()
    }
    
    func notConnected() {
        self.sinr.stringValue = "---"
        self.rsrp.stringValue = "---"
        self.curDown.stringValue = "---"
        self.curUp.stringValue = "---"
        self.maxDown.stringValue = "---"
        self.maxUp.stringValue = "---"
        self.bytesDown.stringValue = "---"
        self.bytesUp.stringValue = "---"
        self.time.stringValue = "Нет соединения"
    }
    
    func update() {
        let ip = SettingsData.sharedInstance.ip
        let period = SettingsData.sharedInstance.period
        let url = NSURL(string: "http://"+ip+"/cgi-bin/sysconf.cgi?page=ajax&action=get_status")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if response == nil {
                self.notConnected()
            }
            
            let text = String(NSString(data: data, encoding: NSUTF8StringEncoding)!)
            let lines:[String] = text.componentsSeparatedByString("\n")
            for i in lines {
                if i.hasPrefix("State=") {
                    let t = (i as NSString).substringFromIndex(6)
                    if t != "Connected" {
                        self.notConnected()
                        break
                    }
                }
                else if i.hasPrefix("3GPP.SINR=") {
                    let t = (i as NSString).substringFromIndex(10)
                    self.sinr.stringValue = t
                }
                else if i.hasPrefix("3GPP.RSRP=") {
                    let t = (i as NSString).substringFromIndex(10)
                    self.rsrp.stringValue = t
                }
                else if i.hasPrefix("MaxDownlinkThroughput=") {
                    let t = (i as NSString).substringFromIndex(22)
                    let n = Double(t.toInt()!) / 1000
                    let str = NSString(format: "%.2f", n)
                    self.maxDown.stringValue = str as String
                }
                else if i.hasPrefix("MaxUplinkThroughput=") {
                    let t = (i as NSString).substringFromIndex(20)
                    let n = Double(t.toInt()!) / 1000
                    let str = NSString(format: "%.2f", n)
                    self.maxUp.stringValue = str as String
                }
                else if i.hasPrefix("CurDownlinkThroughput=") {
                    let t = (i as NSString).substringFromIndex(22)
                    let n = Double(t.toInt()!) / 1000
                    let str = NSString(format: "%.2f", n)
                    self.curDown.stringValue = str as String
                }
                else if i.hasPrefix("CurUplinkThroughput=") {
                    let t = (i as NSString).substringFromIndex(20)
                    let n = Double(t.toInt()!) / 1000
                    let str = NSString(format: "%.2f", n)
                    self.curUp.stringValue = str as String
                }
                else if i.hasPrefix("SentBytes=") {
                    let t = (i as NSString).substringFromIndex(10)
                    let n = t.toInt()! / 1000000
                    self.bytesDown.integerValue = n
                }
                else if i.hasPrefix("ReceivedBytes=") {
                    let t = (i as NSString).substringFromIndex(14)
                    let n = t.toInt()! / 1000000
                    self.bytesUp.integerValue = n
                }
                else if i.hasPrefix("ConnectedTime=") {
                    let t = (i as NSString).substringFromIndex(14)
                    let n = t.toInt()!
  
                    let hours = n / 3600
                    let minutes = (n%3600)/60
                    let seconds = minutes % 60
                    let str = "Время соединения: \(hours)ч \(minutes)м \(seconds)с"
                    
                    self.time.stringValue = str
                }
            }
            
        }
        task.resume()
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(period), target: self, selector: Selector("update"), userInfo: nil, repeats: false)
    }
    
}
