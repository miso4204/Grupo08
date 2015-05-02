//
//  menuSearchViewController.h
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/2/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BButton.h"
@interface menuSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet BButton *btnDate;
@property (weak, nonatomic) IBOutlet BButton *btnPrice;
@property (weak, nonatomic) IBOutlet BButton *btnPlace;
- (IBAction)searchDate:(id)sender;
- (IBAction)searchPrice:(id)sender;
- (IBAction)searchPlace:(id)sender;

@end
