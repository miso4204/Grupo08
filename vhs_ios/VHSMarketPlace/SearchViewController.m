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
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewForDate.layer.cornerRadius = 10.0f;
    self.viewForDate.layer.masksToBounds = YES;
    
    self.viewForDate.backgroundColor = [UIColor lightGrayColor];
    
    self.viewForDate.hidden = YES;
    self.title = @"Search";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    
    
    [self.btnBeginDate setStyle:BButtonStyleBootstrapV3];
    [self.btnBeginDate setType:BButtonTypeFacebook];
    
    [self.btnEndDate setStyle:BButtonStyleBootstrapV3];
    [self.btnEndDate setType:BButtonTypeFacebook];
    

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
}

- (IBAction)setBeginDate:(id)sender {
    self.viewForDate.hidden = NO;
}

- (IBAction)setEndDate:(id)sender {
    self.viewForDate.hidden = NO;
}
- (IBAction)close:(id)sender {
    self.viewForDate.hidden = YES;
}
@end
