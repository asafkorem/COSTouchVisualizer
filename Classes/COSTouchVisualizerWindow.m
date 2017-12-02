//
//  COSTouchVisualizerWindow.m
//  TouchVisualizer
//
//  Created by Joe Blau on 3/22/14.
//  Copyright (c) 2014 conopsys. All rights reserved.
//

#import "COSTouchVisualizerWindow.h"
#import "COSOverlayVisualizerWindow.h"
#import "COSTouchImageView.h"
#import "COSTouchConfig.h"
#import "COSTouchImageFactory.h"

static const NSTimeInterval COSTouchVisualizerWindowRemoveDelay = 0.2;

@interface COSTouchVisualizerWindow ()

@property (nonatomic) UIWindow *overlayWindow;
@property (nonatomic) UIViewController *overlayWindowViewController;
@property (nonatomic) BOOL fingerTipRemovalScheduled;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSSet *allTouches;

@property (nonatomic) UIImage *touchImage;
@property (nonatomic) UIImage *rippleImage;

@property (nonatomic) COSTouchConfig *touchContactConfig;
@property (nonatomic) COSTouchConfig *touchRippleConfig;

@end

@implementation COSTouchVisualizerWindow

- (instancetype)initWithFrame:(CGRect)frame
                 morphEnabled:(BOOL)morphEnabled
              touchVisibility:(COSTouchVisualizerWindowTouchVisibility)touchVisibility
                contactConfig:(COSTouchConfig *)contactConfig
                 rippleConfig:(COSTouchConfig *)rippleConfig {
    self = [super initWithFrame:frame];
    if (self) {
        _morphEnabled = morphEnabled;
        _touchVisibility = touchVisibility;
        _touchContactConfig = contactConfig ?: [[COSTouchConfig alloc] initWithTouchConfigType:COSTouchConfigTpyeContact];
        _touchRippleConfig = rippleConfig ?: [[COSTouchConfig alloc] initWithTouchConfigType:COSTouchConfigTpyeRipple];
    }
    return self;
}

#pragma mark - Touch / Ripple and Images

- (UIImage *)touchImage {
    if (!_touchImage) {
        _touchImage = [COSTouchImageFactory imageWithTouchConfig:self.touchContactConfig];
    }
    return _touchImage;
}

- (UIImage *)rippleImage {
    if (!_rippleImage) {
        _rippleImage = [COSTouchImageFactory imageWithTouchConfig:self.touchRippleConfig];
    }
    return _rippleImage;
}

#pragma mark - Active

- (BOOL)anyScreenIsMirrored {
    if (![UIScreen instancesRespondToSelector:@selector(mirroredScreen)])
        return NO;

    for (UIScreen *screen in [UIScreen screens]) {
        if ([screen mirroredScreen] != nil) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - UIWindow overrides

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
    
    switch (self.touchVisibility) {
        case COSTouchVisualizerWindowTouchVisibilityNever:
            return;
            break;
            
        case COSTouchVisualizerWindowTouchVisibilityRemoteOnly:
        case COSTouchVisualizerWindowTouchVisibilityRemoteAndLocal: {
            self.allTouches = [event allTouches];
            for (UITouch *touch in [self.allTouches allObjects]) {
                switch (touch.phase) {
                    case UITouchPhaseBegan:
                    case UITouchPhaseMoved: {
                        // Generate ripples
                        COSTouchImageView *rippleView = [[COSTouchImageView alloc] initWithImage:self.rippleImage];
                        [self.overlayWindow addSubview:rippleView];
                        
                        rippleView.alpha = self.touchRippleConfig.alpha;
                        rippleView.center = [touch locationInView:self.overlayWindow];
                        
                        [UIView animateWithDuration:self.touchRippleConfig.fadeDuration
                                              delay:0.0
                                            options:UIViewAnimationOptionCurveEaseIn
                                         animations:^{
                                             [rippleView setAlpha:0.0];
                                             [rippleView setFrame:CGRectInset(rippleView.frame, 25, 25)];
                                         } completion:^(BOOL finished) {
                                             [rippleView removeFromSuperview];
                                         }];
                    }
                    case UITouchPhaseStationary: {
                        COSTouchImageView *touchView = (COSTouchImageView *)[self.overlayWindow viewWithTag:touch.hash];
                        
                        if (touch.phase != UITouchPhaseStationary && touchView != nil && [touchView isFadingOut]) {
                            [self.timer invalidate];
                            [touchView removeFromSuperview];
                            touchView = nil;
                        }
                        
                        if (touchView == nil && touch.phase != UITouchPhaseStationary) {
                            touchView = [[COSTouchImageView alloc] initWithImage:self.touchImage];
                            [self.overlayWindow addSubview:touchView];
                            
                            if (self.morphEnabled) {
                                if (self.timer) {
                                    [self.timer invalidate];
                                }
                                
                                self.timer = [NSTimer scheduledTimerWithTimeInterval:0.6
                                                                              target:self
                                                                            selector:@selector(performMorphWithTouchView:)
                                                                            userInfo:touchView
                                                                             repeats:YES];
                            }
                        }
                        if (![touchView isFadingOut]) {
                            touchView.alpha = self.touchContactConfig.alpha;
                            touchView.center = [touch locationInView:self.overlayWindow];
                            touchView.tag = touch.hash;
                            touchView.timestamp = touch.timestamp;
                            touchView.shouldAutomaticallyRemoveAfterTimeout = [self shouldAutomaticallyRemoveFingerTipForTouch:touch];
                        }
                        break;
                    }
                    case UITouchPhaseEnded:
                    case UITouchPhaseCancelled: {
                        [self removeFingerTipWithHash:touch.hash animated:YES];
                        break;
                    }
                }
            }
            

            break;
        }
    }
    
    [self scheduleFingerTipRemoval];    // We may not see all UITouchPhaseEnded/UITouchPhaseCancelled events.
}


- (UIWindow *)overlayWindow {
    if (!_overlayWindow) {
        _overlayWindow = [[COSOverlayVisualizerWindow alloc] initWithFrame:self.frame];
        _overlayWindow.userInteractionEnabled = NO;
        _overlayWindow.windowLevel = UIWindowLevelStatusBar;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.hidden = NO;
    }
    return _overlayWindow;
}
#pragma mark - Private

- (void)scheduleFingerTipRemoval {
    if (self.fingerTipRemovalScheduled) {
        return;
    }
    self.fingerTipRemovalScheduled = YES;
    [self performSelector:@selector(removeInactiveFingerTips)
               withObject:nil
               afterDelay:0.1];
}

- (void)cancelScheduledFingerTipRemoval {
    self.fingerTipRemovalScheduled = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(removeInactiveFingerTips)
                                               object:nil];
}

- (void)removeInactiveFingerTips {
    self.fingerTipRemovalScheduled = NO;

    NSTimeInterval now = [[NSProcessInfo processInfo] systemUptime];
    
    for (COSTouchImageView *touchView in [self.overlayWindow subviews]) {
        if (![touchView isKindOfClass:[COSTouchImageView class]]) {
            continue;
        }

        if (touchView.shouldAutomaticallyRemoveAfterTimeout && now > touchView.timestamp + COSTouchVisualizerWindowRemoveDelay) {
            [self removeFingerTipWithHash:touchView.tag animated:YES];
        }
    }

    if ([[self.overlayWindow subviews] count]) {
        [self scheduleFingerTipRemoval];
    }
}

- (void)removeFingerTipWithHash:(NSUInteger)hash animated:(BOOL)animated {
    COSTouchImageView *touchView = (COSTouchImageView *)[self.overlayWindow viewWithTag:hash];
    if (touchView == nil || [touchView isFadingOut]) {
        return;
    }

    BOOL animationsWereEnabled = [UIView areAnimationsEnabled];

    if (animated) {
        [UIView setAnimationsEnabled:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:self.touchContactConfig.fadeDuration];
    }

    touchView.frame = CGRectMake(touchView.center.x - touchView.frame.size.width,
                                 touchView.center.y - touchView.frame.size.height,
                                 touchView.frame.size.width * 2, touchView.frame.size.height * 2);

    touchView.alpha = 0.0;

    if (animated) {
        [UIView commitAnimations];
        [UIView setAnimationsEnabled:animationsWereEnabled];
    }

    touchView.fadingOut = YES;
    [touchView performSelector:@selector(removeFromSuperview)
                    withObject:nil
                    afterDelay:self.touchContactConfig.fadeDuration];
}

- (BOOL)shouldAutomaticallyRemoveFingerTipForTouch:(UITouch *)touch;
{
    // We don't reliably get UITouchPhaseEnded or UITouchPhaseCancelled
    // events via -sendEvent: for certain touch events. Known cases
    // include swipe-to-delete on a table view row, and tap-to-cancel
    // swipe to delete. We automatically remove their associated
    // fingertips after a suitable timeout.
    //
    // It would be much nicer if we could remove all touch events after
    // a suitable time out, but then we'll prematurely remove touch and
    // hold events that are picked up by gesture recognizers (since we
    // don't use UITouchPhaseStationary touches for those. *sigh*). So we
    // end up with this more complicated setup.

    UIView *touchView = [touch view];
    touchView = [touchView hitTest:[touch locationInView:touchView] withEvent:nil];

    while (touchView != nil) {
        if ([touchView isKindOfClass:[UITableViewCell class]]) {
            for (UIGestureRecognizer *recognizer in [touch gestureRecognizers]) {
                if ([recognizer isKindOfClass:[UISwipeGestureRecognizer class]])
                    return YES;
            }
        }

        if ([touchView isKindOfClass:[UITableView class]] &&
            [[touch gestureRecognizers] count] == 0) {
            return YES;
        }
        touchView = touchView.superview;
    }

    return NO;
}

- (void)performMorphWithTouchView:(COSTouchImageView *)touchView {
    NSTimeInterval duration = .4;
    NSTimeInterval delay = 0;
    // Start
    touchView.alpha = self.touchContactConfig.alpha;
    touchView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:duration / 4
        delay:delay
        options:0
        animations:^{
          // End
          touchView.transform = CGAffineTransformMakeScale(1, 1.2);
        }
        completion:^(BOOL finished) {
          [UIView animateWithDuration:duration / 4
              delay:0
              options:0
              animations:^{
                // End
                touchView.transform = CGAffineTransformMakeScale(1.2, 0.9);
              }
              completion:^(BOOL finished) {
                [UIView animateWithDuration:duration / 4
                    delay:0
                    options:0
                    animations:^{
                      // End
                      touchView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                    }
                    completion:^(BOOL finished) {
                      [UIView animateWithDuration:duration / 4
                          delay:0
                          options:0
                          animations:^{
                            // End
                            touchView.transform = CGAffineTransformMakeScale(1, 1);
                          }
                          completion:^(BOOL finished){
                              // If there are no touches, remove this morping touch
                              if (self.allTouches.count == 0) {
                                  [touchView removeFromSuperview];
                              }
                          }];
                    }];
              }];
        }];
}

@end
