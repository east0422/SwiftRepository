# Custom View with swift
macOS High Sierra(10.13.6), XCode9.4.1, swift(4.1.2)。

* Views that perform user interactions are generally subclasses of UIControl。
* Both UIView and UIViewController inherit from the UIResponder class, which in turn inherits from NSObject。
* Each view can be given a non-zero integer tag so the view can be get by parent viewWithTag。

## 1. Initialize with xib
* Set the view custom class not File's Owner to CustomView。
* To create a CustomView, the xib file must be loaded by instantiating a UINib with a nibName and a bundle。

	```
	let xib = UINib(nibName:"CustomView", bundle:nil)
	```
* Once the xib is loaded, the view must be created, The instantiateWithOwner method allows the object(s) in the xib to be deserialized。
	```
	let objects = xib.instantiateWithOwner(self, options:nil)
	```
* objects is an array of AnyObject instances, so casting the first element to a UIView is a common step。
	```
	let customView = objects.first as? UIView
	```

## 2. Custom graphical views with drawRect
* The actual drawing commands are performed on a Core Graphics context, which is represented by the CGContext class and can be obtained by UIGraphicsGetCurrentContext。
* The drawRect is not called when the view changes orientation default, set contentMode = UIViewContentMode.redraw(different mode will different behaviors) in init drawRect will called when orientation or bounds size changed。
* Drawing graphics by overriding drawRect is not very performant, because all the drawing routines are executed on the CPU. Offloading the graphics drawing to the GPU is both more performant and more power efficient。

## 3. Creating layered graphics with animation
* Layers are Core Graphics optimized drawing contents. Operations composed on a layer, including adding a path, can be translated into code that can execute on the GPU and be rendered efficiently. In addition, Core Animation can be used to animate changes on layers efficiently。
* Every UIView has an implicit associated layer, which can added sublayers to it. As with views, newly added layers overlay existing layers。
* Graphics that are drawn outside the attribute mask(type of CALayer) are not shown. A mask can only be used by a single layer. If the same mask is needed for more than one layer, either the mask layer needs to be copied or the mask can be set on a common parent layer。

## 4. Testing views in Xcode(interesting)
* @IBDesignable marked class can test the view in interface builder directly(eg @IBDesignable class ProgressView). This gives permission for Xcode to instantiate and run the view as well as update it for any changes that are made. If the class is marked as @IBDesignable, then Xcode will attempt to load the view and display it in storyboard and xib files.
* When the class loads the UI will not be displayed properly, because the frame size needs to be initialized correctly. Override the layoutSubviews method to call setupUI(initialization ui), which ensures that the view is properly redrawn when the view changes size or is shown for the first time.
* Build(not need run) the project, then open the Main.storyboard, and click on the progress view; after a brief delay, it will be drawn。
* @IBInspectable marked attributes allow interface builder to edit them(eg @IBInspectable var progressAmount: CGFloat = 0.5).This allow the view to be tested without running the application。
* After building(also no need run) the project, open the storyboard, select the Progress View, and go to the Attributes Inspector change the value。
* Call setNeedsLayout() after if one attribute changed but no effect, you can also call setNeedsLayout in didSet of the attribute. The property observer uses setNeedsLayout to trigger a call to layoutSubviews in order to achieve the change in display(). Since changes only need to be picked up when a size change occurs or when a property is changed, this is more efficient than implementing other methods such as drawRect, which will be called every time the display needs to be updated。






