//
//  SearchPriceViewController.m
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/2/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "SearchPriceViewController.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "detailViewController.h"
#import "LocationSe.h"
#import "Product.h"
#import "ProductCell.h"
#import "AppDelegate.h"

@interface SearchPriceViewController (){
    Product * prod1;

}
@property (strong, nonatomic)   Connections *ConnectionDelegate;

@end

@implementation SearchPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ConnectionDelegate = [[Connections alloc]init];
    
    self.title = @"Search";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    
    [self.btnPrices setStyle:BButtonStyleBootstrapV3];
    [self.btnPrices setType:BButtonTypePrimary];
    
    [self.btnDates setStyle:BButtonStyleBootstrapV3];
    [self.btnDates setType:BButtonTypePrimary];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;
    
    self.viewSearchAgain.hidden = YES;
    
    self.tableviewProducts.hidden = YES;
    [self.tableviewProducts registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];


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
-(void)back{
    //   [self performSegueWithIdentifier:@"back" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == kAlertSearch){
        NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
        

        if (buttonIndex == 1) { // Set buttonIndex == 0 to handel "Ok"/"Yes" button response
            // 0-200
            [params setObject:@"0/200000" forKey:@"price"];

            
        }else if (buttonIndex == 2){
            [params setObject:@"200000/400000" forKey:@"price"];

            // 200-400
            
        }else if (buttonIndex == 3){
            [params setObject:@"400000/600000" forKey:@"price"];

            // 400-600
            
        }else if (buttonIndex == 4){
            [params setObject:@"600000/10000000" forKey:@"price"];

            // más
            
        }
        self.ConnectionDelegate.delegate = self;
        [self.ConnectionDelegate searchPrice:params];
    }
}
- (IBAction)setPrice:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"Búsqueda", nil)
                          message:@"Por favor selecciona un rango de precios"
                          delegate:self
                          cancelButtonTitle:@"cancelar"
                          otherButtonTitles:@"de 0 a 200.000 ", @"de 200.000 a 400.000",@"de 400.000 a 600.000",@"más de 800.000",nil];
    
    alert.tag = kAlertSearch;
    
    [alert show];
    

}
- (IBAction)search:(id)sender {
}
-(void)searchPriceDidFinishSuccessfully:(NSDictionary*)responseObject{
    self.tableviewProducts.hidden =NO;
    NSArray *items = [responseObject valueForKeyPath:@"collection.vhsSpecialOffer"];
    NSLog(@"arraty %@",items);
    self.returnP = [[NSMutableArray alloc]init];
    NSDictionary* item;
    NSLog(@"items count %lu",(unsigned long)items.count);
    if (items.count ==0) {
        self.viewSearchAgain.hidden = NO;
    }
    
    for (int i =0; i<items.count; i++) {
        NSEnumerator *enumerator = [items[i] objectEnumerator];
        int count = 0;
        NSLog(@"items sub i %@",items[i]);
        while (item = (NSDictionary*)[enumerator nextObject]) {
            NSLog(@"proeuctssssss = %@",  [item objectForKey:@"text"]);
            
            if (count ==0) {
                prod1 = [[Product alloc]init];
                
                prod1.longitude = [[item objectForKey:@"text"] floatValue];
                count ++;
                NSLog(@"proeucts0 = %@",  [item objectForKey:@"text"]);
                
            }
            
            if (count ==1) {
                prod1.longitude = [[item objectForKey:@"text"] floatValue];
                count ++;
                NSLog(@"proeucts1 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count ==2){
                prod1.longitude =[[item objectForKey:@"text"] floatValue];
                count ++;
                NSLog(@"proeucts2 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count ==3){
                prod1.startDate =[item objectForKey:@"text"];
                count ++;
                NSLog(@"proeucts3 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count == 4) {
                prod1.image = [item objectForKey:@"text"];
                count ++;
                NSLog(@"proeucts4 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count ==5){
                prod1.price = [[item objectForKey:@"text"] intValue];
                count ++;
                NSLog(@"proeucts5 = %@",  [item objectForKey:@"text"]);
                
            }else if (count ==6){
                prod1.name = [item objectForKey:@"text"];
                count ++;
                NSLog(@"proeucts6 = %@",  [item objectForKey:@"text"]);
                
            }else if (count ==7){
                prod1.latitude =[[item objectForKey:@"text"] floatValue];
                count ++;
                NSLog(@"proeucts7 = %@",  [item objectForKey:@"text"]);
                
            }else if (count ==8){
                prod1.descriptions =[item objectForKey:@"text"];
                count ++;
                NSLog(@"proeucts8 = %@",  [item objectForKey:@"text"]);
                
            }else if (count ==9){
                NSLog(@"proeucts9 = %@",  [item objectForKey:@"text"]);
                prod1.startDate = [item objectForKey:@"text"];
                count ++;
            }else if (count ==10){
                count ++;
                NSLog(@"proeucts10 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count ==11){
                prod1.id =[[item objectForKey:@"text"] intValue];
                count =0;
                
                NSLog(@"proeucts11 = %@",  [item objectForKey:@"text"]);
                [self.returnP addObject:prod1];
            }
            
        }
        
    }
    [self.tableviewProducts reloadData];


}
-(void)searchPriceFinishWithFailure:(NSDictionary*)responseObject{


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.returnP count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    
    ProductCell *cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Product *product = [self.returnP objectAtIndex:[indexPath row]];
    
    // Configure the cell...
    
    
    // cell.productImage.image = [self getImageFromURL:product.image];
    NSURL* url = [NSURL URLWithString:product.image];
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
    cell.productTitle.text = product.name;
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    cell.productPrice.text = [NSString stringWithFormat:@"$%@", [formatter stringFromNumber:[NSNumber numberWithDouble:product.price]]];
    
    [cell.addToCartButton addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
    cell.addToCartButton.tag = [indexPath row];
    [cell.ViewDetailButton addTarget:self action:@selector(viewDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.ViewDetailButton.tag=[indexPath row];
    
    
    return cell;
}
- (void)viewDetail:(UIButton *)button
{
    Product *product = [self.returnP objectAtIndex:button.tag];
    
    self.myProduct = product;
    
    [self performSegueWithIdentifier:@"description" sender:self.myProduct];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"sender for book info %@",sender);
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"description"])
    {
        //   BookingInformationViewController *bookingInfo = segue.destinationViewController;
        UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
        detailViewController *eventsController = [navController topViewController];
        
        [eventsController setProduct:sender];
        
    }else if([segue.identifier isEqualToString:@"test123"]){
        
    }
    
}
- (void)addToCart:(UIButton *)button
{
    Product *product = [self.returnP objectAtIndex:button.tag];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.shoppingCart addObject:product];
    
    NSString *size = [NSString stringWithFormat:@"%lu",(unsigned long)[appDelegate.shoppingCart count]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Éxito" message:@"Este producto se ha agregado exitosamente al carrito de compras"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    
    
    NSLog(@"product in cart %d",product.id );
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:1] setBadgeValue:size];
    
    
    [UIView commitAnimations];
}
- (IBAction)tryAgain:(id)sender {
    self.viewSearchAgain.hidden = YES;
    self.tableviewProducts.hidden = YES;
}
@end
