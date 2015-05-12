//
//  PromotionsViewController.m
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/9/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "PromotionsViewController.h"
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
@interface PromotionsViewController (){
    Product * prod;

}
@property (strong, nonatomic) NSMutableArray *products;

@property (strong, nonatomic)   Connections *ConnectionDelegate;

@end

@implementation PromotionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ConnectionDelegate = [[Connections alloc]init];
    
    self.title = @"Promociones";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [self.tableviewProducts registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadPromotions];
}
- (void)loadPromotions
{
    self.ConnectionDelegate.delegate = self;
    
    [self.ConnectionDelegate getPromotions];
    
    
    
    //  self.products = [Product listProducts];
    
    //  [self.tableviewProducts reloadData];
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

-(void)GetPromotionsDidFinishSuccessfully:(NSDictionary*)responseObject{

    NSArray *items = [responseObject valueForKeyPath:@"collection.vhsSpecialOffer"];
    NSLog(@"arraty %@",items);
    self.returnP = [[NSMutableArray alloc]init];
    NSLog(@"items count %lu",(unsigned long)items.count);
    for (NSDictionary * test in items) {
        NSDictionary *description = [test objectForKey:@"description"];
        NSDictionary *endDate = [test objectForKey:@"endDate"];
        NSDictionary *idSpecialOffers = [test objectForKey:@"idSpecialOffers"];
        NSDictionary *latitude = [test objectForKey:@"latitude"];
        NSDictionary *longitude = [test objectForKey:@"longitude"];
        NSDictionary *mainImageUrl = [test objectForKey:@"mainImageUrl"];
        NSDictionary *offerCategory = [test objectForKey:@"offerCategory"];
        NSDictionary *price = [test objectForKey:@"price"];
        NSDictionary *publishDate = [test objectForKey:@"publishDate"];
        NSDictionary *shortName = [test objectForKey:@"shortName"];
        prod = [[Product alloc]init];
        prod.longitude = [[longitude objectForKey:@"text"] floatValue];
        prod.startDate =[publishDate objectForKey:@"text"];
        prod.image = [mainImageUrl objectForKey:@"text"];
        prod.price = [[price objectForKey:@"text"] intValue];
        prod.name = [shortName objectForKey:@"text"];
        prod.latitude =[[latitude objectForKey:@"text"] floatValue];
        prod.descriptions =[description objectForKey:@"text"];
        prod.id =[[idSpecialOffers objectForKey:@"text"] intValue];
        [self.returnP addObject:prod];
        NSLog(@"description and endate %@ %@",description,endDate);
    }

    
    [self.tableviewProducts reloadData];
    

}
-(void)GetPromotionsDidFinishWithFailure:(NSDictionary*)responseObject{



}


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
    
    
    NSLog(@"product in cart %d",product.id );
    
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
@end
