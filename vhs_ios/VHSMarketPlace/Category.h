//
//  Category.h
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/5/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categoryc : NSObject
@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;


- (id)initWithId:(int)categoryid name:(NSString *)name image:(NSString *)image;
+ (NSMutableArray *)listcategories;
@end
