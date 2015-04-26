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
        
        self.txtCreditCardNumber.text = info.redactedCardNumber;
        
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
    self.txtCreditCardNumber.text = cardInfo.redactedCardNumber;
    
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
    return YES;
    
}
@end
