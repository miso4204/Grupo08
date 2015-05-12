//
//  CartViewController.m
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "CartViewController.h"
#import "AppDelegate.h"
#import "ProductCartCell.h"
#import "Product.h"
#import "PayPalMobile.h"
#import "CheckoutHeaderview.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "Payment.h"
@interface CartViewController ()
@property (strong, nonatomic, readwrite) PayPalConfiguration *payPalConfiguration;
@property (strong, nonatomic)   Connections *ConnectionDelegate;

@end
@implementation CartViewController{
    Payment * p;

}
@synthesize alert=_alert;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ConnectionDelegate = [[Connections alloc]init];

    self.title = @"Cart";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    [self.tableviewCart registerNib:[UINib nibWithNibName:@"ProductCartCell" bundle:nil] forCellReuseIdentifier:@"ProductCartCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    self.tableviewPayment.hidden =YES;

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [PayPalMobile initializeWithClientIdsForEnvironments:
     @{PayPalEnvironmentProduction : PayPalEnvironmentProduction,
       PayPalEnvironmentSandbox : PayPalEnvironmentSandbox}];
    
    // Start out working with the test environment! When you are ready, switch to PayPalEnvironmentProduction.
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentNoNetwork];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _payPalConfiguration = [[PayPalConfiguration alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableviewCart) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        return [appDelegate.shoppingCart count];
    }else
        return self.returnP.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView== self.tableviewCart) {
        
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    static NSString *CellIdentifier = @"ProductCartCell";
    
    ProductCartCell *cell = (ProductCartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Product *item = [appDelegate.shoppingCart objectAtIndex:[indexPath row]];
    
    // Configure the cell...
   // cell.productImage.image = [self getImageFromURL:item.image];
    NSURL* url = [NSURL URLWithString:item.image];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   
                                   UIImage * image = [UIImage imageWithData:data];
                                   cell.productImage.image  = image;
                               }
                               
                           }];

    cell.productImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.productTitle.text =item.name;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    cell.productPrice.text = [NSString stringWithFormat:@"$%@", [formatter stringFromNumber:[NSNumber numberWithDouble:item.price]]];
    
   // cell.quantity.text = [NSString stringWithFormat:@"%d", item.quantity];
    
    [cell.deleteButton addTarget:self action:@selector(deleteProduct:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag = [indexPath row];
    
    return cell;
        
    }else{
    
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        //NSString * cellString;
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            
        }
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        Payment *pays = [[Payment alloc]init];
        pays=[self.returnP objectAtIndex:indexPath.row];
        
        cell.textLabel.text = pays.name;
        
        
        return cell;
    
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableviewPayment) {
        
  
    Payment *pays = [[Payment alloc]init];
    pays=[self.returnP objectAtIndex:indexPath.row];
    
    if ([pays.idPayment isEqualToString:@"4"]) {
        [self performSegueWithIdentifier:@"cash" sender:self];

    }else if ([pays.idPayment isEqualToString:@"2"]){
        [self performSegueWithIdentifier:@"credit" sender:self];

    }else{
        [self performSegueWithIdentifier:@"pse" sender:self];

        /*
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        // Create a PayPalPayment
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        
        // Amount, currency, and description
        payment.amount = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:[appDelegate totalAmount]] decimalValue]];
        payment.currencyCode = @"USD";
        payment.shortDescription = @"VHS MarketPlace";
        
        // Use the intent property to indicate that this is a "sale" payment,
        // meaning combined Authorization + Capture. To perform Authorization only,
        // and defer Capture to your server, use PayPalPaymentIntentAuthorize.
        payment.intent = PayPalPaymentIntentSale;
        
        // Check whether payment is processable.
        if (!payment.processable) {
            // If, for example, the amount was negative or the shortDescription was empty, then
            // this payment would not be processable. You would want to handle that here.
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Payment not processable"
                                                                message:@"The payment is not processable"
                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
            return;
        }
        
        // Create a PayPalPaymentViewController.
        PayPalPaymentViewController *paymentViewController;
        paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                       configuration:self.payPalConfiguration
                                                                            delegate:self];
        
        // Present the PayPalPaymentViewController.
        [self.navigationController presentViewController:paymentViewController animated:YES completion:nil];
        
        */

    
    }
}

}
- (void)deleteProduct:(UIButton *)button
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    [appDelegate.shoppingCart removeObjectAtIndex:button.tag];
   
    [self.tableviewCart reloadData];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CheckoutHeaderView" owner:self options:nil];
    CheckoutHeaderview *checkoutHeaderview = [nib objectAtIndex:0];
    
    checkoutHeaderview.subtotal.text = [NSString stringWithFormat:@"#items: %lu", (unsigned long)[appDelegate.shoppingCart count]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    checkoutHeaderview.total.text = [NSString stringWithFormat:@"$%@", [formatter stringFromNumber:[NSNumber numberWithDouble:[appDelegate totalAmount]]]];
    
    [checkoutHeaderview.checkoutButton addTarget:self action:@selector(checkout:) forControlEvents:UIControlEventTouchUpInside];
    
    return checkoutHeaderview;
}
- (void)checkout:(UIButton *)button
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if ([appDelegate.shoppingCart count]==0) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Problema", nil)
                                                      message:NSLocalizedString(@"No tienes ningún producto en el carrito de compras.", nil)
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"Cancelar", nil)
                                            otherButtonTitles:nil]; //!!JCS.8aug2012.Agregar FB
        [alert show];
    }else{
    self.ConnectionDelegate.delegate = self;
    
    [self.ConnectionDelegate getPaymentMethods];
    
    self.tableviewPayment.hidden =NO;
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 32, 32);
    [button2 setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button2];
    self.navigationItem.leftBarButtonItem=barButton;
    }

}
-(void)back{

    self.tableviewPayment.hidden = YES;
    self.navigationItem.leftBarButtonItem=nil;
}
-(void)showAlertPayment{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.shoppingCart count]>0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Métodos de pago"
                                                        message:@"Porfavor selecciona tu método de pago"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"PayPal",@"Tarjeta de crédito", nil];
        alert .tag = kAlertCheckOut;
        
        [alert show];

    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No tienes productos en el carrito de compras"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    
    }

    

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.0f;
}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment
{
    // Send the entire confirmation dictionary
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                           options:0
                                                             error:nil];
    
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}


#pragma mark - PayPalPayment Delegate

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Payment cancelled" message:@"The payment was cancelled"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment
{
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // clear cart
    
    // Dismiss the PayPalPaymentViewController.
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Payment made" message:@"The payment was successfully made"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
    [[self navigationController] tabBarItem].badgeValue = @"1";

}
-(void)viewDidAppear:(BOOL)animated{
    [CardIOUtilities preload];

    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:1] setBadgeValue:nil];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    

    [self.tableviewCart reloadData];
    NSLog(@"selpshopping %@",self.productCart);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == kAlertCheckOut) {
        
        if (buttonIndex == 1) {
            
        }else if (buttonIndex ==2) {
            [self performSegueWithIdentifier:@"credit" sender:self];
         
        
        }else if (buttonIndex == 3){
            
            // call the api with the payment and the products
        
        
        }
    }

}
- (void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)info {
    if (info) {
        // The full card number is available as info.cardNumber, but don't log that!
        NSLog(@"Received card info. Number: %@, expiry: %02i/%i, cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv);
        // Use the card info...
    }
    else {
        NSLog(@"User cancelled payment info");
        // Handle user cancellation here...
    }
    
    [cardIOView removeFromSuperview];
}
-(void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)cardInfo inPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
    NSLog(@"Received card info. Number: %@, expiry: %02i/%i, cvv: %@.", cardInfo.redactedCardNumber, cardInfo.expiryMonth, cardInfo.expiryYear, cardInfo.cvv);
    // Use the card info...
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];

}
-(void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController{


    [paymentViewController dismissViewControllerAnimated:YES completion:nil];

}

-(void)getPaymentMethodsFinishSuccessfully:(NSDictionary*)responseObject{


    NSArray *items = [responseObject valueForKeyPath:@"collection.vhsPaymentMethod"];
    NSLog(@"all payments %@",items);
    self.returnP= [[NSMutableArray alloc]init];
    for (NSDictionary * test in items) {

        NSDictionary *idt = [test objectForKey:@"id"];
        NSDictionary *namet = [test objectForKey:@"name"];

        NSString * stringid = [idt objectForKey:@"text"];
        NSString * stringname = [namet objectForKey:@"text"];
        p = [[Payment alloc]init];
        p.name =stringname;
        p.idPayment = stringid;
        [self.returnP addObject:p];
    }
       NSLog(@"self return tt %@",self.returnP);
    
    [self.tableviewPayment reloadData];

}
-(void)loadPayments:(NSArray *)payment{

   
}
-(void)getPaymentMethodsDidFinishWithFailure:(NSDictionary*)responseObject{



}
@end
