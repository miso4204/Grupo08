//
//  RegisterViewController.h
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connections.h"
#import "BButton.h"


@interface RegisterViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,ConnectionsDelegate>
- (IBAction)register:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
- (IBAction)btnRegister:(id)sender;
@property (strong, nonatomic) IBOutlet BButton *btnRegisterNow;

@end
