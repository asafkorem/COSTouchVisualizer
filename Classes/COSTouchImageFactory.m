//
//  COSTouchImageFactory.m
//  COSTouchVisualizer
//
//  Created by Joseph Blau on 12/2/17.
//  Copyright © 2017 conopsys. All rights reserved.
//

#import "COSTouchImageFactory.h"
#import "COSTouchConfig.h"

static const CGFloat COSTouchImageFactorySideSize = 50.0f;

@implementation COSTouchImageFactory

+(UIImage *)imageWithTouchConfig:(COSTouchConfig *)touchConfig {
    UIImage *touchImage = ({
        UIImage *image = [UIImage new];
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake(0.0f,
                                                                             0.0f,
                                                                             COSTouchImageFactorySideSize,
                                                                             COSTouchImageFactorySideSize)];
        UIGraphicsBeginImageContextWithOptions(clipPath.bounds.size, NO, 0);
        CGPoint center = CGPointMake(COSTouchImageFactorySideSize / 2.0f,
                                      COSTouchImageFactorySideSize / 2.0f);
        
        UIBezierPath *drawPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:22.0
                                                            startAngle:0
                                                              endAngle:2 * M_PI
                                                             clockwise:YES];
        drawPath.lineWidth = 2.0;
        
        [touchConfig.strokeColor setStroke];
        [touchConfig.fillColor setFill];
        
        [drawPath stroke];
        [drawPath fill];
        [clipPath addClip];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        image;
    });
    return touchImage;
}

@end
