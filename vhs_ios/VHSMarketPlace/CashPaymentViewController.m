//
//  CashPaymentViewController.m
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 4/26/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "CashPaymentViewController.h"
#import "AppDelegate.h"
#import  "Product.h"
#import "AFNetworking.h"

@interface CashPaymentViewController ()
@property (strong, nonatomic)   Connections *ConnectionDelegate;

@end

@implementation CashPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.txtAddress.delegate = self;
    self.txtMail.delegate = self;
    self.txtName.delegate = self;
    [self.btnPay setStyle:BButtonStyleBootstrapV3];
    [self.btnPay setType:BButtonTypeWarning];
    
    self.ConnectionDelegate = [[Connections alloc]init];

    self.title = @"Pay";
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

- (IBAction)pay:(id)sender {
    self.ConnectionDelegate.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    
    [params setObject:self.txtAddress.text forKey:@"buyerAddress"];
    
    [params setObject:self.txtMail.text forKey:@"buyerEmail"];

    [params setObject:self.txtName.text forKey:@"buyerName"];
    
    double amount=  [appDelegate totalAmount];
    
    NSString * paymentValue = [NSString stringWithFormat:@"%f",amount];
    
    [params setObject:paymentValue forKey:@"totalSale"];
    
    NSString *numberItems = [NSString stringWithFormat:@"%lu",(unsigned long)[appDelegate.shoppingCart count]];
    
    [params setObject:numberItems forKey:@"saleQuantity"];

    
    NSDictionary *paymentV = @{@"id": @"4"};
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtName resignFirstResponder];
    [self.txtMail resignFirstResponder];
    [self.txtAddress resignFirstResponder];

    
    return YES;
    
}
-(void)payProductsDidFinishSuccessfully:(NSDictionary*)responseObject{
    NSLog(@"response for paying %@",responseObject);


}
-(void)payProductsDidFinishWithFailure:(NSDictionary*)responseObject{



}
-(void)back{
    //   [self performSegueWithIdentifier:@"back" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
