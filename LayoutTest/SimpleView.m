//
//  SimpleView.m
//  LayoutTest
//
//  Created by Andy Lee on 6/4/16.
//  Copyright © 2016 Andy Lee. All rights reserved.
//

#import "SimpleView.h"
#import "QuietLog.h"

@implementation SimpleView

#pragma mark - Debug logging

- (void)logConstraints
{
	QuietLog(@"+++ %@ %@ -- layout is %@", self, NSStringFromRect(self.frame), (self.hasAmbiguousLayout ? @"**AMBIGUOUS**" : @"unambiguous"));
	QuietLog(@"+++ %@ -- constraints: %@", self, self.constraints);
}

#pragma mark - NSView methods

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];

	[self.borderColor set];
	NSFrameRectWithWidth(self.bounds, 4);
}

// See README.md for notes about overriding -resizeSubviewsWithOldSize: rather than -layout.
- (void)layout
{
	static NSUInteger s_count = 0;
	QuietLog(@"+++ ENTERING %s %@ #%zd", __PRETTY_FUNCTION__, self.name, s_count++);

	[super layout];
	[self _maybeDoCustomLayoutOfSubviews];
	self.needsLayout = YES;

	QuietLog(@"+++ EXITING %s %@ #%zd", __PRETTY_FUNCTION__, self.name, s_count++);
}

// See README.md for notes about overriding -resizeSubviewsWithOldSize: rather than -layout.
- (void)resizeSubviewsWithOldSize:(NSSize)oldSize
{
	static NSUInteger s_count = 0;
	QuietLog(@"+++ ENTERING %s %@ #%zd", __PRETTY_FUNCTION__, self.name, s_count++);

	[self _maybeDoCustomLayoutOfSubviews];
	[super resizeSubviewsWithOldSize:oldSize];

	QuietLog(@"+++ EXITING %s %@ #%zd", __PRETTY_FUNCTION__, self.name, s_count++);
}

#pragma mark - NSObject methods

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p '%@'>", self.className, self, self.name];
}

#pragma mark - Private methods

// Only does the custom layout if usesCustomLayout is true.
- (void)_maybeDoCustomLayoutOfSubviews
{
	QuietLog(@"+++ Custom layout? %@", (self.usesCustomLayout ? @"YES" : @"NO"));

	if (!self.usesCustomLayout) {
		return;
	}

	// As of this writing the app using this class only creates two instances,
	// one inside the other, so looping through subviews isn't really necessary.
	// I'm looping anyway in case I add more subviews later.
	NSRect newFrameForSubview = NSMakeRect(NSMidX(self.bounds) - 100, NSMidY(self.bounds) - 100, 200, 200);
	for (NSView *subview in self.subviews) {
		QuietLog(@"+++ Changing subview frame from %@ to %@",
				 NSStringFromRect(subview.frame),
				 NSStringFromRect(newFrameForSubview));
		subview.frame = newFrameForSubview;
		newFrameForSubview = NSOffsetRect(newFrameForSubview, 10, 10);
	}
}

@end
