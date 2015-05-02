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

@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@end
