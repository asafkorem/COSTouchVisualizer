# COSTouchVisualizer

![COSTouchVisualizer](https://raw.githubusercontent.com/conopsys/COSTouchVisualizer/master/touchvisdemo.gif "COSTouchVisualizer iOS")

[![Version](http://cocoapod-badges.herokuapp.com/v/COSTouchVisualizer/badge.png)](http://cocoadocs.org/docsets/COSTouchVisualizer)
[![Platform](http://cocoapod-badges.herokuapp.com/p/COSTouchVisualizer/badge.png)](http://cocoadocs.org/docsets/COSTouchVisualizer)

## Swift Usage

Using COSTouchVisualizer is possible with Swift.  Inside your AppDelegate, redefine your window and declare a visualizer window with storyboards.

**With Storyboards**
```swift
class AppDelegate: UIResponder {
  var visWindow: COSTouchVisualizerWindow?
  var window: COSTouchVisualizerWindow? {
    if visWindow == nil { visWindow = COSTouchVisualizerWindow(frame: UIScreen.mainScreen().bounds) }
    return visWindow
  }
...
}
```
**Without Storyboards**

## Objective-C Usage

To run the example project; clone the repo, and run `pod update` from the Example directory first.  By default, this project has `Debug Mode` disabled.  If you want to see the gestures while you're testing, follow the **Debugging Mode** instructions.

**With Storyboards**
 in your `AppDelegate` implementation simply add the following getter

```objective-c
#import <COSTouchVisualizerWindow.h>

...

// Add this method to your AppDelegate method
- (COSTouchVisualizerWindow *)window
{
    static COSTouchVisualizerWindow *visWindow = nil;
    if (!visWindow) visWindow = [[COSTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    return visWindow;
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
[visWindow setFillColor:[UIColor yellowColor]];
[visWindow setStrokeColor:[UIColor purpleColor]];
[visWindow setTouchAlpha:0.4];
// Ripple Color
[visWindow setRippleFillColor:[UIColor yellowColor]];
[visWindow setRippleStrokeColor:[UIColor purpleColor]];
[visWindow setRippleAlpha:0.1];
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
