//
//  GGLechuga.m
//  lechuga-status-bar
//
//  Created by Gustavo Gimenez on 7/25/14.
//  Copyright (c) 2014 Gustavo Gimenez. All rights reserved.
//

#import "GGLechuga.h"
#import "AFHTTPRequestOperation.h"

@implementation GGLechuga

#pragma mark - init

- (id) init {
  self = [super init];
    if (self){
      [self jsonRequest];
    }
  return self;
}



- (void) updateRates {
  [self jsonRequest];
}
- (void) jsonRequest {
  NSURL *url = [NSURL URLWithString:@"https://lechuga.herokuapp.com/"];
  AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest  requestWithURL:url]];
  [requestOperation setResponseSerializer:[AFHTTPResponseSerializer serializer]];
  [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSError *err;
    
    self.menuItemsDict =[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&err];
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error){
    NSLog(@"Oops, something went wrong: %@", [error localizedDescription]);
  }];
  [requestOperation start];
}


@end
