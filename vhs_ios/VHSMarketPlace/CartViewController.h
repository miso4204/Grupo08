//
//  CartViewController.h
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardIO.h"
#import "Connections.h"

@interface CartViewController : UIViewController<CardIOPaymentViewControllerDelegate,UIAlertViewDelegate,ConnectionsDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableviewCart;
@property (strong, nonatomic) UIAlertView * alert;
@property (nonatomic, retain) NSMutableArray *returnP;


@property (strong, nonatomic) NSMutableArray * productCart;
@property (weak, nonatomic) IBOutlet UITableView *tableviewPayment;

enum AlertViewTags {
    kAlertCheckOut = 1,
    kAlertAddCreditCard = 2,
    
    
};

@end
