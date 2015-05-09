//
//  PromotionsViewController.h
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/9/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Connections.h"

@interface PromotionsViewController : UIViewController<ConnectionsDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableviewProducts;
@property (nonatomic, retain) NSMutableArray *returnP;


@property (strong, nonatomic)   Product *myProduct;
@end
