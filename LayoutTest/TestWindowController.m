//
//  TestWindowController.m
//  LayoutTest
//
//  Created by Andy Lee on 6/4/16.
//  Copyright © 2016 Andy Lee. All rights reserved.
//

#import "TestWindowController.h"
#import "QuietLog.h"
#import "SimpleView.h"

#define InitialInnerViewFrame NSMakeRect(50, 50, 200, 100)

@interface TestWindowController ()
@property (weak) IBOutlet SimpleView *outerView;
@property (strong) IBOutlet SimpleView *innerView;
@end

@implementation TestWindowController

- (IBAction)repositionInnerView:(id)sender
{
	self.innerView.frame = InitialInnerViewFrame;
}

- (IBAction)logViewConstraints:(id)sender
{
	[self.innerView logConstraints];
	[self.outerView logConstraints];
}

- (IBAction)exerciseInnerViewAmbiguity:(id)sender
{
	if (self.innerView.hasAmbiguousLayout) {
		[self.innerView exerciseAmbiguityInLayout];
	} else {
		NSBeep();
	}
}

- (IBAction)forceLayout:(id)sender
{
	self.outerView.needsLayout = YES;
}

#pragma mark - NSWindowController methods

- (void)windowDidLoad
{
	[super windowDidLoad];

	// Set up innerView.
	//self.innerView = [[SimpleView alloc] initWithFrame:InitialInnerViewFrame];
	NSViewController *vc = [[NSViewController alloc] initWithNibName:@"CellViewController" bundle:nil];
	self.innerView = (SimpleView *)vc.view;
	self.innerView.frame = InitialInnerViewFrame;
	self.innerView.name = @"INNER view";
	self.innerView.borderColor = [NSColor redColor];
	self.innerView.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable);

	// Set up outerView.
	self.outerView.name = @"OUTER view";
	self.outerView.borderColor = [NSColor blueColor];

	// Put innerView inside outerView.
	[self.outerView addSubview:self.innerView];

	// Add a constraint strictly on innerView, and see what happens.
//	[self.innerView addConstraint:[NSLayoutConstraint constraintWithItem:self.innerView
//															   attribute:NSLayoutAttributeWidth
//															   relatedBy:NSLayoutRelationLessThanOrEqual
//																  toItem:nil
//															   attribute:0
//															  multiplier:1
//																constant:300]];

	// Add a constraint that relates innerView to outerView, and see what happens.
//	[self.outerView addConstraint:[NSLayoutConstraint constraintWithItem:self.innerView
//															   attribute:NSLayoutAttributeWidth
//															   relatedBy:NSLayoutRelationGreaterThanOrEqual
//																  toItem:self.outerView
//															   attribute:NSLayoutAttributeWidth
//															  multiplier:.5
//																constant:0]];
}

@end
