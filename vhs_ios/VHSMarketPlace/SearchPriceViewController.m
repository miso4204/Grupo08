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
@interface SearchPriceViewController ()
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



}
-(void)searchPriceFinishWithFailure:(NSDictionary*)responseObject{


}

@end
