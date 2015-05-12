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
-(void)searchPlace:(NSDictionary *)params{
    
    NSString * city = [params objectForKey:@"city"];
    NSString * path =[NSString stringWithFormat:@"%@%@",@"vhsspecialoffer/city/",city];
    [[Client sharedInstance] GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        NSLog(@"The response to the VHS Special offer request is:  %@", xmlDictionary);
        @try {
            [self.delegate searchPlaceDidFinishSuccessfully:xmlDictionary];
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
-(void)searchDate:(NSDictionary *)params{

    NSString * date = [params objectForKey:@"date"];
    NSString * path =[NSString stringWithFormat:@"%@%@",@"vhsspecialoffer/date/",date];
    [[Client sharedInstance] GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        NSLog(@"The response to the VHS  search request is:  %@", xmlDictionary);
        @try {
            [self.delegate searchDateDidFinishSuccessfully:xmlDictionary];
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
-(void)searchPrice:(NSDictionary *)params{

    NSString * price = [params objectForKey:@"price"];

    NSString * path =[NSString stringWithFormat:@"%@%@",@"vhsspecialoffer/price/",price];
    [[Client sharedInstance] GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        NSLog(@"The response to the VHS Special search request is:  %@", xmlDictionary);
        @try {
            [self.delegate searchPriceDidFinishSuccessfully:xmlDictionary];
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
-(void)getPromotions{
    [[Client sharedInstance] GET:@"vhsspecialoffer/special" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        NSLog(@"The response to the VHS Special offer request is:  %@", xmlDictionary);
        @try {
            [self.delegate GetPromotionsDidFinishSuccessfully:xmlDictionary];
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
-(void)getAdditionalValues:(NSDictionary *)params{
    NSString *path = [NSString stringWithFormat:@"%@/%@",@"vhsadditionalvalues/specialoffer",[params objectForKey:@"idproduct"]];

    [[Client sharedInstance] GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        @try {
            [self.delegate getAdditionalValuesDidFinishSuccessfully:xmlDictionary];
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
-(void)getSocialNetworks{
    [[Client sharedInstance] GET:@"vhssocialnetwork" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // Parse the XML into a dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:string error:&parseError];
        // Print the dictionary
        
        @try {
            [self.delegate getSocialNetworksDidFinishSuccessfully:xmlDictionary];
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
