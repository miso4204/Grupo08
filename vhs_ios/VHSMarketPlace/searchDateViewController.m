//
//  searchDateViewController.m
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/2/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "searchDateViewController.h"
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

@interface searchDateViewController (){
    Product * prod;

}
@property (strong, nonatomic)   Connections *ConnectionDelegate;

@end
@implementation searchDateViewController
@synthesize dateFinal;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewSearchAgain.hidden = YES;

    // Do any additional setup after loading the view.
    self.tableviewProducts.hidden = YES;
    self.title = @"Search";
        [self.tableviewProducts registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];

    self.ConnectionDelegate = [[Connections alloc]init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
    
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
    
    
    
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    //   NSDate *yesterday = [cal dateByAddingComponents:components toDate: today options:0];
    
    components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
    
    [components setDay:([components day] - ([components weekday] - 1))];
    // NSDate *thisWeek  = [cal dateFromComponents:components];
    
    [components setDay:([components day] + 10)];
    NSDate *nextWeek  = [cal dateFromComponents:components];
    
    [components setDay:([components day] - ([components day] -1))];
    // NSDate *thisMonth = [cal dateFromComponents:components];
    
    [components setMonth:([components month] - 1)];
    // NSDate *lastMonth = [cal dateFromComponents:components];

    [self.btnDate setStyle:BButtonStyleBootstrapV3];
    [self.btnDate setType:BButtonTypePrimary];
    
    [self.btnFilter setStyle:BButtonStyleBootstrapV3];
    [self.btnFilter setType:BButtonTypePrimary];
    
    [self.btnTryAgain setStyle:BButtonStyleBootstrapV3];
    [self.btnTryAgain setType:BButtonTypePrimary];
    
    
    self.viewPicker.hidden = YES;
    
    
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

- (IBAction)close:(id)sender {
    
    self.viewPicker.hidden = YES;
    
}

- (IBAction)setDate:(id)sender {
    self.viewPicker.hidden = NO;
}

- (IBAction)search:(id)sender {
    self.ConnectionDelegate.delegate = self;
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    
    [params setObject:self.dateFinal forKey:@"date"];

    [self.ConnectionDelegate searchDate:params];
        self.tableviewProducts.hidden = NO;
   
}

- (IBAction)getDate:(id)sender {
    // [self getPrices:@"2014317" :@"7"];
    NSDate *chosen = [self.picker date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    
    [timeFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSString *newTime = [timeFormatter stringFromDate:chosen ];
    
    NSArray * timer= [self getDataOfQueryString:newTime andseparator:@"T"];
    
    NSString * date = timer[0];
    NSString * time = timer[1];
    
    NSString *truncatedString = [time substringToIndex:[time length]-7];
    NSLog(@"FECHA4 %@",truncatedString);
    
    
    NSArray * CompleteDate= [self getDataOfQueryString:date andseparator:@"-"];
    NSString * year=CompleteDate[0];
    NSString * month=CompleteDate[1];
    NSString * day =CompleteDate[2];
    
    self.dateFinal = [NSString stringWithFormat:@"%@%@%@",day,month,year];
    
    
    
    
    NSLog(@"year, month, day %@",self.dateFinal);
}
-(void)back{
    //   [self performSegueWithIdentifier:@"back" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(NSArray *)getDataOfQueryString:(NSString *)url andseparator:(NSString *)separator{
    
    
    
    
    
    NSArray *strURLParse = [url componentsSeparatedByString:separator];
    
    NSLog(@"parse %@",[strURLParse objectAtIndex:0]);
    
    
    
    return strURLParse;
    
}

-(void)searchDateDidFinishSuccessfully:(NSDictionary*)responseObject{
    NSArray *items = [responseObject valueForKeyPath:@"collection.vhsSpecialOffer"];
    NSLog(@"arraty %@",items);
    self.returnP = [[NSMutableArray alloc]init];
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
        [self.returnP addObject:prod];
        NSLog(@"description and endate %@ %@",description,endDate);
    }
    

    [self.tableviewProducts reloadData];
   
}
-(void)searchDateFinishWithFailure:(NSDictionary*)responseObject{
    
   
    self.viewSearchAgain.hidden = NO;


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
