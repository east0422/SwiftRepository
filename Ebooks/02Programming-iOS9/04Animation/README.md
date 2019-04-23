# Animation

## 01. Drawing, Animation, and Threading
* When change a visible view property, that change does not visibly take place there and then. Rather, the system records that this is a change you would like to make, and marks the view as needing to be redrawn. Later, when all your code has run to completion and the system has, as it were, a free moment, then it redraws all views that need redrawing, applying their new visible property features. Let’s call this the redraw moment. 
* When you ask for an animation to be performed, the animation doesn’t start happening on the screen until the next redraw moment(you can force an animation to start immediately, but this is unusual).

## 02. Image View and Image Animation
* You supply the UIImageView with an array of UIImages, as the value of its animationImages or highlightedAnimationImages property. This array represents the “frames” of a simple cartoon; when you send the startAnimating message, the images are displayed in turn, at a frame rate determined by the animationDuration property, repeating as many times as specified by the animationRepeatCount property (the default is 0, meaning to repeat forever), or until the stopAnimating message is received. Before and after the animation, the image view continues displaying its image(or highlightedImage).
* Can create an animated image with one of these UIImage class methods animatedImageWithImages:duration:, animatedImageNamed:duration:, animatedResizableImageNamed:capInsets:resizingMode:duration:.
* An animated image can appear in the interface anywhere a UIImage can appear as a property of some interface object.

## 03. View Animation
* you can animate a UIView directly: these are its alpha, bounds, center, frame, transform, and(if the view doesn’t implement drawRect:) backgroundColor. You can also animate a UIView’s change of contents. This list of animatable features, despite its brevity, will often prove quite sufficient.
* Whatever happens in the performWithoutAnimation: block is not animated use inside UIView class method animate(withDuration:animations:).

## 04. Canceling a View Animation
* reach down to the CALayer level and call removeAllAnimations it simply stops the animation dead：the “animation movie” is whipped away instantly, “jumping” the view to its final position(self.view.layer.removeAllAnimations()).
 
 
 
  

 







