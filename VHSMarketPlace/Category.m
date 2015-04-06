//
//  Category.m
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/5/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "Category.h"

@implementation Categoryc

- (id)initWithId:(int)productid name:(NSString *)name image:(NSString *)image
{
    self = [super init];
    
    if(self)
    {
        self.id = productid;
        self.name = name;
        self.image = image;
    }
    
    return self;
}

+ (NSMutableArray *)listcategories
{
    NSMutableArray *products = [[NSMutableArray alloc] init];
    
    Categoryc *category = [[Categoryc alloc] init];
    category.id=1;
    category.name=@"Hoteles";
    category.image=@"https://phgcdn.com/images/uploads/MLAEH/corporatemasthead/grand-hotel-excelsior_masthead.jpg";
    
    
    Categoryc *cat2 = [[Categoryc alloc] init];
    cat2.id=2;
    cat2.name=@"Restaurantes";
    cat2.image=@"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQx8L4Fg96RCPNT7QGOD2o8lde171sy8Zgd7hGoJReBokIeu15AKA";
    
    Categoryc *cat3 = [[Categoryc alloc] init];
    cat3.id=3;
    cat3.name=@"Paquetes";
    cat3.image=@"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQGBjIrTTxhA72KVq0DUNpbpf0_SPYe7ultKfCKfmQLmaUoAF5hGg";
    
    
    
    [products addObject:category];
    
    [products addObject:cat2];
    
    [products addObject:cat3];
    
    
    return products;
}

@end
