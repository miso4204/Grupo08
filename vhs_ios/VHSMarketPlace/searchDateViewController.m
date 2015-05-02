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
@interface searchDateViewController ()
@property (strong, nonatomic)   Connections *ConnectionDelegate;

@end
@implementation searchDateViewController
@synthesize dateFinal;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Search";
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


}
-(void)searchDateFinishWithFailure:(NSDictionary*)responseObject{


}


@end
