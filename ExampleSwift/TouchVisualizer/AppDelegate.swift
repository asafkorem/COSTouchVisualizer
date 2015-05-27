//
//  AppDelegate.swift
//  TouchVisualizer
//
//  Created by Joseph Blau on 5/18/15.
//  Copyright (c) 2015 Conopsys. All rights reserved.
//

import UIKit
import COSTouchVisualizer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, COSTouchVisualizerWindowDelegate {

    lazy var window: UIWindow? = {
        var customWindow = COSTouchVisualizerWindow(frame: UIScreen.mainScreen().bounds)
        customWindow.touchVisualizerWindowDelegate = self
        return customWindow
        }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }

    func touchVisualizerWindowShouldAlwaysShowFingertip(window: COSTouchVisualizerWindow!) -> Bool {
        return true
    }
}

