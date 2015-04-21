//
//  ViewController.m
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 3/29/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"
#import "ProductCell.h"
#import "AppDelegate.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "detailViewController.h"
@interface ViewController (){
    Product * prod;


}
@property (strong, nonatomic) NSMutableArray *products;

@property (strong, nonatomic)   Connections *ConnectionDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ConnectionDelegate = [[Connections alloc]init];
    
    self.title = @"Home";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    

    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    appDelegate.shoppingCart = [[NSMutableArray alloc]init];
    
    [self.tableviewProducts registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];

    // Do any additional setup after loading the view, typically from a nib.
    [self loadProducts];

}
- (void)loadProducts
{
    self.ConnectionDelegate.delegate = self;
    
    [self.ConnectionDelegate getProducts];
    
    
    
    //  self.products = [Product listProducts];
    
   //  [self.tableviewProducts reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)addToCart:(UIButton *)button
{
    Product *product = [self.returnP objectAtIndex:button.tag];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    [appDelegate.shoppingCart addObject:product];
    
   NSString *size = [NSString stringWithFormat:@"%lu",(unsigned long)[appDelegate.shoppingCart count]];
    
  

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:1] setBadgeValue:size];
    
    
    [UIView commitAnimations];
}
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
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
-(void)GetProductsDidFinishSuccessfully:(NSDictionary*)responseObject{
    
    NSArray *items = [responseObject valueForKeyPath:@"collection.vhsSpecialOffer"];
    NSLog(@"arraty %@",items);
    self.returnP = [[NSMutableArray alloc]init];
    NSDictionary* item;
    NSLog(@"items count %lu",(unsigned long)items.count);
    for (int i =0; i<items.count; i++) {
        NSEnumerator *enumerator = [items[i] objectEnumerator];
        int count = 0;
        NSLog(@"items sub i %@",items[i]);
        while (item = (NSDictionary*)[enumerator nextObject]) {
            NSLog(@"proeuctssssss = %@",  [item objectForKey:@"text"]);

            if (count ==0) {
                prod = [[Product alloc]init];

                prod.longitude = [[item objectForKey:@"text"] floatValue];
                count ++;
                NSLog(@"proeucts0 = %@",  [item objectForKey:@"text"]);
                
            }
            
            if (count ==1) {
                prod.longitude = [[item objectForKey:@"text"] floatValue];
                count ++;
                NSLog(@"proeucts1 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count ==2){
                prod.longitude =[[item objectForKey:@"text"] floatValue];
                count ++;
                NSLog(@"proeucts2 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count ==3){
                prod.startDate =[item objectForKey:@"text"];
                count ++;
                NSLog(@"proeucts3 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count == 4) {
                prod.image = [item objectForKey:@"text"];
                count ++;
                NSLog(@"proeucts4 = %@",  [item objectForKey:@"text"]);
                
                
            }else if (count ==5){
                prod.price = [[item objectForKey:@"text"] intValue];
                count ++;
                NSLog(@"proeucts5 = %@",  [item objectForKey:@"text"]);
                
            }else if (count ==6){
                prod.name = [item objectForKey:@"text"];
                count ++;
                NSLog(@"proeucts6 = %@",  [item objectForKey:@"text"]);
                
            }else if (count ==7){
                prod.latitude =[[item objectForKey:@"text"] floatValue];
                count ++;
                NSLog(@"proeucts7 = %@",  [item objectForKey:@"text"]);
                
            }else if (count ==8){
                prod.descriptions =[item objectForKey:@"text"];
                count ++;
                NSLog(@"proeucts8 = %@",  [item objectForKey:@"text"]);
                
            }else if (count ==9){
                NSLog(@"proeucts9 = %@",  [item objectForKey:@"text"]);
                prod.startDate = [item objectForKey:@"text"];
                count ++;
            }else if (count ==10){
                 count ++;
                NSLog(@"proeucts10 = %@",  [item objectForKey:@"text"]);

                
            }else if (count ==11){
            
                prod.id =[[item objectForKey:@"text"] intValue];
                count =0;
                
                NSLog(@"proeucts11 = %@",  [item objectForKey:@"text"]);
                [self.returnP addObject:prod];

            }

        }

    }
    [self.tableviewProducts reloadData];
    
    
}

-(void)GetProductsDidFinishWithFailure:(NSDictionary*)responseObject{




}



@end
