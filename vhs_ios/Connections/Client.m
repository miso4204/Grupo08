//
//  Client.m
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "Client.h"

@implementation Client


+ (id)sharedInstance{
    static Client *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[Client alloc] initWithBaseURL:[NSURL URLWithString:@"http://45.55.169.95:3000/"]];
        
    });
    
    return _sharedInstance;
}


- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    NSLog(@"NEW aaaaa URL %@",url);
    
    
    if (self) {
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        /*
        [self setReachabilityManager:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusNotReachable) {
                NSLog(@"API is NOT Reachable");
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isApiReachable"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                NSLog(@"API is Reachable");
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isApiReachable"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }];
        */
        
        
        
    }
    
    return self;
}


@end
