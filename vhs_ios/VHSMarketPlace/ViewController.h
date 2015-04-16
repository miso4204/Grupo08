//
//  ViewController.h
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Connections.h"

@interface ViewController : UIViewController<ConnectionsDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableviewProducts;


@property (strong, nonatomic)   Product *myProduct;
@end

