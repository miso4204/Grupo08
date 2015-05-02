//
//  menuSearchViewController.m
//  VHSMarketPlace
//
//  Created by Ivan F Garcia S on 5/2/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "menuSearchViewController.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "detailViewController.h"
#import "LocationSe.h"
@interface menuSearchViewController ()

@end

@implementation menuSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.btnDate setStyle:BButtonStyleBootstrapV3];
    [self.btnDate setType:BButtonTypeFacebook];
    
    [self.btnPlace setStyle:BButtonStyleBootstrapV3];
    [self.btnPlace setType:BButtonTypeFacebook];
    
    [self.btnPrice setStyle:BButtonStyleBootstrapV3];
    [self.btnPrice setType:BButtonTypeFacebook];
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];

    
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

- (IBAction)searchDate:(id)sender {
    [self performSegueWithIdentifier:@"date" sender:self];

}

- (IBAction)searchPrice:(id)sender {
    [self performSegueWithIdentifier:@"price" sender:self];

}

- (IBAction)searchPlace:(id)sender {
    [self performSegueWithIdentifier:@"place" sender:self];
}
@end
