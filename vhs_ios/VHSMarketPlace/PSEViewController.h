//
//  PSEViewController.h
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/11/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connections.h"
#import "BButton.h"
@interface PSEViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,ConnectionsDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtCreditCard;
@property (weak, nonatomic) IBOutlet UITextField *txtBanc;
@property (weak, nonatomic) IBOutlet UITextField *txtAccount;
@property (weak, nonatomic) IBOutlet BButton *btnPay;
- (IBAction)pay:(id)sender;

@end
