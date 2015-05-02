//
//  SearchViewController.h
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/5/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "BButton.h"
#import "Connections.h"
@interface SearchViewController : UIViewController<ConnectionsDelegate>
@property (weak, nonatomic) IBOutlet BButton *btnPriceRange;
- (IBAction)getLocation:(id)sender;
- (IBAction)setBeginDate:(id)sender;
- (IBAction)setEndDate:(id)sender;
@property (strong, nonatomic) IBOutlet BButton *btnBeginDate;
@property (strong, nonatomic) IBOutlet BButton *btnEndDate;
@property (weak, nonatomic) IBOutlet UIView *viewForDate;
@property (weak, nonatomic) IBOutlet UIView *datePicker;
- (IBAction)close:(id)sender;
@property (nonatomic, retain) NSMutableArray *returnP;
@property (weak, nonatomic) IBOutlet UITableView *tableviewLocation;
@property (weak, nonatomic) IBOutlet UITextField *lblCity;
@property (weak, nonatomic) IBOutlet BButton *btnSearch;
- (IBAction)search:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewForDateEnd;
- (IBAction)closeEndDate:(id)sender;

@property (weak, nonatomic) IBOutlet NSString *city;


@end
