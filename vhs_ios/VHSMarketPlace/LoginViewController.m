//
//  LoginViewController.m
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "LoginViewController.h"
#import "Connections.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "detailViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) Connections *loginAPIConnection;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtUserName.delegate = self;
    self.txtPassword.delegate = self;
    // Do any additional setup after loading the view.
    self.loginAPIConnection = [[Connections alloc] init];
    
    [self.btnLogin setStyle:BButtonStyleBootstrapV3];
    [self.btnLogin setType:BButtonTypeWarning];
    
    
    
    self.title = @"Login";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    
    self.loginAPIConnection.delegate = self;
    
    
    
    NSDictionary *params = @{@"username": self.txtUserName.text,
                             @"password":self.txtPassword.text};
    
    
    [self.loginAPIConnection login:params];
    

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtUserName resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    
    
    return YES;
    
}
-(void)LoginDidFinishSuccessfully:(NSDictionary*)responseObject{
    NSLog(@"success %@",responseObject);

    
    
    [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"username"] forKey:@"user"];
    [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"password"]  forKey:@"password"];
    

    [[NSUserDefaults standardUserDefaults]synchronize];

    

    [self performSegueWithIdentifier:@"catalog" sender:self];
}
-(void)LoginDidFinishWithFailure:(NSDictionary*)responseObject{

    NSLog(@"error %@",responseObject);

    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Hay un error en tu solicitud, Porfavor intenta de nuevo" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];

}
-(void)back{
    //   [self performSegueWithIdentifier:@"back" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
