//
//  GGLechuga.h
//  lechuga-status-bar
//
//  Created by Gustavo Gimenez on 7/25/14.
//  Copyright (c) 2014 Gustavo Gimenez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface GGLechuga : NSObject

@property (nonatomic, strong) NSDictionary *usdData;
@property (nonatomic, strong) NSDictionary *euroData;

- (void) jsonRequest;
- (void) updateRates;
@end
