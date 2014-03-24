//
//  COSTouchVisualizerWindow.h
//  
//
//  Created by Joe Blau on 3/22/14.
//
//

#import <UIKit/UIKit.h>

@interface COSTouchVisualizerWindow : UIWindow

@property (nonatomic, strong) UIImage *touchImage;
@property (nonatomic, assign) CGFloat touchAlpha;
@property (nonatomic, assign) NSTimeInterval fadeDuration;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

// Ripple Effects
@property (nonatomic, strong) UIImage *rippleImage;
@property (nonatomic, assign) CGFloat rippleAlpha;
@property (nonatomic, assign) NSTimeInterval rippleFadeDuration;
@property (nonatomic, strong) UIColor *rippleStrokeColor;
@property (nonatomic, strong) UIColor *rippleFillColor;

@end
