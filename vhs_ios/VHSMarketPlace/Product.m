//
//  Product.m
//  ShoppingCartExample
//
//  Created by Jose Gustavo Rodriguez Baldera on 5/22/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

#import "FMDatabase.h"
#import "Product.h"
#import "Db.h"


@implementation Product

- (id)initWithId:(int)productid name:(NSString *)name image:(NSString *)image andPrice:(double)price andLatitude:(float)latitude andLongitude:(float)longitude andDescrioption:(NSString *)descriptions andimages:(NSMutableArray *)images
{
    self = [super init];

    if(self)
    {
        self.id = productid;
        self.name = name;
        self.image = image;
        self.price = price;
        self.latitude = latitude;
        self.longitude = longitude;
        self.descriptions = descriptions;
        self.images =images;
        
        
    }

    return self;
}

+ (NSMutableArray *)listProducts
{
    NSMutableArray *products = [[NSMutableArray alloc] init];
    
    Product *product = [[Product alloc] init];
    product.id=1;
    product.name=@"Hotel Lujoso";
    product.image=@"https://phgcdn.com/images/uploads/MLAEH/corporatemasthead/grand-hotel-excelsior_masthead.jpg";
    product.price=20000;
    product.latitude = 4.719684f;
    product.longitude =-74.02594909999999f;
    product.descriptions = @"Uno de los mejores hoteles del mundo";
    
    
    
    Product *product2 = [[Product alloc] init];
    product2.id=2;
    product2.name=@"Hotel Campestre";
    product2.image=@"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQx8L4Fg96RCPNT7QGOD2o8lde171sy8Zgd7hGoJReBokIeu15AKA";
    product2.price=100000;
    product2.latitude = 6.217749f;
    product2.longitude =-75.56982049999999f;
    product2.descriptions = @"Uno de los mejores hoteles del mundo";

    
    Product *product3 = [[Product alloc] init];
    product3.id=3;
    product3.name=@"Paquete Viajero";
    product3.image=@"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQGBjIrTTxhA72KVq0DUNpbpf0_SPYe7ultKfCKfmQLmaUoAF5hGg";
    product3.price=500000;
    product3.latitude=41.9076963f;
    product3.longitude=12.49881449999998f ;
    product3.descriptions = @"Uno de los mejores hoteles del mundo";

    
    Product *product4 = [[Product alloc] init];
    product4.id=3;
    product4.name=@"Hotel en la ciudad";
    product4.image=@"http://www.cnnexpansion.com/media/2011/09/14/gran-hotel-de-la-ciudad-de-mexico.jpg";
    product4.price=800000;
    product4.latitude=41.9076963f;
    product4.longitude=12.49881449999998f ;
    product4.descriptions = @"Uno de los mejores hoteles del mundo";

    
    [products addObject:product];
    
    [products addObject:product2];
    
    [products addObject:product3];
    
    [products addObject:product4];
    
    return products;
    return products;
}


@end