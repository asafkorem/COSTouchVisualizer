//
//  COSTouchSpotView.h
//  COSTouchVisualizer
//
//  Created by Joseph Blau on 11/30/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COSTouchImageView : UIImageView

@property (nonatomic) NSTimeInterval timestamp;
@property (nonatomic) BOOL shouldAutomaticallyRemoveAfterTimeout;
@property (nonatomic, getter=isFadingOut) BOOL fadingOut;

@end
