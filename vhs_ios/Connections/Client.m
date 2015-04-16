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
        
        _sharedInstance = [[Client alloc] initWithBaseURL:[NSURL URLWithString:@"http://jbossasvhsbackendservices-vhstourism.rhcloud.com/VhsBackEndServices/webresources/"]];
        
        _sharedInstance.responseSerializer = [AFHTTPResponseSerializer serializer];

        
    

    });
    
    return _sharedInstance;
}


- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    
    
    if (self) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        [manager.requestSerializer setValue:@"application/json"
                                 forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json"
                                 forHTTPHeaderField:@"Content-Type"];
         
        
    }
    
    return self;
}


@end
