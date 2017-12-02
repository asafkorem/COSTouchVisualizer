//
//  COSTouchConfig.h
//  COSTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, COSTouchConfigTpye) {
    COSTouchConfigTpyeContact,
    COSTouchConfigTpyeRipple,
};

@interface COSTouchConfig : NSObject

@property (nonatomic) CGFloat alpha;
@property (nonatomic) NSTimeInterval fadeDuration;
@property (nonatomic, nullable) UIColor *strokeColor;
@property (nonatomic, nullable) UIColor *fillColor;

-(nonnull instancetype)initWithTouchConfigType:(COSTouchConfigTpye)configType NS_DESIGNATED_INITIALIZER;
-(nonnull instancetype)init NS_UNAVAILABLE;

@end
