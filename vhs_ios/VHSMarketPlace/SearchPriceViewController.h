//
//  SearchPriceViewController.h
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/2/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BButton.h"
#import "Connections.h"
#import "Product.h"
@interface SearchPriceViewController : UIViewController<ConnectionsDelegate>
enum Search {
    kAlertSearch = 1,
    kalertOther = 2,
};

- (IBAction)search:(id)sender;
@property (weak, nonatomic) IBOutlet BButton *btnPrices;
@property (weak, nonatomic) IBOutlet BButton *btnDates;

@property (strong, nonatomic) IBOutlet UITableView *tableviewProducts;
@property (nonatomic, retain) NSMutableArray *returnP;


@property (strong, nonatomic)   Product *myProduct;
@property (weak, nonatomic) IBOutlet BButton *btnTryAgain;
- (IBAction)tryAgain:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSearchAgain;

@end
