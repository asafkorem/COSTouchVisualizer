//
//  COSTouchVisualizerWindow.h
//  TouchVisualizer
//
//  Created by Joe Blau on 3/22/14.
//  Copyright (c) 2014 conopsys. All rights reserved.
//
#include <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, COSTouchVisualizerWindowTouchVisibility) {
    COSTouchVisualizerWindowTouchVisibilityNever,
    COSTouchVisualizerWindowTouchVisibilityRemoteOnly,
    COSTouchVisualizerWindowTouchVisibilityRemoteAndLocal,
};

@class COSTouchVisualizerWindow;
@class COSTouchConfig;

@interface COSTouchVisualizerWindow : UIWindow

@property (nonatomic, readonly, getter=isMorphEnabled) BOOL morphEnabled;
@property (nonatomic, readonly, nonnull) COSTouchConfig *touchContactConfig;
@property (nonatomic, readonly, nonnull) COSTouchConfig *touchRippleConfig;
@property (nonatomic, readonly) COSTouchVisualizerWindowTouchVisibility touchVisibility;

-(nonnull instancetype)initWithFrame:(CGRect)frame
                        morphEnabled:(BOOL)morphEnabled
                          touchVisibility:(COSTouchVisualizerWindowTouchVisibility)touchVisibility
                       contactConfig:(nullable COSTouchConfig*)contactConfig
                        rippleConfig:(nullable COSTouchConfig*)rippleConfig NS_DESIGNATED_INITIALIZER;
-(nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
-(nonnull instancetype)init NS_UNAVAILABLE;
-(nonnull instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;


@end


