//
//  PSEViewController.m
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/11/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "PSEViewController.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "Payment.h"
#import "AppDelegate.h"
#import "Product.h"
@interface PSEViewController ()

@end

@implementation PSEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"PSE";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];

    self.txtName.delegate = self;
    self.txtEmail.delegate = self;
    self.txtCreditCard.delegate = self;
    self.txtBanc.delegate = self;
    self.txtAddress.delegate = self;
    self.txtAccount.delegate = self;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;
    
    [self.btnPay setStyle:BButtonStyleBootstrapV3];
    [self.btnPay setType:BButtonTypeTwitter];

    // Do any additional setup after loading the view.
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtAccount resignFirstResponder];
    [self.txtAddress resignFirstResponder];
    [self.txtBanc resignFirstResponder];
    [self.txtCreditCard resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtName resignFirstResponder];
    return YES;
    
}
- (IBAction)pay:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    
    [params setObject:self.txtAddress.text forKey:@"buyerAddress"];
    
    [params setObject:self.txtEmail.text forKey:@"buyerEmail"];
    
    [params setObject:self.txtName.text forKey:@"buyerName"];
    
    double amount=  [appDelegate totalAmount];
    
    NSString * paymentValue = [NSString stringWithFormat:@"%f",amount];
    
    [params setObject:paymentValue forKey:@"totalSale"];
    
    NSString *numberItems = [NSString stringWithFormat:@"%lu",(unsigned long)[appDelegate.shoppingCart count]];
    
    [params setObject:numberItems forKey:@"saleQuantity"];
    
    [params setObject:self.txtBanc.text forKey:@"pseBankName"];
    
    [params setObject:self.txtAccount.text forKey:@"pseAccountNumber"];

    
    NSDictionary *paymentV = @{@"id": @"3"};
    [params setObject:paymentV forKey:@"paymentMethod"];
    
    
    NSDictionary *cityV = @{@"idCity": @"1"};
    [params setObject:cityV forKey:@"buyerCity"];
    
    NSMutableDictionary * productPaying = [[NSMutableDictionary alloc]init];
    
    for (Product * products in appDelegate.shoppingCart) {
        Product * pro = [[Product alloc]init];
        pro =products;
        [productPaying setObject:[NSString stringWithFormat:@"%d",pro.id] forKey:@"idSpecialOffers"];
        NSLog(@"products in cart %@",products);
    }
    [params setObject:productPaying forKey:@"specialOffer"];
    
    NSLog(@"parameters for paying %@",params);
    
    //  [self.ConnectionDelegate payProducts:params];
    
    NSURL *baseURL = [NSURL URLWithString:@"http://192.168.0.174:8087/VhsBackEndServices/webresources/"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:@"vhsoffersale" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Pago exitoso"
                                                            message:@"Esperamos que disfrutes tu compra"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        //here is place for code executed in success case
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //here is place for code executed in success case
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error while sending POST"
                                                            message:@"Sorry, try again."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        NSLog(@"Error: %@", [error localizedDescription]);
    }];

}
-(void)back{
    //   [self performSegueWithIdentifier:@"back" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
