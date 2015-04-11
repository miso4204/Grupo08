//
//  RegisterViewController.m
//  Shopper
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "RegisterViewController.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "detailViewController.h"

@interface RegisterViewController ()
@property (nonatomic, strong) Connections *APIConnection;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.btnRegisterNow setStyle:BButtonStyleBootstrapV3];
    [self.btnRegisterNow setType:BButtonTypeWarning];
    
 

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;
    self.title = @"Registro";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    
    
    // Do any additional setup after loading the view.
    if([self.navigationController.navigationBar respondsToSelector:@selector(barTintColor)])
    {
        // iOS7
        // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:93.0/255.0 green:175.0/255.0 blue:189.0/255.0 alpha:1];
        self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
        
        
    }
    else
    {
        // older
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if ([version floatValue] >= 8.0) {
        
        self.navigationController.navigationBar.layer.shadowColor = [[UIColor orangeColor] CGColor];

        
    }
    
    self.txtName.delegate = self;
    self.txtPassword.delegate = self;
    self.txtUserName.delegate = self;
    self.txtLastName.delegate = self;

    self.APIConnection = [[Connections alloc] init];
  
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtUserName resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtLastName resignFirstResponder];
    [self.txtName resignFirstResponder];
    
    
    return YES;
    
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
-(void)RegisterDidFinishSuccessfully:(NSDictionary*)responseObject{

    NSLog(@"success %@",responseObject);

    
    [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"username"] forKey:@"user"];
    [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"password"]  forKey:@"password"];

    [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"firstName"] forKey:@"name"];
    [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"lastName"] forKey:@"LastName"];

    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self performSegueWithIdentifier:@"catalog" sender:self];

}
-(void)RegisterDidFinishWithFailure:(NSDictionary*)responseObject{
    NSLog(@"error %@",responseObject);

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Hay un error en tu solicitud, Porfavor intenta de nuevo" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];

}

- (IBAction)register:(id)sender {
    
    self.APIConnection.delegate = self;
    
    
    NSDictionary *params = @{@"username": self.txtUserName.text,
                             @"password":self.txtPassword.text ,
                             @"firstName":self.txtName.text,
                             @"lastName":self.txtLastName.text};
    
    
    [self.APIConnection Register:params];

}
-(void)back{
    //   [self performSegueWithIdentifier:@"back" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)btnRegister:(id)sender {
}
@end
