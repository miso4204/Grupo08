//
//  Connections.m
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "Connections.h"
#import "Client.h"
@implementation Connections


-(void)login:(NSDictionary *)params{
    [[Client sharedInstance] POST:@"login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"The response to the login request is: %@", responseObject);
        
        [self.delegate LoginDidFinishSuccessfully:params];
        
        
    }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              NSLog(@"error report %@",error);
                              [self.delegate LoginDidFinishWithFailure:@{  @"operation": operation,
                                                                                     @"error": error}];
                              
                              
                          }];

}

-(void)Register:(NSDictionary *)params{
    [[Client sharedInstance] POST:@"register" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"The response to the Register request is: %@", responseObject);
        
        [self.delegate RegisterDidFinishSuccessfully:params];

        
        
    }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              NSLog(@"error report %@",error);
                              
                              [self.delegate RegisterDidFinishWithFailure:@{  @"operation": operation,
                                                                                     @"error": error}];
                              
                              
                              
                          }];


}



-(void)getCategories:(NSDictionary *)params{



}

-(void)subCategories:(NSDictionary *)params{



}

-(void)getProducts:(NSDictionary *)params{




}

@end
