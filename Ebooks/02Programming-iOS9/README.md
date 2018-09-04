 # Programming iOS9
macOS High Sierra(10.13.6), XCode9.4.1, swift(4.1.2).
Dive deep into views, view controllers, and frameworks.
The original code is: [https://github.com/mattneub/Programming-iOS-Book-Examples](https://github.com/mattneub/Programming-iOS-Book-Examples)

## 01. Views
* A view is also a responder, UIView is a subclass of UIResponder. 
* A view may come from a nib, or you can create it in code, it depends on your needs and inclinations and on the overall architecture of your app.
* A view can optionally limit the drawing of its subviews so that any parts of them outside the view are not shown. This is called clipping and is set with the view's clipsToBounds property.
* Hiding a view takes it(and its subviews, of course) out of the visible interface, not actually removing it from the view hierarchy. A hidden view does not receive touch events, so to the user it really is as if the view weren't there. But it is there, so it can still be manipulated in code.  

## 02. Drawing


