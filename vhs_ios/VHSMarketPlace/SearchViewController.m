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
@interface SearchViewController (){

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

    
    NSArray *items = [responseObject valueForKeyPath:@"collection.vhsCity"];

    NSEnumerator *enumerator = [items objectEnumerator];
    NSDictionary* item;
    int count = 0;
    self.returnP= [[NSMutableArray alloc]init];
    
    while (item = (NSDictionary*)[enumerator nextObject]) {
        
        p = [[LocationSe alloc]init];

        NSDictionary *citya=[item objectForKey:@"description"];
        p.city = [citya objectForKey:@"text"];
        NSLog(@"all cities %@",p.city);
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
    
    //return tourlist.count;
    return self.returnP.count;
    
    
}
#pragma mark - TableView Delegate Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
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
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LocationSe * location = [[LocationSe alloc]init];
    location = [self.returnP objectAtIndex:indexPath.row];
    self.city = location.city;
    
    self.lblCity.text = location.city;
    self.tableviewLocation.hidden = YES;
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



}
-(void)searchPlaceFinishWithFailure:(NSDictionary*)responseObject{



}

@end
