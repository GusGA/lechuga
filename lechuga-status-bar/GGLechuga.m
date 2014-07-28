//
//  GGLechuga.m
//  lechuga-status-bar
//
//  Created by Gustavo Gimenez on 7/25/14.
//  Copyright (c) 2014 Gustavo Gimenez. All rights reserved.
//

#import "GGLechuga.h"
#import "AFHTTPRequestOperation.h"

@interface GGLechuga ()

@property (nonatomic, strong) NSMutableDictionary *fullData;

@end

@implementation GGLechuga

#pragma mark - init

- (id) init {
  self = [super init];
  if (self){
    [self updateRates];
  }
  return self;
}



- (void) updateRates {
  [self jsonRequest];
  [self performSelector:@selector(setCurrenciesDictionaries) withObject:nil afterDelay:2.0];
}
- (void) jsonRequest {
  NSURL *url = [NSURL URLWithString:@"https://lechuga.herokuapp.com/"];
  AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest
                                                                             requestWithURL:url]];

  [requestOperation setResponseSerializer:[AFHTTPResponseSerializer serializer]];

  [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSError *err;
    self.fullData = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&err]];

  } failure:^(AFHTTPRequestOperation *operation, NSError *error){
    NSLog(@"Oops, something went wrong: %@", [error localizedDescription]);
  }];

  [requestOperation start];
}


- (void)setCurrenciesDictionaries {

  self.usdData = [NSDictionary dictionaryWithDictionary:[self.fullData objectForKey:@"USD"]];
  self.euroData = [NSDictionary dictionaryWithDictionary:[self.fullData objectForKey:@"EUR"]];
}

@end
