# Layers

## 01. View and Layer
* A UIView instance has an accompanying CALayer instance, accessible as the view’s layer property. This layer has a special status: it is partnered with this view to embody all of the view’s drawing. 
* The view is the layer’s delegate. And the view’s properties are often merely a convenience for accessing the layer’s properties(eg, when you set the view’s backgroundColor, you are really setting the layer’s backgroundColor, and if you set the layer’s backgroundColor directly, the view’s backgroundColor is set to match. Similarly, the view’s frame is really the layer’s frame and vice versa). 
* The view draws into its layer, and the layer caches that drawing; the layer can then be manipulated, changing the view’s appearance, without necessarily asking the view to redraw itself. 

## 02. Layers and Sublayers 
* Whether a layer displays regions of its sublayers that lie outside that layer’s own bounds depends upon the value of its masksToBounds property. This is parallel to a view’s clips- ToBounds property, and indeed, for a layer that is its view’s underlying layer, they are the same thing.
* Like a UIView, a CALayer has a hidden property that can be set to take it and its sublayers out of the visible interface without actually removing it from its super layer.

## 03. Manipulating the Layer Hierarchy 
* Unlike a view’s subviews property, a layer’s sublayers property is writable; you can give a layer multiple sublayers in a single move, by assigning to its sublayers property. To remove all of a layer’s sublayers, set its sublayers property to nil.
* a layer also has a zPosition property, a CGFloat, and this also determines drawing order. 
* The rule is that all sublayers with the same zPosition are drawn in the order they are listed among their sublayers siblings, but lower zPosition siblings are drawn before higher zPosition siblings. The default zPosition is 0.0.
* Sometime, the zPosition property is a more convenient way of dictating drawing order than sibling order is. For example, if layers represent playing cards laid out in a solitaire game, it will likely be a lot easier and more flexible to determine how the cards overlap by setting their zPosition than by rearranging their sibling order. Moreover, a subview’s layer is itself just a layer, so you can rearrange the drawing order of subviews by setting the zPosition of their underlying layers. 

## 04. Positioning a Sublayer
* Layer coordinate systems and positioning are similar to those of views. A layer’s own internal coordinate system is expressed by itsbounds, just like a view; its size is its bounds size, and its bounds origin is the internal coordinate at its top left. 
* a sublayer’s position within its superlayer is not described by its center, like a view; a layer does not have a center. Instead, a sublayer’s position within its superlayer is defined by a combination of two properties position(A point expressed in the superlayer’s coordinate system) and anchorPoint(the position point is located. It is a CGPoint describing a fraction (or multiple) of the layer’s own bounds width and bounds height (0.0, 0.0) is the top left of the layer's bounds, and (1.0, 1.0) is the bottom right of the layer's bounds, default is (0.0, 0.0)).
* A layer's position and anchorPoint are independent. changing one does not change the other within its superlayer. 

## 05. Drawing in a Layer
* The simplest way to make something appear in a layer is through its contents property. It is expected to be a CGImage(nil signifying no image) not UIImage(the image doesn’t appear, but there is no error either).
* Similar to a UIView’s drawRect: method redraw itself layer redisplays itself is very conservative about calling these methods(and you must not call any of them directly).
* 	If the layer’s needsDisplayOnBoundsChange property is false(the default), then the only way to cause the layer to redisplay itself is by calling setNeedsDisplay(or setNeedsDisplayInRect:). Even this might not cause the layer to redisplay itself right away; if that’s crucial, then you will also call displayIfNeeded.
* If the layer’s needsDisplayOnBoundsChange property is true, then the layer will also redisplay itself when the layer’s bounds change (like view’s ContentMode).
* 	Here are the four methods that can be called when a layer redisplays itself; pick one to implement (don’t try to combine them, you’ll just confuse things): **display in a subclass**(Your CALayer subclass can override display. There’s no graphics context at this point, so display is pretty much limited to setting the contents image), **displayLayer: in the delegate**(You can set the CALayer’s delegate property and implement displayLayer: in the delegate. As with display, there’s no graphics context, so you’ll just be setting the contents image), **drawInContext: in a subclass**(Your CALayer subclass can override drawInContext:. The parameter is a graphics context into which you can draw directly; it is not automatically made the current context), **drawLayer:inContext: in the delegate**(	You can set the CALayer’s delegate property and implement drawLayer:inContext:. The second parameter is a graphics context into which you can draw directly; it is not automatically made the current context).
* Assigning a layer a contents image and drawing directly into the layer are, in effect, mutually exclusive.
* If a layer’s contents is assigned an image, this image is shown immediately and replaces whatever drawing may have been displayed in the layer.
* If a layer redisplays itself and drawInContext: or drawLayer:inContext: draws into the layer, the drawing replaces whatever image may have been displayed in the layer.
* If a layer redisplays itself and none of the four methods provides any content, the layer will be empty.
* If a layer is a view’s underlying layer, you usually won’t use any of the four methods to draw into the layer: you’ll use the view’s drawRect:.
* If you really want to. In that case, you will probably want to implement drawRect: anyway, leaving that implementation empty. The reason is that this causes the layer to redisplay itself at appropriate moments. When a view is sent setNeedsDisplay including when the view first appears the view’s underlying layer is also sent setNeedsDisplay, unless the view has no drawRect: implementation (because in that case, it is assumed that the view never needs redrawing). So, if you’re drawing a view entirely by drawing to its underlying layer directly, and if you want the underlying layer to be redisplayed automatically when the view is told to redraw itself, you should implement drawRect: to do nothing(This technique has no effect on sublayers of the underlying layer). Thus, these are legitimate (but unusual) techniques for drawing into a view: first is that the view subclass implements an empty drawRect:, along with either displayLayer: or drawLayer:inContext: and second is that the view subclass implements an empty drawRect: plus layerClass, to give the view a custom layer subclass and the custom layer subclass implements either display or drawInContext:.
* you must not set the delegate property of a view’s underlying layer! The view is its delegate and must remain its delegate. A useful architecture for drawing into a layer through a delegate of your choosing is to treat a view as a layer-hosting view: the view and its underlying layer do nothing except to serve as a host to a sublayer of the view’s underlying layer.

## 06. Content Resizing and Positioning
* A layer’s content is stored(cached) as a bitmap which is then treated like an image and drawn in relation to the layer’s bounds in accordance with various layer properties.
* If the content came from setting the layer’s contents property to an image, the cached content is that image; its size is the point size of the CGImage.
* If the content came from drawing directly into the layer’s graphics context(drawInContext:, drawLayer:inContext:), the cached content is the layer’s entire graphics context; its size is the point size of the layer itself at the time the drawing was performed.

## 07. Layers that Draw Themselves
* A few built-in CALayer subclasses provide some basic but extremely helpful self-drawing ability: CATextLayer, CAShapeLayer and CAGradientLayer.

## 08. Transforms
* The way a layer is drawn on the screen can be modified though a transform. Because a view can have a transform, and a view is drawn on the screen by its layer. But a layer’s transform is more powerful than a view’s transform; you can use it to accomplish things that you can’t accomplish with a view’s transform alone.

## 09. Shadows, Borders, and Masks
* A CALayer can have a shadow, defined by its shadowColor, shadowOpacity, shadow- Radius, and shadowOffset properties. To make the layer draw a shadow, set the shadowOpacity to a nonzero value. The shadow is normally based on the shape of the layer’s nontransparent region, but deriving this shape can be calculation-intensive(so much so that in early versions of iOS, layer shadows weren’t implemented). You can vastly improve performance by defining the shape yourself and assigning this shape as a CGPath to the shadowPath property.
* If a layer’s masksToBounds is true, no part of its shadow lying outside its bounds is drawn.(This includes the underlying layer of a view whose clipsToBounds is true) Wondering why the shadow isn’t appearing for a layer that masks to its bounds is a common beginner quandary. 
* A CALayer can have a border (borderWidth, borderColor); the borderWidth is drawn inward from the bounds, potentially covering some of the content unless you compensate. A CALayer can be bounded by a rounded rectangle, by giving it a cornerRadius greater than zero. If the layer has a border, the border has rounded corners too. If the layer has a backgroundColor, that background is clipped to the shape of the rounded rectangle.
* If the layer’s masksToBounds is true, the layer’s content and its sublayers are clipped by the rounded corners.

## 10. Layer Efficiency
* In general, opaque drawing is most efficient.
* Another way to gain some efficiency is by 'freezing' the entirety of the layer’s drawing as a bitmap. In effect, you’re drawing everything in the layer to a secondary cache and using the cache to draw to the screen. Copying from a cache is less efficient than drawing directly to the screen, but this inefficiency may be compensated for, if there’s a deep or complex layer tree, by not having to composite that tree every time we render.
* there’s a layer property drawsAsynchronously. The default is false. If set to true, the layer’s graphics context accumulates drawing commands and obeys them later on a background thread. Thus, your drawing commands run very quickly, because they are not in fact being obeyed at the time you issue them. I haven’t had occasion to use this, but presumably there could be situations where it keeps your app responsive when drawing would otherwise be time-consuming. 

## 11. Layers and Key–Value Coding
* All of a layer’s properties are accessible through key–value coding by way of keys with the same name as the property.
* You can treat a CALayer as a kind of dictionary, and get and set the value for any key. This means you can attach arbitrary information to an individual layer instance and retrieve it later.
* CALayer has a defaultValueForKey: class method; to implement it, you’ll need to subclass and override. In the case of keys whose value you want to provide a default for, return that value; otherwise, return the value that comes from calling super. Thus, even if a value for a particular key has never been explicitly provided, it can have a non nil value.

 
 
 
 
  

 







