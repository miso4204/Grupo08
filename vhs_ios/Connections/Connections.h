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


-(void)GetProductsDidFinishSuccessfully:(NSDictionary*)responseObject; //  ViewController
-(void)GetProductsDidFinishWithFailure:(NSDictionary*)responseObject; //  ViewController


-(void)GetCategoriesDidFinishSuccessfully:(NSDictionary*)responseObject; //  CatalogViewController
-(void)GetCategoriesDidFinishWithFailure:(NSDictionary*)responseObject; //  CatalogViewController

-(void)getPaymentMethodsFinishSuccessfully:(NSDictionary*)responseObject; //  CatalogViewController
-(void)getPaymentMethodsDidFinishWithFailure:(NSDictionary*)responseObject; //  CatalogViewController

-(void)payProductsDidFinishSuccessfully:(NSDictionary*)responseObject; //  CatalogViewController
-(void)payProductsDidFinishWithFailure:(NSDictionary*)responseObject; //  CatalogViewController

-(void)getCityDidFinishSuccessfully:(NSDictionary*)responseObject; //  CatalogViewController
-(void)getCityDidFinishWithFailure:(NSDictionary*)responseObject; //  CatalogViewController

@end



@interface Connections : NSObject<NSURLConnectionDataDelegate>{
    
    int responseStatusCode;
    
}
@property (nonatomic, strong) IBOutlet id<ConnectionsDelegate> delegate;

-(void)login:(NSDictionary *)params ;

-(void)Register:(NSDictionary *)params;

-(void)getCategories;

-(void)subCategories:(NSDictionary *)params;

-(void)getProducts;

-(void)payProducts:(NSDictionary *)params;

-(void)getPaymentMethods;

-(void)getCity;


@end
