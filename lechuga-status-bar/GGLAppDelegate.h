//
//  GGLAppDelegate.h
//  lechuga-status-bar
//
//  Created by Gustavo Gimenez on 7/25/14.
//  Copyright (c) 2014 Gustavo Gimenez. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GGLAppDelegate : NSObject <NSApplicationDelegate>

@property (readwrite, retain) IBOutlet NSMenu *statusMenu;
@property (readwrite, retain) NSStatusItem *statusItem;


- (IBAction)jsonConsola:(id)sender;
@end
