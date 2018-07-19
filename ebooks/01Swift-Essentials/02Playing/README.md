# Playing with Swift
macOS High Sierra(10.13.6), XCode9.4.1, swift(4.1.2)。

* playgrounds can mix and match code and documentation, leading to the possibility of providing example code as playgrounds and using playgrounds to learn how to use existing APIs and frameworks。

## 1. How to create a playground
* Window -> Welcome to Xcode -> Get started with a playground。
* File -> New -> Playground。
* Switch platform(View -> Utilities -> Show File Inspector or Command + Options + 1)。

## 2. Displaying in the timeline
* UIKit for iOS and AppKit for macOS。
* You can put image into playground's Resource folder and use it by UIImage.init(named:) or NSImage.init(named:)。
* Clicked on Quick Look icon(the eye symbol, right-hand side of the playground) will show the result。

## 3. PlaygroundSupport
* import playground own framework(PlaygroundSupport)。
* PlaygroundPage liveView must conforms to the PlaygroundLiveViewable protocol(UIView and UIViewController conform to this protocol on iOS and tvOS, and NSView and NSViewController conform to this protocol in macOS. Developers need to implement this protocol only for custom objects that do not inherit from UIView, UIViewController, NSView, or NSViewController)。

## 4. Running asynchronous code 
* PlaygroundPage.current.needsIndefiniteExecution = true。
* PlaygroundPage.current.finishExecution() call at end。

## 5. Using playground live documentation
* https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html
* Playground and Playground Page。

## 6. Limitations of playgrounds
* No debugging support。
* Impossible to add a breakpoint and use the debugger to find out what the values are。
* Only the simulator can be used for the execution of iOS-based playgrounds。
* 	The performance is mainly driven based on how many lines are executed and how much output is saved by the debugger. It should not be used to test the performance of performance-sensitive code。

## 7. Stuck
* You can switch to MacOS platform if code does not use UIKit so that your playground can avoid gets stuck on 'Running'。
* You can Reopen Xcode on iOS platform if stuck on 'Launching simulator' or 'Running playround'。 
* You can switch Automatically Run to Manually Run by long press bottom Triangle button。


