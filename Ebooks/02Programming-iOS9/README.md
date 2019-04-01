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
* Everything the user sees is a UIView, and what the user sees is a lot more than a bunch of colored rectangles. That's because the views that the user sees have content, they contain drawing.
* You should never call drawRect: yourself! If a view need updating and you want its drawRect: called, send the view the setNeedsDisplay message. This will cause drawRect: to be called at the next proper moment. Also, don't override drawRect: unless you are assured that this is legal(eg, its not legal to override in a subclass of UIImageView, you cannot combine your drawing with that of the UIImageView).
* once a view has drawn itself, the result is cached so that the cached drawing can be reused instead of repeating the drawing operation from scratch. your custom UIView's drawRect: code is called only once in the entire lifetime of the app!
* In fact, moving code to drawRect: is commonly a way to increase efficiency. This is because it is more efficient for the drawing engine to render directly onto the screen than for it to render offscreen and then copy those pixels onto the screen.
* When creating a custom UIView subclass instance in code, you may be surprised(and annoyed) to find that the view has a black background. The black background arises when two things are true: The view's backgroundColor is nil and The view's opaque is true. Unfortunately, When creating a UIView in code, both those things are true by default. With a UIView created in the nib, on the other hand, the black background problem doesn't arise. This is because such a UIView's backgroundColor is not nil. The nib assigns it some actual background color, even if that color is UIColor.clear. If a view fills its rectangle with opaque drawing or has an opaque background color, you can leave opaque set to true and gain some drawing efficiency.

## 03. Layers
* A UIView has a partner called its layer, a CALayer.A UIView does not actually draw itself onto the screen; it draws itself into its layer, and it is the layer that is portrayed on the screen. 
* A view is not redrawn frequently; instead, its drawing is cached, and the cached version of the drawing (the bitmap backing store) is used where possible. The cached version in fact is the layer.
* Layers have properties that affect drawing(Layers have drawing-related properties beyond those of a UIView. Because a layer is the recipient and presenter of a view’s drawing, you can modify how a view is drawn on the screen by accessing the layer’s properties. In other words, by reaching down to the level of its layer, you can make a view do things you can’t do through UIView methods alone). 
* Layers can be combined within a single view(A UIView’s partner layer can contain additional layers. Since the purpose of layers is to draw, portraying visible material on the screen, this allows a UIView’s drawing to be composited of multiple distinct pieces. This can make drawing easier, with the constituents of a drawing being treated as objects).
* Layers are the basis of animation(Animation allows you to add clarity, emphasis, and just plain coolness to your interface. Layers are made to be animated; the “CA” in “CALayer” stands for “Core Animation” ).


