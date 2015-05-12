//
//  PaymentViewController.h
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 4/18/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connections.h"
#import "BButton.h"
#import "CardIO.h"
#import "Connections.h"

@interface PaymentViewController : UIViewController<CardIOPaymentViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate,ConnectionsDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtCreditCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtCvv;
@property (weak, nonatomic) IBOutlet UITextField *txtMail;
@property (weak, nonatomic) IBOutlet BButton *btnPay;
- (IBAction)pay:(id)sender;
@property (weak, nonatomic) IBOutlet BButton *btnScan;
- (IBAction)scan:(id)sender;

@end
