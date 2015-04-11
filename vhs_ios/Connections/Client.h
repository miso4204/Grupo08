//
//  Client.h
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

@interface Client :AFHTTPSessionManager


+ (id)sharedInstance;
- (instancetype)initWithBaseURL:(NSURL *)url;

@end
