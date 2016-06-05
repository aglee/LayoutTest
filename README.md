# LayoutTest

In a pure Auto Layout world, it doesn't make sense to call setFrame:.  But any custom layout not expressible with Auto Layout must allow me to call setFrame: somewhere.  The question is, where?  This app was an exercise to help me figure that out.

The app displays an "outerView" with a blue border and an "innerView" with a red border.  You can toggle a couple of the views' layout-related properties, resize the window, and see what happens.  Assorted information gets logged, both automatically and on demand via the "Log" button.

From the docs, you might think overriding [layout][layout] is the way to go:

> Override this method if your custom view needs to perform custom layout not expressible using the constraint-based layout system.

But I tried putting my setFrame: calls in there, and not only didn't I get the layout I wanted, I got this message in the log at runtime:

> 2016-06-05 15:11:45.711 LayoutTest[91526:1314119] Layout still needs update after calling -[SimpleView layout].  SimpleView or one of its superclasses may have overridden -layout without calling super. Or, something may have dirtied layout in the middle of updating it.  Both are programming errors in Cocoa Autolayout.  The former is pretty likely to arise if some pre-Cocoa Autolayout class had a method called layout, but it should be fixed.

What worked was to override [resizeSubviewsWithOldSize:][resize], which the docs say you can override to "to define a specific retiling behavior".

Note that

> The default implementation sends resizeWithOldSuperviewSize: to the view's subviews [...].

So in your resizeWithOldSuperviewSize: method, make sure to *end* by calling super so that your subviews can lay out *their* subviews within their newly assigned frames.

Some observations:

- layout calls resizeSubviewsWithOldSize:, as evidenced by the nesting of NSLog messages.
- If a view has no subviews, then it is not sent the layout message, and therefore no resizeSubviewsWithOldSize: message either.  (You can't tell this from the current incarnation of this app.  I discovered it back when innerView didn't have any subviews.)
- If a view's autoresizesSubviews is false, then it is not sent the layout message, and therefore no resizeSubviewsWithOldSize: message either.

Recommended reading: "[Advanced Auto Layout Toolbox][advanced]".



[resize]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/#//apple_ref/occ/instm/NSView/resizeSubviewsWithOldSize:

[layout]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/#//apple_ref/occ/instm/NSView/layout

[advanced]: https://www.objc.io/issues/3-views/advanced-auto-layout-toolbox/

