# Views

## 1. Window
* the top of the view hierarchy is the app's window. It is an instance of UIWindow, also a subclass of UIView.
* app should have exactly one main window. It is created at launch time and is never destroyed or replaced(app delegate class has a window property with a strong retain policy). It forms the background to and is the ultimate superview of all your other visible views.
* the app's window must initially fill the device's screen, this is ensured by setting the window's frame to the screen's bounds as the window is instantiated.
* if your app can display views on an external screen, you will create an additional UIWindow to contain those views.
* New in iOS 9, it ’s sufficient to instantiate UIWindow with no frame; the screen’s bounds will be assigned to the window’s frame for you: let w = UIWindow().

## 2. Subview and Superview
* The view hierarchy is the chief mode of view organization. A view can have subviews, but a subview has exactly on immediate superview. If a view is removed(/hidden/moved/..) from the interface, its subviews are removed(/hidden/moved/..).
* Superview owns its subviews, in the memory-management sense, much as an array owns its elements; it retains them and is responsible for releasing a subview when that subview ceases to be its subview(it is removed from the collection of this view's subviews) or when it itself goes out of existence.
* If a view's size is changed, its subviews can be resized automatically.
* subviews is an array of UIView objects, in back-to-front order. subviews are indexed, starting at 0 which is rearmost. 

## 3. Visibility and Opacity
* Setting opaque to true make view draw more efficiently, default is true. The opaque value is not changed for you when you set a view's backgroundColor or alpha. 
* A view's degree of transparency is inherited by its subviews.
* Alpha 0 to 1.0, 0 means transparent, 1.0 means opaque, alpha value affects both background color and its contents. subviews alpha value will be drawn relative to superview alpha value(eg superview alpha is 0.5, subview is 0.8, actually is 0.5 * 0.8 = 0.4). A view that is completely transparent(or very close to it) is like a view whose hidden is true: it is invisible, along with its subviews, and cannot(normally) be touched.

## 4. Frame Bounds and Center
* A view with a zero-size frame is effectively invisible, the default frame might be CGRectZero.
* Change a view's bounds size will change its frame size, changing a view’s frame size also affects its bounds size, but both its center remains unchanged.
* The proper and most reliable way to position and size a view within its superview is to use its bounds and center, not its frame, there are some situations in which the frame is meaningless (or will at least behave very oddly), but the bounds and center will always work.
* every view has its own coordinate system expressed by its bounds, and that a view's coordinate system has a clear relationship to its superview's coordinate system expressed by its center.
* it is possible to convert between the coordinates of any two views in the same window, eg v2 is a subview of v1 so v2.center = v1.convert(v1.center, from: v1.superview).
* View.bounds.midX = View.bounds.origin.x + View.bounds.size.width/2, View.bounds.midY = View.bounds.origin.y + View.bounds.size.height/2, View.frame.midX = View.center.x = View.frame.origin.x + View.frame.size.width/2, View.frame.midY = View.center.y = View.frame.origin.y + View.frame.size.height/2.

## 5. Transform
* A view's transform property alters how the view is drawn, without affecting its bounds and center.
* Transform a view the frame(describes the minimal bounding rectangle surrounding the view’s apparent position) may useless.
* If a view's transform is not the identity transform, you should not set its frame(is useless).

## 6. Layout
* layout is that subviews to be resized and repositioned when their superview's bounds size is changed.
* layout is performed in three primary ways: Manual layout、Autoresizing、Autolayout.
* manual layout is rare. Autoresizing is used automatically unless you deliberately turn it off by setting a superview's autoresizesSubviews property to false, or unless a view uses autolayout instead. Autolayout is an opt-in technology, and can be used for whatever areas of your interface you find appropriate; a view that uses autolayout can live side by side with a view that uses autoresizing.
* one chief places opt in to autolayout is the nib file, and Xcode7 all new .storyboard and .xib files do opt in(they have autolayout turned on by default). On the other hand, a view that your code creates and adds to the interface, by default, uses autoresizing not autolayout.
* You can't turn off autolayout for just part of a nib. Either all views instantiated from a nib use autolayout or they all use autoresizing. To generate different parts of your interface from nibs, one part with autoresizing, another part with autolayout, separate those parts into different nibs(different .storyboard or .xib files) and then load and combine them at runtime.

## 7. Manual layout
* superview is sent the layoutSubviews message whenever it is resized, so to layout subviews manually, provide your own subclass and override layoutSubviews. This could a lot of work, but you can do anything you like.

## 8. Autoresizing
* is the pre-iOS 6 way of performing layout automatically. When its superview is resized, a subview will respond in accordance with the rules prescribed by its own autoresizingMask property value.
* Autoresizing is a matter of conceptually assigning a subview 'spring and struts', a spring can stretch, a strut can't.
* In code, a combination of springs and struts is set through a view's autoresizingMask property. 
* UIViewAutoresizing struct represent springs, whatever isn't specified is a strut.
* Autoresizing happens before layoutSubviews(manual layout) is called.
* If translatesAutoresizingMaskIntoConstraints property set to true it translates the view's frame and autoresizingMask setting into implicit constraints affecting this view(though they may be attached to a different view) when runtime. By default, the property is set to true for any view you programmatically create. If you add views in Interface Builder, the system automatically sets this property to false. If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false, and then provide a non ambiguous, nonconflicting set of constraints for the view.
* To configure autoresizing in the nib editor, you’ll need to ensure that autolayout is turned off for the .storyboard or .xib file you’re editing.

## 9.Autolayout
* introduced in iOS6, depends on the constraints of views. A constraint(an instance of NSLayoutConstraint) is a full-fledged(FF) object with numeric values describing some aspect of the size or position of a view, often in terms of some other view. it is much more sophisticated, descriptive, and powerful than the autoresizingMask. Multiple constraints can apply to an individual view, and they can describe a relationship between any two views(not just a subview and its superview). Autolayout is implemented behind the scenes in layoutSubviews; in effect, constraints allow you to write sophisticated layoutSubviews functionality without code.
* Your code adds an autolayout constraint to a view. The views involved in this constraint use autolayout.
* Your app loads a nib for which "Use AutoLayout" is checked. Every view instantiated from that nib uses autolayout.
* A view in the interface, which would be an instance of a custom UIView subclass of yours, return true from the class method requiresConstraintBasedLayout. That view uses autolayout.
* One sibling view can use autolayout while another sibling view does not, and a superview can use autolayout while some or all of its subviews do not. However, autolayout is implemented through the superview chain, so if a view uses autolayout, then automatically so do all its superviews;

## 10. Guides and margins
	``` 
	When the app is in landscape orientation, with the status bar removed by default, this view will be right up against the top of the screen, which is fine. But in portrait orien‐ tation, this view will still be right up against the top of the screen — which looks bad because the status bar reappears and overlaps it. 
	NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v]", options: [], metrics: nil, views: ["tlg":self.topLayoutGuide, "v":v])
	// solve the problem 
	NSLayoutConstraint.constraints(withVisualFormat: "V:[tlg]-0-[v]", options: [], metrics: nil, views: ["tlg":self.topLayoutGuide, "v":v])
	```
* UIViewController supplies and maintains two invisible views, the top layout guide and the bottom layout guide, which it injects as subviews into the view hierarchy of its main view.Your topmost and bottommost vertical constraints will usually not be between a subview and the top or bottom of the main view, but between a subview and the bottom of the top layout guide, or a subview and the top of the bottom layout guide. The bottom of the top layout guide matches the bottom of the lowest top bar, or the top of the main view if there is no top bar; the top of the bottom layout guide matches the top of the bottom bar, or the bottom of the main view if there is no bottom bar. Most important, these layout guides change their size as the situation changes — the top or bottom bar changes its height, or vanishes entirely — and so your views constrained to them move to track the edges of the main view’s visible area.
* The default for a view controller’s main view is a top and bottom margin of 0 and a right and left margin of 16; for any other view, it’s 8 for all four margins.

## 11. Stack views
* A stack view (UIStackView), new in iOS 9, is a view whose primary task is to generate constraints for some or all of its subviews.
* Configuration of a stack view is extremely simple and yet remarkably powerful. First, you supply it with arranged subviews, usually by calling its initializer init(arranged- Subviews:). The arranged subviews become the stack view’s arrangedSubviews read- only property.
* The order of the arrangedSubviews is independent of the order of the subviews; the subviews order, you remember, determines the order in which the subviews are drawn, but the arrangedSubviews order determines how the stack view will position those subviews.
* note that although you will not have to constrain the arranged views — it is exactly the job of the stack view to do that — you will have to constrain the stack view itself (though of course this, too, might be done automatically because the stack view is an arranged view of a containing stack view).

## 12. Internationalization
* New in iOS 9, the entire interface and its behavior are reversed when the app runs on a system for which the app is localized and whose language is right-to-left. Wherever you use leading and trailing constraints instead of left and right constraints, or if your constraints are constructed using the visual format language, your app’s layout will participate in this reversal more or less automatically.
* a UIView is endowed with a semanticContentAttribute property stating whether it should be flipped; the default is .Unspecified, but a value of .Playback or .Spatial will prevent flipping.
* If you are constructing a view’s subviews in code in real time, you can feed a subview’s semanticContentAttribute value to the UIView class method userInterfaceLayoutDirection(for attribute: UISemanticContentAttribute) to find out whether directionality is .LeftToRight or .RightToLeft.

## 13. Mistakes with constraints 
* Suspecting ambiguity constraints a useful trick is to pause in the debugger and give the following mystical command in the console:`(lldb) expr -l objc++ -O -- [[UIWindow keyWindow] _autolayoutTrace]` The result is a graphical tree describing the view hierarchy and marking any ambigu‐ ously laid out views. You can try 
 	`expr NSLayoutConstraint.reportAmbiguity(nil)` and 	`expr NSLayoutConstraint.listConstraints(nil)`.
* Xcode’s view debugging feature can also be a great help, With the app running, choose Debug → View Debugging → Capture View Hierarchy.

## 14. Designable views and inspectable properties
	```
	@IBDesignable class MyView: UIView {
	// ... your code goes here ...
	} 
	```
* If an instance of declared @IBDesignable UIView subclass appears in the nib, then its self-configuration methods, such as init(coder:) and willMoveToSuperview:, will be compiled and run as the nib editor prepares to portray your view. so you can adjust layout in nib editor.
* your view can implement prepareForInterfaceBuilder to perform visual configurations aimed specifically at how it will be portrayed in the nib editor(eg, your view contains a UILabel that is created and configured empty but will eventually contain text, you could implement prepareForInterfaceBuilder to give the label some sample text to be displayed in the nib editor).
* You can also configure custom view properties directly in the nib editor if this property is declared @IBInspectable. Inspectable property types are: Bool, number, String, CGRect, CGPoint, CGSize, UIColor, or UIImage — or an Optional wrapping any of these.

## 15. View Events Related to Layout 
* These are events that you can receive and respond to by overriding them in your UIView subclass. You might want to do this in situations where layout is complex(eg, when you need to supplement autoresizing or autolayout with manual layout in code, or when your autoresizing or autolayout configuration itself needs to change in response to changing conditions).
* At launch time, and if the environment’s trait collection changes thereafter, the traitCollectionDidChange: message is propagated down the hierarchy of UITraitEnvironments.
* If your interface involves autolayout and constraints, then updateConstraints is propagated up the hierarchy, starting at the deepest subview. This event may be omitted for a view if its constraints have not changed, but it will certainly be called for the view at the top of the hierarchy.You should never call updateConstraints directly. To trigger an immediate call to updateConstraints, send a view the updateConstraintsIfNeeded message. But updateConstraints may still not be sent unless constraints have changed or the view is at the top of the hierarchy. To force updateConstraints to be sent to a view, send it the setNeedsUpdateConstraints message. 
* Layout can be triggered even if the trait collection didn’t change; for example, perhaps a constraint was changed, or the text of a label was changed, or a superview’s size changed. The layoutSubviews message is propagated down the hierarchy, starting at the top (typically the root view) and working down to the deepest subview.
* layoutSubviews is your opportunity to perform manual layout after autoresizing has taken place. If you are using autolayout, you must call super or the app will crash (with a helpful error message).to trigger an immediate call to layout- Subviews, send a view the layoutIfNeeded message (which may cause layout of the entire view tree, not only below but also above this view), or send setNeedsLayout to trigger a call to layoutSubviews later on, after your code finishes running, when layout would normally take place. 
* Unless you explicitly demand immediate layout, layout isn’t performed until your code finishes running (and then only if needed). Moreover, ambiguous layout isn’t ambiguous until layout actually takes place. Thus, for example, it’s perfectly reasonable to cause an ambiguous layout temporarily, provided you resolve the ambiguity before layoutSubviews is called. On the other hand, a conflicting constraint conflicts the instant it is added.

	











