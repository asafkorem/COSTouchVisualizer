# TouchVisualizer

[![Version](http://cocoapod-badges.herokuapp.com/v/TouchVisualizer/badge.png)](http://cocoadocs.org/docsets/TouchVisualizer)
[![Platform](http://cocoapod-badges.herokuapp.com/p/TouchVisualizer/badge.png)](http://cocoadocs.org/docsets/TouchVisualizer)

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

## Requirements

## Installation

TouchVisualizer is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "TouchVisualizer"

## Author

Joe Blau, josephblau@gmail.com

## License

TouchVisualizer is available under the MIT license. See the LICENSE file for more info.
