//
//  Connections.h
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Client.h"

@class Connections;


// methods from other views
@protocol ConnectionsDelegate <NSObject>

@optional
-(void)LoginDidFinishSuccessfully:(NSDictionary*)responseObject; //  LoginViewController
-(void)LoginDidFinishWithFailure:(NSDictionary*)responseObject; //  LoginViewController

-(void)RegisterDidFinishSuccessfully:(NSDictionary*)responseObject; //  LoginViewController
-(void)RegisterDidFinishWithFailure:(NSDictionary*)responseObject; //  LoginViewController


@end



@interface Connections : NSObject<NSURLConnectionDataDelegate>{
    
    int responseStatusCode;
    
}
@property (nonatomic, strong) IBOutlet id<ConnectionsDelegate> delegate;

-(void)login:(NSDictionary *)params ;

-(void)Register:(NSDictionary *)params;

-(void)getCategories:(NSDictionary *)params;

-(void)subCategories:(NSDictionary *)params;

-(void)getProducts:(NSDictionary *)params;

@end
