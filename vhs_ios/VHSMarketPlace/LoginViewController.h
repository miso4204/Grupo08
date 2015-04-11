//
//  LoginViewController.h
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connections.h"
#import "BButton.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,ConnectionsDelegate>
- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet BButton *btnLogin;

@end
