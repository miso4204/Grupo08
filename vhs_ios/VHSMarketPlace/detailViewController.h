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

@interface detailViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate,KASlideShowDelegate>


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



- (IBAction)next:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)previous:(id)sender;

@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@end
