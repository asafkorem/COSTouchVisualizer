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
        
        customWindow.fillColor = UIColor.purpleColor()
        customWindow.strokeColor = UIColor.blueColor()
        customWindow.touchAlpha = 0.4;
        
        customWindow.rippleFillColor = UIColor.purpleColor()
        customWindow.rippleStrokeColor = UIColor.blueColor()
        customWindow.touchAlpha = 0.1;
        
        customWindow.touchVisualizerWindowDelegate = self
        return customWindow
        }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    // MARK: - COSTouchVisualizerWindowDelegate

    func touchVisualizerWindowShouldAlwaysShowFingertip(window: COSTouchVisualizerWindow!) -> Bool {
        // Return YES to make the fingertip always display even if there's no any mirrored screen.
        // Return NO or don't implement this method if you want to keep the fingertip display only when
        // the device is connected to a mirrored screen.
        return true
    }

    func touchVisualizerWindowShouldShowFingertip(window: COSTouchVisualizerWindow!) -> Bool {
        // Return YES or don't implement this method to make this window show fingertip when necessary.
        // Return NO to make this window not to show fingertip.
        return true
    }
}
