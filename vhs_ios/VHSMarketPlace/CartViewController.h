//
//  CartViewController.h
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardIO.h"

@interface CartViewController : UIViewController<CardIOPaymentViewControllerDelegate,UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableviewCart;
@property (strong, nonatomic) UIAlertView * alert;

enum AlertViewTags {
    kAlertCheckOut = 1,
    kAlertAddCreditCard = 2,
    
    
};

@end
