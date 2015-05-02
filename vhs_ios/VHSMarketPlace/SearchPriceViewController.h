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

@interface SearchPriceViewController : UIViewController<ConnectionsDelegate>
enum Search {
    kAlertSearch = 1,
    kalertOther = 2,
};

- (IBAction)search:(id)sender;
@property (weak, nonatomic) IBOutlet BButton *btnPrices;
@property (weak, nonatomic) IBOutlet BButton *btnDates;

@end
