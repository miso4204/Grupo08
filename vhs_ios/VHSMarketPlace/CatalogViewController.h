//
//  CatalogViewController.h
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/4/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *returnP;
@property (strong, nonatomic) IBOutlet UICollectionView *collections;
@end
