//
//  detailViewController.h
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/2/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import <GoogleMaps/GoogleMaps.h>
#import "KASlideShow.h"
#import "BButton.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>

@interface detailViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate,KASlideShowDelegate,UITabBarControllerDelegate,UITabBarDelegate>{

    SLComposeViewController *mySLComposerSheet;

}


@property (strong, nonatomic)   Product *myProduct;

@property (nonatomic, retain) IBOutlet GMSMapView *googleMapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

-(void)setProduct:(Product *)product;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view5;
@property (strong, nonatomic) IBOutlet UIImageView *imgProduct;

@property (weak, nonatomic) IBOutlet BButton *btnAddtoCart;

- (IBAction)addToCart:(id)sender;

- (IBAction)next:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)previous:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)selectSection:(id)sender;

@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet BButton *btnVideo;
- (IBAction)ViewVideo:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet BButton *btnClose;
- (IBAction)closeVideo:(id)sender;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *itemDescription;
@property (weak, nonatomic) IBOutlet UITabBarItem *itemMore;
@property (weak, nonatomic) IBOutlet UITableView *tableviewAdditionalVaues;

@property (weak, nonatomic) IBOutlet UIView *viewForVideo;

@property (weak, nonatomic) IBOutlet UIView *viewDescription;
@property (weak, nonatomic) IBOutlet UIView *viewOther;


@end
