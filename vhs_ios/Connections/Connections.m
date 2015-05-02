//
//  Connections.m
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "Connections.h"
#import "Client.h"
#import "XMLReader.h"
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



-(void)getCategories{

    
    
    [[Client sharedInstance] GET:@"vhscategory" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        NSLog(@"The response to the VHS categories  request is:  %@", xmlDictionary);
        [self.delegate GetCategoriesDidFinishSuccessfully:xmlDictionary];
        
    }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             NSLog(@"error report %@",error);
                             
                             
                             
                             
                         }];

}

-(void)subCategories:(NSDictionary *)params{



}

-(void)getProducts{
    
    [[Client sharedInstance] GET:@"vhsspecialoffer" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        NSLog(@"The response to the VHS Special offer request is:  %@", xmlDictionary);
        @try {
            [self.delegate GetProductsDidFinishSuccessfully:xmlDictionary];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        
    }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             NSLog(@"error report %@",error);
                             
                             
                             
                             
                         }];
    


    



}
-(void)payProducts:(NSDictionary *)params{

    [[Client sharedInstance] POST:@"vhsoffersale" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        NSLog(@"The response to the VHS Special offer request is:  %@", xmlDictionary);
        @try {
            [self.delegate payProductsDidFinishSuccessfully:xmlDictionary];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        
    }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             NSLog(@"error report %@",error);
                             
                             
                             
                             
                         }];
}
-(void)getPaymentMethods{

    [[Client sharedInstance] GET:@"vhspaymentmethod" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        NSLog(@"The response to the VHS Special offer request is:  %@", xmlDictionary);
        @try {
            [self.delegate getPaymentMethodsFinishSuccessfully:xmlDictionary];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        
    }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             NSLog(@"error report %@",error);
                             
                             
                             
                             
                         }];
    



}
-(void)getCity{

    [[Client sharedInstance] GET:@"vhscity" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        NSLog(@"The response to the VHS Special offer request is:  %@", xmlDictionary);
        @try {
            [self.delegate getCityDidFinishSuccessfully:xmlDictionary];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        
    }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             NSLog(@"error report %@",error);
                             
                             
                             
                             
                         }];
    
    



}
@end
