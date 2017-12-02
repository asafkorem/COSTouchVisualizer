//
//  COSTouchImageFactory.h
//  COSTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COSTouchConfig;

@interface COSTouchImageFactory : NSObject

+(nonnull UIImage *)imageWithTouchConfig:(nonnull COSTouchConfig*)touchConfig;

-(nonnull instancetype)init NS_UNAVAILABLE;

@end
