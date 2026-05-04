//
//  ViewController.swift
//  ⌘英かな
//
//  MIT License
//  Copyright (c) 2016 iMasanari
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var showIcon: NSButton!
    @IBOutlet weak var lunchAtStartup: NSButton!
    @IBOutlet weak var checkUpdateAtlaunch: NSButton!
    @IBOutlet weak var updateButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let showIconState = userDefaults.object(forKey: "showIcon")
        showIcon.state = NSControl.StateValue(rawValue: showIconState == nil ? 1 : showIconState as! Int)
        
        if #available(OSX 10.12, *) {
        } else {
            showIcon.title += "（macOS Sierraのみ）"
            showIcon.isEnabled = false
        }
        
        lunchAtStartup.state = NSControl.StateValue(rawValue: userDefaults.integer(forKey: "lunchAtStartup"))
        checkUpdateAtlaunch.state = NSControl.StateValue(rawValue: userDefaults.integer(forKey: "checkUpdateAtlaunch"))
    }


    private func showLaunchAtStartupError(_ error: LaunchAtStartupError) {
        let alert = NSAlert()

        switch error {
        case .permissionDenied:
            alert.messageText = "ログイン項目の変更が許可されていません"
            alert.informativeText = "システム設定 > 一般 > ログイン項目で、⌘英かなのバックグラウンド項目を許可してから再度お試しください。"
        case .unavailable:
            alert.messageText = "ログイン項目の変更に失敗しました"
            alert.informativeText = "macOSの状態により変更できない可能性があります。時間をおいて再度お試しください。"
        case .unknown:
            alert.messageText = "ログイン項目の変更時にエラーが発生しました"
            alert.informativeText = "システム設定 > 一般 > ログイン項目を確認してから再度お試しください。"
        }

        alert.runModal()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @available(OSX 10.12, *)
    @IBAction func clickShowIcon(_ sender: AnyObject) {
        statusItem.isVisible = (showIcon.state == NSControl.StateValue.on)
        userDefaults.set(showIcon.state, forKey: "showIcon")
    }
    @IBAction func clickLunchAtStartup(_ sender: AnyObject) {
        let enabled = (lunchAtStartup.state == NSControl.StateValue.on)
        let result = setLaunchAtStartup(enabled)

        switch result {
        case .success:
            userDefaults.set(lunchAtStartup.state, forKey: "lunchAtStartup")
        case .failure(let error):
            lunchAtStartup.state = enabled ? .off : .on
            userDefaults.set(lunchAtStartup.state, forKey: "lunchAtStartup")
            showLaunchAtStartupError(error)
        }
    }
    @IBAction func clickCheckUpdateAtlaunch(_ sender: AnyObject) {
        userDefaults.set(checkUpdateAtlaunch.state, forKey: "checkUpdateAtlaunch")
    }
    @IBAction func test(_ sender: Any) {
        
    }
    
    @IBAction func checkUpdateButton(_ sender: AnyObject) {
        updateButton.isEnabled = false
        checkUpdate({ (isNewVer: Bool?) -> Void in
            self.updateButton.isEnabled = true
            if isNewVer == nil {
                let alert = NSAlert()
                
                alert.messageText = "通信に失敗しました"
                alert.informativeText = "時間をおいて試してください"
                
                alert.runModal()
            }
            else if isNewVer == false {
                let alert = NSAlert()
                
                alert.messageText = "最新バージョンです"
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                alert.informativeText = "ver.\(version)"
                
                alert.runModal()
            }
        })
    }
}

