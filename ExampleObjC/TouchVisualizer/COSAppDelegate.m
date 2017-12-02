//
//  COSAppDelegate.m
//  TouchVisualizer
//
//  Created by Joe Blau on 3/22/14.
//  Copyright (c) 2014 conopsys. All rights reserved.
//

#import "COSAppDelegate.h"
#import <COSTouchVisualizerWindow.h>
#import <COSTouchConfig.h>

@implementation COSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (COSTouchVisualizerWindow *)window {
    static COSTouchVisualizerWindow *customWindow = nil;
    if (!customWindow) {
        COSTouchConfig *contactConfig = ({
            COSTouchConfig *config = [[COSTouchConfig alloc] initWithTouchConfigType:COSTouchConfigTpyeContact];
            config.fillColor = [UIColor purpleColor];
            config.strokeColor = [UIColor blueColor];
            config.alpha = 0.4;
            config;
        });
        
        COSTouchConfig *riippleConfig = ({
            COSTouchConfig *config = [[COSTouchConfig alloc] initWithTouchConfigType:COSTouchConfigTpyeRipple];
            config.fillColor = [UIColor purpleColor];
            config.strokeColor = [UIColor blueColor];
            config.alpha = 0.1;
            config;
        });
        
        customWindow = [[COSTouchVisualizerWindow alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                          morphEnabled:YES
                                                       touchVisibility:COSTouchVisualizerWindowTouchVisibilityRemoteAndLocal
                                                         contactConfig:contactConfig
                                                          rippleConfig:riippleConfig];
    }
    return customWindow;
}

@end
