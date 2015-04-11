//
//  Product.h
//  ShoppingCartExample
//
//  Created by Jose Gustavo Rodriguez Baldera on 5/22/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

@interface Product : NSObject
@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (assign, nonatomic) double price;
@property (assign, nonatomic) float latitude;
@property (assign, nonatomic) float longitude;
@property (strong, nonatomic) NSString *descriptions;
@property (strong, nonatomic) NSMutableArray * images;

- (id)initWithId:(int)productid name:(NSString *)name image:(NSString *)image andPrice:(double) price andLatitude:(float)latitude andLongitude:(float)longitude andDescrioption:(NSString *)descriptions andimages:(NSMutableArray *)images;
+ (NSMutableArray *)listProducts;
@end