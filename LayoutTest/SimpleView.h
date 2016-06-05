//
//  SimpleView.h
//  LayoutTest
//
//  Created by Andy Lee on 6/4/16.
//  Copyright © 2016 Andy Lee. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SimpleView : NSView

@property (copy) NSString *name;
@property (copy) NSColor *borderColor;
@property (assign) BOOL usesCustomLayout;

#pragma mark - Debug logging

- (void)logConstraints;

@end
