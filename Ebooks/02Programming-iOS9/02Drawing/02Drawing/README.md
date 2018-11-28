# Drawing

## 01. Image Files
* A pre-existing image file in your app’s bundle can be obtained through the UIImage initializer init(named:). This method looks in two places for the image: Asset catalog(We look in the asset catalog for an image set with the supplied name. The name is case-sensitive) and Top level of app bundle(We look at the top level of the app’s bundle for an image file with the supplied name. The name is case-sensitive and should include the file extension; if it doesn’t include a file extension, .png is assumed).
* When calling init(named:), an asset catalog is searched before the top level of the app’s bundle. If there are multiple asset catalogs, they are all searched, but the search order is indeterminate and cannot be specified, so avoid image sets with the same name.
* init(named:) the image data may be cached in memory, and if you ask for the same image by calling init(named:) again later, the cached data may be supplied immediately.
* you can read an image file from anywhere in your app’s bundle directly and without caching, using init(contentsOfFile:), which expects a pathname string; you can get a reference to your app’s bundle with Bundle.main, and Bundle then provides instance methods for getting the pathname of a file within the bundle, such as path(forResource: <#T##String?#>, ofType: <#T##String?#>).  

## 02. Image Views
* A UIImageView without an image and without a background color is invisible, so you could start with an empty UIImageView in the place where you will later need an image and subsequently assign the image in code. You can assign a new image to substitute one image for another, or set the image view’s image property to nil to remove it. 
* How a UIImageView draws its image depends upon the setting of its contentMode property(UIViewContentMode is inherited from UIView).
* UIImageView's clipsToBounds property if false, its image even if larger than the image view and even if it is not scaled down by the contentMode, may be displayed in its entirety, extending beyond the image view itself.
* When creating a UIImageView in code, you can take advantage of a convenience initialize, init(image:)(or init(image:highlightedImage:)). The default contentMode is .ScaleToFill, but the image is not initially scaled; rather, the view itself is sized to match the image.You will still probably need to position the UIImageView correctly in its superview.
* An image view automatically acquires its alignmentRectInsets from its image's alignmentRectInsets. Thus, if you're going to be aligning the image view to some other object using autolayout, you can attach appropriate alignmentRectInsets to the image that the image view will display, and the image view will do the right thing. To do so, derive a new image by calling the original images's imageWithAlignmentRectInsets:.

## 03. Resizable Images
* To make a resizable image, start with a normal image and call its resizableImage(withCapInsets capInsets: UIEdgeInsets, resizingMode: UIImageResizingMode) method. The capInsets: argument is a UIEdgeInsets, whose components represent distance inward from the edges of the image. In a context larger than the image, a resizable image can behave in one of two ways, depending on the resizingMode:value(UIImageResizingMode):

## 04. Graphics Contexts
* A graphics context is basically a place you can draw. Conversely, you can't draw in code unless you're got a graphics context.
* Create an image context: the function UIGraphicsBeginImageContextWithOptions creates a graphics context suitable for use as an image. You then draw into this context to generate the image. When you're done that, you call UIGraphicsGetImageFromCurrentImageContext to turn the context into a UIImage, and then UIGraphicsEndImageContext to dismiss the context. Now you have a UIImage that you can display in your interface or draw into some other graphics context or save as a file.
* Cocoa hands you a graphics context: you subclass UIView and implement drawRect:. At the time your drawRect: implementation is called, Cocoa has already created a graphics context and is asking you to draw into it, right now; whatever you draw is what the UIView will display. A slight variant of this situation is that you subclass CALayer and implement drawInContext:, or else implement drawLayer:inContext: in the layer's delegate;
* With UIKit, you can draw only into the current context. With Core Graphics(often referred to as Quartz or Quartz2D, is the drawing system that underlies all iOS drawing---UIKit drawing is built on top of it---so it is low-level and consists of C functions), you must specify a graphics context(a CGContext) to draw into, explicitly, in every function call.

## 05. CGImage Drawing
* The Core Graphics version of UIImage is CGImage. a UIImage has a CGImage property that accesses its Quartz image data, and you can make a UIImage from a CGImage using init(CGImage:) or its more configurable sibling init(cgImage:scale:oritation:).
* A CGImage lets you create a new image directly from a rectangular region of the original image, which you can't do with UIImage(you can apply an image mask to a CGImage but UIImage doesn't).

## 06. Snapshots
* An entire view --- anything from a single button to your whole interface, complete with its contained hierarchy of views --- can be drawn into the current graphics context by calling the UIView instance method drawHierarchy(in:afterScreenUpdates:)(This method is much faster than the CALayer method renderInContext:, renderInContext: does still come in handy).The result is a snapshot of the original view: it looks like the original view, but it’s basically just a bitmap image of it, a lightweight visual duplicate.
* An even faster way to obtain a snapshot of a view is to use the UIView(or UIScreen) instance method snapshotViewAfterScreenUpdates:(If the current view is not yet rendered, perhaps because it is not yet onscreen, the snapshot view has no visible content). The result is a UIView, not a UIImage, it's rather like a UIImageView that knows how to draw only one image, namely the snapshot. If you want the stretched snapshot to behave like a resizable image, call resizableSnapshotViewFromRect:afterScreenUpdates:withCapInsets: instead. It is perfectly reasonable to make a snapshot view from a snapshot view. 

## 07. CIFilter and CIImage
* The "CI" in CIFilter and CIImage stands for Core Image, a technology for transforming images through mathematical filters.
* You can create special filters perform highly specialized operations such as face detection and generation of QR codes.
* You specify what filter you want by supplying its string name. to learn what these names are call the CIFilter class method filterNames(inCategories categories: [String]?) with a nil argument or consult Apple's Core Image Filter Reference.
* Each filter has a small number of keys and values that determine its behavior(as if a filter were a kind of dictionary).
* Create the filter with CIFilter's init(name:). Now append the keys and values by calling setValue:forKey: repeatedly, or by calling setValuesForKeysWithDictionary:. Obtain the output CIImage as the filter's outputImage.
* Create the filter and supply the keys and values in a single move, by calling CIFilter's init(name:withInputParameters:). Obtain the output CIImage as the filter's outputImage.
* If a CIFilter requires an input image and you already have a CIImage to fulfill this role, specify the filter and supply the keys and values, and receive the output CIImage as a result, all in a single move, by calling the CIImage instance method imageByApplyingFilter:withInputParameter:.
* As you build a chain of filters, nothing actually happens. The only calculation-intensive move comes at the very end, when you transform the final CIImage in the chain into a bitmap drawing. This is called rendering the image. There are two main ways to do this: With a CIContext(calling init(options:) and then call createCGImage:fromRect:, has advantage of giving you full control over the moment when rendering takes place. But creating a CIContext is expensive, wherever possible, create CIContext once, beforehand--- preferably, once per app and reuse it each time you render) or With a UIImage(create a UIImage directly from the final CIImage by calling init(CIImage:) or init(CIImage:scale:orientation:), at the moment of drawing, the image is rendered).

## 08. Blur and Vibrancy Views
* navigation bars and the control center are translucent and display a blurred rendition of what's behind them. iOS provides the UIVisualEffectView imitate this effect. You can place other views in front of a UIVisualEffectView, but any subviews should be placed inside its contentView.

## 09. Graphics Context Settings
* As you draw in a graphics context, the drawing obeys the context's current settings.
* A graphics context thus has, at every moment, a state, which is the sum total of all its settings; To help manipulate entire state, the graphics context provides a stack for holding states, call saveGState() pushes the entire current state onto the stack; call restoreGState() retrieves the state from the top of the stack and sets itself to that state.
* A common pattern is: call saveGState() -> Manipulate the context’s settings, thus changing its state -> Draw -> call restoreGState() to restore the state and the settings to what they were before you manipulated them.

## 10. Clipping
* Use a path to mask out areas, protecting them from future drawing called clipping. By default, a graphics context's clipping region is the entire graphics context.

## 11. Graphics Context Transforms
* applying a transform to a graphics context has no effect on the drawing that's already in it; it affects only the drawing that takes place after it is applied, altering the way the coordinates you provide are mapped onto the graphics context's area. A graphics context's transform is called its CTM, for "current transform matrix".
* The base transform for a graphics context is already set for you when you obtain the context; this is how the system is able to map context drawing coordinates onto screen coordinates.

## 12. Shadows
* To add a shadow to a drawing, give the context a shadow value before drawing. The shadow position is expressed as a CGSize, where the positive direction for both values indicates down and to the right. The blur value is an open-ended positive number;

## 13. Erasing
* The clear(rect:) of CGContext erases all existing drawing in a rectangle; combined with clipping, it can erase an area of any shape. The result can “punch a hole” through all existing drawing.
* The behavior of clear(rect:) depends on whether the context is transparent or opaque. This is particularly obvious and intuitive when drawing into an image context. If the image context is transparent - the second argument to UIGraphicsBeginImageContextWithOptions is false — clear(rect:) erases to transparent; otherwise it erases to black. 
* When drawing directly into a view (as with draw(rect:) or draw(layer: ctx:)), if the view’s background color is nil or a color with even a tiny bit of transparency(backgroundColor alpha is not 1.0), the result of clear(rect:) will appear to be transparent, punching a hole right through the view including its background color; if the background color is completely opaque, the result of clear(rect:) will be black. This is because the view’s background color determines whether the view’s graphics context is transparent or opaque;

# 14. Points and Pixels
* A point is a dimensionless location described by an x-coordinate and a y-coordinate. When you draw in a graphics context, you specify the points at which to draw, and this works regardless of the device’s resolution, because Core Graphics maps your drawing nicely onto the physical output using the base CTM and anti-aliasing.
* A pixel is a physical, integral, dimensioned unit of display in the real world.

