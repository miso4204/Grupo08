//
//  detailViewController.m
//  VHSMarketPlace
//
//  Created by Ivan Garcia on 4/2/15.
//  Copyright (c) 2015 TSFactory. All rights reserved.
//

#import "detailViewController.h"
//FlatUI
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "detailViewController.h"
@interface detailViewController (){

    NSMutableArray *markers;

}

@end

@implementation detailViewController
-(void)setProduct:(Product *)product
{
    if (_myProduct != product) {
        _myProduct = product;
        
        // Update the view.
        [self configureView];
    }
}
- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.myProduct) {
      //  self.txrdate.text = self.booking.year;
       // self.txtcode.text=self.booking.code;
        //self.txtplace.text=self.booking.name;
        //self.txtprice.text = self.booking.price;
        NSLog(@"product %@",self.myProduct.name);
        
        self.imgProduct.image= [self getImageFromURL:self.myProduct.image ];
        

        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblName.text = self.myProduct.name;
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(self.myProduct.latitude,	self.myProduct.longitude);
    GMSMarker *markerCC;
    
    markerCC = [GMSMarker markerWithPosition:position];
    
    markerCC.map = _googleMapView;
    
    markers = [[NSMutableArray alloc]init];
    [markers addObject:markerCC];
    
    self.title = @"Desctiption";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont boldFlatFontOfSize:18],
                                                                    UITextAttributeTextColor: [UIColor whiteColor]};
    
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorFromHexCode:@"#e75659"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;

    self.view1.backgroundColor =[UIColor colorFromHexCode:@"#e75659"];
    self.view2.backgroundColor =[UIColor colorFromHexCode:@"#e75659"];
    
    self.view3.backgroundColor =[UIColor colorFromHexCode:@"#e75659"];
    self.view5.backgroundColor =[UIColor colorFromHexCode:@"#e75659"];
    
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if ([version floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];  // For foreground access
        [self.locationManager requestAlwaysAuthorization];
        
 
        
    }
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager startUpdatingLocation];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // TODO: Add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
    
    // Check for iOS 8
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    // Google map
    
    // la 4.60971,-74.08175
    /////// GOOGLE MAP /////////
    
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-6.1453931
                                                            longitude:-65.47573599999998
                                                                 zoom:1];
    
    [_googleMapView animateToCameraPosition:camera];
    _googleMapView.myLocationEnabled = YES;
    _googleMapView.settings.myLocationButton = YES;
    _googleMapView.settings.rotateGestures = NO;
    _googleMapView.delegate = self;
    
    [_googleMapView.layer setCornerRadius:30.0f];
    _googleMapView.alpha = 0.9;
    
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"NO GPS");
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            NSLog(@"Authorization Status Not Determined");
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusRestricted){
            NSLog(@"Authorization Status Restricted");
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            NSLog(@"Authorization Status Denied");
            //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Permítanos conocer su ubicación" message:@"Habilite los servicios de ubicación y GPS en los Ajustes de su dispositivo para poder ofrecerle un mejor servicio" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //[alert setTag:kAlertInvalidCity];
            //[alert show];
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized){
            NSLog(@"Authorization Status Authorized");
        }
        
    }
    [self ShowAllMarkers];

    // Do any additional setup after loading the view.
}
- (void)ShowAllMarkers
{
    
    CLLocationCoordinate2D firstLocation = ((GMSMarker *)markers.firstObject).position;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:firstLocation coordinate:firstLocation];
    
    for (GMSMarker *marker in markers) {
        bounds = [bounds includingCoordinate:marker.position];
        
        
    }

        [_googleMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:10.0f]];
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
    [self loadMap];



}

-(void)loadMap{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy= kCLLocationAccuracyBest; //NearestTenMeters;
    [self.locationManager startUpdatingLocation];
    GMSCameraPosition *camera;
    
    /////// GOOGLE MAP /////////
    /*
     GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:4.59837
     longitude:-74.075925
     zoom:5];
     */
    
    NSLog(@"LOCATON %.2F %.2F",self.locationManager.location.coordinate.latitude,self.locationManager.location.coordinate.longitude);
    /*
    if (self.locationManager.location.coordinate.latitude == 0.00 && self.locationManager.location.coordinate.longitude ==0.00) {
        
        camera = [GMSCameraPosition cameraWithLatitude:4.59837
                                             longitude:-74.075925
                                                  zoom:10];
        
        
    }else{
        camera = [GMSCameraPosition cameraWithLatitude:self.locationManager.location.coordinate.latitude
                                             longitude:self.locationManager.location.coordinate.longitude
                                                  zoom:12.5];
        
        
        
    }
    */
    // maybe here is the error with google maps
    @try {
        //googleMapView = [GMSMapView mapWithFrame:mapFrame camera:camera];
        
        [_googleMapView animateToCameraPosition:camera];
        //  [googleMapView setCamera:camera];
        
        
    }
    @catch (NSException *exception) {
        // Log a handled exception to Crittercism
    }
    @finally {
    }
    
    //googleMapViewInternal = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _googleMapView.delegate = self;
    
    _googleMapView.myLocationEnabled = YES;
    _googleMapView.settings.rotateGestures = NO;
    
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"ENTROOOOOOOOOOOOOOOOOOOOOOOOOO");
    _googleMapView.mapType = kGMSTypeNormal;
    _googleMapView.settings.zoomGestures = YES;
    _googleMapView.settings.scrollGestures = YES;
    
    if (newLocation.horizontalAccuracy < 0) return;
    
    if (oldLocation == nil || oldLocation.horizontalAccuracy >= newLocation.horizontalAccuracy) {
        /*
        CLLocationCoordinate2D location;
        
        location.latitude = newLocation.coordinate.latitude;
        location.longitude = newLocation.coordinate.longitude;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:1.0f];
        [_googleMapView animateToZoom:17];
        [_googleMapView animateToLocation:location];
        //[googleMapViewInternal animateToCameraPosition:bogota];
        [CATransaction commit];
        */
        //    mapView.showsUserLocation = YES;
        //    [mapView setUserTrackingMode:MKUserTrackingModeFollow animated:TRUE];
        //    [mapView.userTrackingMode animated:YES];
        
        
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                NSString   *test = [placemark country];
                
                NSLog(@"ACTual Country%@", test);
                
            }
        }];
        
        [self.locationManager stopUpdatingLocation];
        
        
    }
}

- (void)refreshMap {
    NSLog(@"Updating Location");
    [self.locationManager startUpdatingLocation];
}
-(void)back{
    //   [self performSegueWithIdentifier:@"back" sender:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}
@end
