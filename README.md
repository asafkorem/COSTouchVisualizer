# COSTouchVisualizer

![COSTouchVisualizer](https://raw.githubusercontent.com/conopsys/COSTouchVisualizer/master/touchvisdemo.gif "COSTouchVisualizer iOS")

[![Version](http://cocoapod-badges.herokuapp.com/v/COSTouchVisualizer/badge.png)](http://cocoadocs.org/docsets/COSTouchVisualizer)
[![Platform](http://cocoapod-badges.herokuapp.com/p/COSTouchVisualizer/badge.png)](http://cocoadocs.org/docsets/COSTouchVisualizer)

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

**With Storyboards**

 in your `AppDelegate` implementation simply add the following getter

```objective-c
#import <COSTouchVisualizerWindow.h>

...

// Add this method to your AppDelegate method
- (COSTouchVisualizerWindow *)window
{
    static COSTouchVisualizerWindow *customWindow = nil;
    if (!customWindow) customWindow = [[COSTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    return customWindow;
}
```

**Without Storyboards**
```objective-c
#import <COSTouchVisualizerWindow.h>

...

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup window
    self.window = [[COSTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    ...

}
```

**Debugging Mode**

To enable debugging mode, edit the `COSTouchVisualizerWindow.m` file in the Pods Project under Pods/COSTouchVisualizerWindow/COSTouchVisualizerWindow.m

```objective-c
#ifdef TARGET_IPHONE_SIMULATOR
#define DEBUG_FINGERTIP_WINDOW 0
#else
#define DEBUG_FINGERTIP_WINDOW 0
#endif
```

**Customization**

```objective-c
// Add these lines after the windows is initialized
// Touch Color
[customWindow setFillColor:[UIColor yellowColor]];
[customWindow setStrokeColor:[UIColor purpleColor]];
[customWindow setTouchAlpha:0.4];
// Ripple Color
[customWindow setRippleFillColor:[UIColor yellowColor]];
[customWindow setRippleStrokeColor:[UIColor purpleColor]];
[customWindow setRippleAlpha:0.1];
```

## Requirements

This project requires ARC.

## Installation

COSTouchVisualizer is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "COSTouchVisualizer"

## Author

Joe Blau, josephblau@gmail.com

## License

COSTouchVisualizer is available under the MIT license. See the LICENSE file for more info.
