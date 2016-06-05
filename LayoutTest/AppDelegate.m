//
//  AppDelegate.m
//  LayoutTest
//
//  Created by Andy Lee on 6/4/16.
//  Copyright © 2016 Andy Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "TestWindowController.h"

@interface AppDelegate ()
@property (strong) IBOutlet TestWindowController *windowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	self.windowController = [[TestWindowController alloc] initWithWindowNibName:@"TestWindowController"];
	[self.windowController showWindow:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
}

@end
