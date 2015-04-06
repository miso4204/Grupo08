//
//  CatalogViewController.m
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/4/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "CatalogViewController.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "Product.h"
#import "Category.h"
@interface CatalogViewController ()

@end

@implementation CatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Catalog";
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
-(void)viewDidAppear:(BOOL)animated{
    
    self.returnP= [[NSMutableArray alloc]init];
    
    
    
    [self loadCatalog];
    
    
}

-(void)loadCatalog{

self.returnP =  [Categoryc listcategories];
    
    [self.collections reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.returnP.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    // recipeImageView.image = [UIImage imageNamed:[fieldImages objectAtIndex:indexPath.row]];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    Categoryc *p = [[Categoryc alloc]init];
    
    
    p = [self.returnP objectAtIndex:indexPath.row];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
   // recipeImageView.alpha = 0.2;

    
    NSURL* url = [NSURL URLWithString:p.image];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   
                                   UIImage * image = [UIImage imageWithData:data];
                                   recipeImageView.image = image;
                               }
                               
                           }];
    
    UILabel *labelName = (UILabel *)[cell viewWithTag:200];
    labelName.text = p.name;
    

    
    return cell;
}



@end
