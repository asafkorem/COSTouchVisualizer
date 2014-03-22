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

@end
