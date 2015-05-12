//
//  PaymentViewController.m
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 4/18/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "PaymentViewController.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "AppDelegate.h"
#import "Product.h"
@interface PaymentViewController ()
@property (strong, nonatomic)   Connections *ConnectionDelegate;



@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ConnectionDelegate = [[Connections alloc]init];

    self.title = @"Pagos";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    
    self.txtAddress.delegate = self;
    self.txtCreditCardNumber.delegate = self;
    self.txtCvv.delegate = self;
    self.txtDate.delegate = self;
    self.txtName.delegate = self;
    self.txtMail.delegate = self;
    
    [self.btnScan setStyle:BButtonStyleBootstrapV3];
    [self.btnScan setType:BButtonTypeFacebook];
    [self.btnPay setStyle:BButtonStyleBootstrapV3];
    [self.btnPay setType:BButtonTypeTwitter];

   // [self.btnScan setStyle:BButtonStyleBootstrapV3];
   // [self.btnScan setType:BButtonTypeTwitter];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;

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

- (IBAction)pay:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    
    [params setObject:self.txtAddress.text forKey:@"buyerAddress"];
    
    [params setObject:self.txtMail.text forKey:@"buyerEmail"];
    
    [params setObject:self.txtName.text forKey:@"buyerName"];
    
    [params setObject:self.txtCreditCardNumber.text forKey:@"creditCardNumber"];
    
    [params setObject:self.txtCvv.text forKey:@"creditCardVerificationCode"];
    

    NSArray * date = [self getDataOfQueryString:self.txtDate.text andseparator:@"/"];
    
    [params setObject:date[0] forKey:@"creditCardExpirationMonth"];
    
    [params setObject:date[1] forKey:@"creditCardExpirationYear"];
    


    double amount=  [appDelegate totalAmount];
    
    NSString * paymentValue = [NSString stringWithFormat:@"%f",amount];
    
    [params setObject:paymentValue forKey:@"totalSale"];
    
    NSString *numberItems = [NSString stringWithFormat:@"%lu",(unsigned long)[appDelegate.shoppingCart count]];
    
    [params setObject:numberItems forKey:@"saleQuantity"];
    
    
    NSDictionary *paymentV = @{@"id": @"2"};
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

-(NSArray *)getDataOfQueryString:(NSString *)url andseparator:(NSString *)separator{
     NSArray *strURLParse = [url componentsSeparatedByString:separator];
    NSLog(@"parse %@",[strURLParse objectAtIndex:0]);
      return strURLParse;
    
}


- (IBAction)scan:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [self presentViewController:scanViewController animated:YES completion:nil];
}
- (void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)info {
    if (info) {
        // The full card number is available as info.cardNumber, but don't log that!
        NSLog(@"Received card info. Number: %@, expiry: %02i/%i, cvv: %@. card Type: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv,info.cardType);
        // Use the card info...
        
        self.txtCreditCardNumber.text = info.cardNumber;
        
        self.txtCvv.text = info.cvv;
        
        self.txtDate.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)info.expiryMonth,(unsigned long)info.expiryYear];
    }
    else {
        NSLog(@"User cancelled payment info");
        // Handle user cancellation here...
    }
    
    [cardIOView removeFromSuperview];
}
-(void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)cardInfo inPaymentViewController:(CardIOPaymentViewController *)paymentViewController{

    
    NSLog(@"card information %ld",(long)cardInfo.cardType);
    self.txtCreditCardNumber.text = cardInfo.cardNumber;
    
    self.txtCvv.text = cardInfo.cvv;
    
    self.txtDate.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)cardInfo.expiryMonth,(unsigned long)cardInfo.expiryYear];
    // Use the card info...
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
    
    
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtAddress resignFirstResponder];
    [self.txtCvv resignFirstResponder];
    [self.txtCreditCardNumber resignFirstResponder];
    [self.txtDate resignFirstResponder];
    [self.txtName resignFirstResponder];
    [self.txtMail resignFirstResponder];
    return YES;
    
}
-(void)back{
    //   [self performSegueWithIdentifier:@"back" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
