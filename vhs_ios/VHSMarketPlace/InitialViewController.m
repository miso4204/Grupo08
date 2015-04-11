//
//  InitialViewController.m
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/9/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnlogin setStyle:BButtonStyleBootstrapV3];
    [self.btnlogin setType:BButtonTypeWarning];
    
    [self.btnregister setStyle:BButtonStyleBootstrapV3];
    [self.btnregister setType:BButtonTypeWarning];
    
    self.title = @"Bienvenido";
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

@end
