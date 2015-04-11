//
//  InitialViewController.h
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/9/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "detailViewController.h"
#import "BButton.h"

@interface InitialViewController : UIViewController
@property (strong, nonatomic) IBOutlet BButton *btnlogin;
@property (strong, nonatomic) IBOutlet BButton *btnregister;


@end
