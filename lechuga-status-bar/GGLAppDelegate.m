//
//  GGLAppDelegate.m
//  lechuga-status-bar
//
//  Created by Gustavo Gimenez on 7/25/14.
//  Copyright (c) 2014 Gustavo Gimenez. All rights reserved.
//

#import "GGLAppDelegate.h"
#import "GGLechuga.h"

@interface GGLAppDelegate ()

@property (nonatomic, strong)GGLechuga *lechuga;

@end

@implementation GGLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  
  self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength ];
  
  NSImage *dollarIcon = [NSImage imageNamed:@"dollar"];
  NSImage *dollarIconHighLigth = [NSImage imageNamed:@"dollar_highligth"];
  [dollarIconHighLigth setTemplate:YES];
  
  [[self statusItem] setImage:dollarIcon];
  [[self statusItem] setAlternateImage:dollarIconHighLigth];
  [[self statusItem] setMenu:[self statusMenu]];
  [[self statusItem] setHighlightMode:YES];
  GGLechuga *lechuga = [[GGLechuga alloc] init];
  self.lechuga = lechuga;
  NSMenuItem *bsf_usd = [[NSMenuItem  alloc] init];
  NSMenuItem *bsf_euro = [[NSMenuItem  alloc] init];
  [bsf_usd setEnabled:YES];
  [bsf_usd isEnabled];
  [bsf_usd setTitle:@"BS/USD -> -"];
  [bsf_euro setEnabled:YES];
  [bsf_euro isEnabled];
  [bsf_euro setTitle:@"BS/EURO -> -"];
  [[self statusMenu] addItem:bsf_usd];
  [[self statusMenu] addItem:bsf_euro];
  
  
}

- (IBAction)jsonConsola:(id)sender{
  [self.lechuga updateRates];
  [self performSelector:@selector(setItemValues:) withObject:self.lechuga afterDelay:1.0];
}

- (void) setItemValues:(GGLechuga *)lechuga{

  NSString *price = [NSString stringWithFormat:@"BS/USD -> %@",[[[lechuga.menuItemsDict objectForKey:@"USD"] objectForKey:@"transferencia"] stringValue]];
  NSString *euro_price = [NSString stringWithFormat:@"BS/EURO -> %@",[[[lechuga.menuItemsDict objectForKey:@"EUR"] objectForKey:@"transferencia"] stringValue]];
  for (NSMenuItem *item in [self.statusMenu itemArray]) {
    if ([item.title rangeOfString:@"USD"].location != NSNotFound){
      if ([price isEqualToString:@"BS/USD -> (null)"]){
        item.title = @"BS/USD -> N/A";
      } else{
          item.title = price;
      }
    } else if ([item.title rangeOfString:@"EURO"].location != NSNotFound){
      if ([euro_price isEqualToString:@"BS/EURO -> (null)"]){
        item.title = @"BS/EURO -> N/A";
      } else{
        item.title = euro_price;
      }
    }
  }
  
}
@end
