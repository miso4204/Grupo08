//
//  SearchViewController.m
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/5/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "SearchViewController.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "detailViewController.h"
#import "LocationSe.h"
#import "ProductCell.h"
#import "AppDelegate.h"
@interface SearchViewController (){
    Product * prod;

    LocationSe * p;

}
@property (strong, nonatomic)   Connections *ConnectionDelegate;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ConnectionDelegate = [[Connections alloc]init];

    self.viewForDate.layer.cornerRadius = 10.0f;
    self.viewForDate.layer.masksToBounds = YES;
    
    self.viewForDate.backgroundColor = [UIColor lightGrayColor];
    self.viewForDate.hidden = YES;

    self.viewForDateEnd.layer.cornerRadius = 10.0f;
    self.viewForDateEnd.layer.masksToBounds = YES;
    
    self.viewForDateEnd.backgroundColor = [UIColor lightGrayColor];
    self.viewForDateEnd.hidden = YES;
    self.tableviewLocation.hidden =YES;
    self.title = @"Search";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    [self.btnPriceRange setStyle:BButtonStyleBootstrapV3];
    [self.btnPriceRange setType:BButtonTypeFacebook];
    
    
    [self.btnBeginDate setStyle:BButtonStyleBootstrapV3];
    [self.btnBeginDate setType:BButtonTypeFacebook];
    
    [self.btnEndDate setStyle:BButtonStyleBootstrapV3];
    [self.btnEndDate setType:BButtonTypeFacebook];
    
    [self.btnSearch setStyle:BButtonStyleBootstrapV3];
    [self.btnSearch setType:BButtonTypePrimary];
    [self loadCity];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back2) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;
    self.viewSearchAgain.hidden = YES;
    
    self.tableviewProducts.hidden = YES;
    [self.tableviewProducts registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    


}
-(void)loadCity{
    self.ConnectionDelegate.delegate = self;
    
    [self.ConnectionDelegate getCity];



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

- (IBAction)getLocation:(id)sender {
    self.tableviewLocation.hidden = NO;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;
}
-(void)back2{

    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)setBeginDate:(id)sender {
    self.viewForDate.hidden = NO;
}

- (IBAction)setEndDate:(id)sender {
    self.viewForDateEnd.hidden = NO;
}
- (IBAction)close:(id)sender {
    self.viewForDate.hidden = YES;
}
-(void)getCityDidFinishSuccessfully:(NSDictionary*)responseObject{
    NSLog(@"cities supported %@",responseObject);
    
    NSArray *items = [responseObject valueForKeyPath:@"collection.vhsCity"];

    NSEnumerator *enumerator = [items objectEnumerator];
    NSDictionary* item;
    int count = 0;
    self.returnP= [[NSMutableArray alloc]init];
    
    while (item = (NSDictionary*)[enumerator nextObject]) {
        
        p = [[LocationSe alloc]init];

        NSDictionary *citya=[item objectForKey:@"description"];
        p.city = [citya objectForKey:@"text"];
        [self.returnP addObject:p];
        count ++;
        
    
    }
    [self.tableviewLocation reloadData];

}
-(void)getCityDidFinishWithFailure:(NSDictionary*)responseObject{




}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - TableView Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableviewLocation) {
        
    //return tourlist.count;
    return self.returnP.count;
    }else
        return self.productsArray.count;
    
    
}
#pragma mark - TableView Delegate Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.tableviewLocation) {

    
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
    
    LocationSe * location = [[LocationSe alloc]init];
    location = [self.returnP objectAtIndex:indexPath.row];
    cell.textLabel.text =location.city;
    

    return cell;
    }else{
        static NSString *CellIdentifier = @"ProductCell";
        
        ProductCell *cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        Product *product = [self.productsArray objectAtIndex:[indexPath row]];
        
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
        cell.imgPromotion.hidden = YES;

        
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
}
- (void)viewDetail:(UIButton *)button
{
    Product *product = [self.returnP objectAtIndex:button.tag];
    self.myProduct = product;
    [self performSegueWithIdentifier:@"description" sender:product];
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableviewLocation) {
        return 70;

    }else
        return 150;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableviewLocation) {
        
    LocationSe * location = [[LocationSe alloc]init];
    location = [self.returnP objectAtIndex:indexPath.row];
    self.city = location.city;
    
    self.lblCity.text = location.city;
    self.tableviewLocation.hidden = YES;
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // cell.backgroundColor = [self colorWithHexString:@"4A706A"];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
}

-(void)back{

    self.tableviewLocation.hidden = YES;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back2) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;
}

- (IBAction)search:(id)sender {
    
    self.ConnectionDelegate.delegate=self;
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    
    [params setObject:self.city forKey:@"city"];
    
    [self.ConnectionDelegate searchPlace:params];
}
- (IBAction)closeEndDate:(id)sender {
    self.viewForDateEnd.hidden =YES;
    
}
- (IBAction)priceRange:(id)sender {
    
    
}
-(void)searchPlaceDidFinishSuccessfully:(NSDictionary*)responseObject{
    self.tableviewProducts.hidden =NO;
    NSArray *items = [responseObject valueForKeyPath:@"collection.vhsSpecialOffer"];
    NSLog(@"arraty %@",items);
    self.productsArray = [[NSMutableArray alloc]init];
    NSDictionary* item;
    NSLog(@"items count %lu",(unsigned long)items.count);
    if (items.count ==0) {
        self.viewSearchAgain.hidden = NO;
    }
    
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
        [self.productsArray addObject:prod];
        NSLog(@"description and endate %@ %@",description,endDate);
    }
    [self.tableviewProducts reloadData];



}
-(void)searchPlaceFinishWithFailure:(NSDictionary*)responseObject{



}

@end
