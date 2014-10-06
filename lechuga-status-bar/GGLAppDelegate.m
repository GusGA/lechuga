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

  GGLechuga *lechuga = [[GGLechuga alloc] init];
  self.lechuga = lechuga;

  NSMenuItem *quit = [[NSMenuItem alloc] initWithTitle:@"Salir"
                                                action:@selector(terminate:)
                                         keyEquivalent:@""];

  [self setIconImages];

  [[self statusItem] setMenu:[self statusMenu]];
  [[self statusItem] setHighlightMode:YES];
  [self performSelector:@selector(addItems) withObject:nil afterDelay:2];
  [[self statusMenu] performSelector:@selector(addItem:) withObject:quit afterDelay:2.1];


}

- (IBAction)jsonConsola:(id)sender{
  [self.lechuga updateRates];
  [self performSelector:@selector(updateItems) withObject:nil afterDelay:2.0];
}

- (void) updateItems {
  for (NSMenuItem *item in [self.statusMenu itemArray]) {
    if ([item.title isEqualToString:@"BS/USD"]){
      [self updateItemsPrice:[item.submenu itemArray] WithPrices:self.lechuga.usdData];
    }else if ([item.title isEqualToString:@"BS/EURO"]){
      [self updateItemsPrice:[item.submenu itemArray] WithPrices:self.lechuga.euroData];
    }
  }
}

- (void)setIconImages{
   NSImage *dollarIcon = [NSImage imageNamed:@"dollar"];
   NSImage *dollarIconHighLigth = [NSImage imageNamed:@"dollar_highligth"];
    [dollarIconHighLigth setTemplate:YES];
    [[self statusItem] setImage:dollarIcon];
    [[self statusItem] setAlternateImage:dollarIconHighLigth];
}

- (void)addItems{

  NSMenuItem *bsf_usd = [[NSMenuItem  alloc] init];
  [bsf_usd setEnabled:YES];
  [bsf_usd setTitle:@"BS/USD"];
  [bsf_usd setSubmenu:[self addSubMenuWith:self.lechuga.usdData]];

  NSMenuItem *bsf_euro = [[NSMenuItem  alloc] init];
  [bsf_euro setEnabled:YES];
  [bsf_euro setTitle:@"BS/EURO"];
  [bsf_euro setSubmenu:[self addSubMenuWith:self.lechuga.euroData]];

  [[self statusMenu] addItem:bsf_usd];
  [[self statusMenu] addItem:bsf_euro];

}

-(NSMenu *)addSubMenuWith:(NSDictionary *)dictionary {

  NSMenuItem *efectivo = [[NSMenuItem alloc] init];
  NSMenuItem *transferencia = [[NSMenuItem alloc] init];
  NSMenuItem *sicadDos = [[NSMenuItem alloc] init];

  [efectivo setEnabled:YES];
  [transferencia setEnabled:YES];
  [sicadDos setEnabled:YES];

  NSMenu *returnMenu = [[NSMenu alloc] init];
  [returnMenu addItem:efectivo];
  [returnMenu addItem:transferencia];
  [returnMenu addItem:sicadDos];
  [self updateItemsPrice:[returnMenu itemArray] WithPrices:dictionary];
  return returnMenu;

}


- (void)updateItemsPrice:(NSArray *)inArray WithPrices:(NSDictionary *)prices {
  NSMutableArray *titles = [NSMutableArray arrayWithObjects:
                            [NSMutableString stringWithFormat:@"Efectivo Bs.F. %@",[prices objectForKey:@"efectivo"]],
                            [NSMutableString stringWithFormat:@"Transferencia Bs.F. %@",[prices objectForKey:@"transferencia"]],
                            [NSMutableString stringWithFormat:@"Sicad 2 Bs.F. %@", [prices objectForKey:@"sicad2"]], nil];
  for (int i = 0; i < titles.count; i++) {
    if ([titles[i] rangeOfString:@"(null)"].location != NSNotFound){
      NSString *titulo = [NSString stringWithFormat:@"%@", titles[i]];
      titulo = [titulo stringByReplacingOccurrencesOfString:@"(null)" withString:@"-"];
      titles[i] = titulo;
      titulo = nil;

    }

    [[inArray objectAtIndex:i] performSelector:@selector(setTitle:)
                                    withObject:[NSString stringWithString:titles[i]]];
  }
}



@end
