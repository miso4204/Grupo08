//
//  searchDateViewController.h
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/2/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BButton.h"
#import "Connections.h"
#import "Product.h"

@interface searchDateViewController : UIViewController<ConnectionsDelegate>
@property (weak, nonatomic) IBOutlet BButton *btnDate;
@property (weak, nonatomic) IBOutlet BButton *btnFilter;
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)close:(id)sender;
- (IBAction)setDate:(id)sender;
- (IBAction)search:(id)sender;
- (IBAction)getDate:(id)sender;
@property (strong, nonatomic) NSString *dateFinal;

@property (strong, nonatomic) IBOutlet UITableView *tableviewProducts;
@property (nonatomic, retain) NSMutableArray *returnP;


@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (strong, nonatomic)   Product *myProduct;
@property (weak, nonatomic) IBOutlet BButton *btnTryAgain;
- (IBAction)tryAgain:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSearchAgain;

@end
