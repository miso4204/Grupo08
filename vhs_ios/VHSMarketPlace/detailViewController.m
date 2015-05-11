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
#import "AppDelegate.h"
@interface detailViewController (){

    NSMutableArray *markers;

}
@property (nonatomic, strong) Connections *APIConnection;

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
 
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableviewAdditionalVaues.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.APIConnection = [[Connections alloc]init];
    self.viewDescription.hidden =NO;
    self.viewOther.hidden=YES;
    [self.btnAddtoCart setStyle:BButtonStyleBootstrapV3];
    [self.btnAddtoCart setType:BButtonTypeWarning];
    
    [self.btnVideo setStyle:BButtonStyleBootstrapV3];
    [self.btnVideo setType:BButtonTypeWarning];
    
    [self.btnClose setStyle:BButtonStyleBootstrapV3];
    [self.btnClose setType:BButtonTypeDanger];
    
    
    self.btnClose.hidden = YES;
    self.webView.hidden = YES;

    _slideshow.delegate = self;
    [_slideshow setDelay:1]; // Delay between transitions
    [_slideshow setTransitionDuration:.5]; // Transition duration
    [_slideshow setTransitionType:KASlideShowTransitionFade]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
 //   [_slideshow addImagesFromResources:@[@"hote1@2x.jpeg",@"hote2@2x.jpeg",@"hote3@2x.jpeg",@"hote4@2x.jpeg"]]; // Add images from resources
    NSURL* url = [NSURL URLWithString:self.myProduct.image];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   
                                   UIImage * image = [UIImage imageWithData:data];
                                   [_slideshow addImage:image];

                               }
                               
                           }];

    
    [_slideshow addGesture:KASlideShowGestureTap]; // Gesture to go previous/next directly on the image
    
    _slideshow.gestureRecognizers = nil;
    [_slideshow addGesture:KASlideShowGestureSwipe];

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
    
    self.lblDescription.text = self.myProduct.descriptions;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setImage:[UIImage imageNamed:@"flechablanca@2x.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc] init];
    [barButton setCustomView:button];
    self.navigationItem.leftBarButtonItem=barButton;
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 32, 32);
    [button2 setImage:[UIImage imageNamed:@"share@2x.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(shareSocial) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton2=[[UIBarButtonItem alloc] init];
    [barButton2 setCustomView:button2];
    self.navigationItem.rightBarButtonItem=barButton2;

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

        [_googleMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:100.0f]];
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
   // [self loadMap];



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

#pragma mark - KASlideShow delegate

- (void)kaSlideShowWillShowNext:(KASlideShow *)slideShow
{
    NSLog(@"kaSlideShowWillShowNext, index : %@",@(slideShow.currentIndex));
    
    
    
}

- (void)kaSlideShowWillShowPrevious:(KASlideShow *)slideShow
{
    NSLog(@"kaSlideShowWillShowPrevious, index : %@",@(slideShow.currentIndex));
    
    
}

- (void) kaSlideShowDidShowNext:(KASlideShow *)slideShow
{
    NSLog(@"kaSlideShowDidNext, index : %@",@(slideShow.currentIndex));
}

-(void)kaSlideShowDidShowPrevious:(KASlideShow *)slideShow
{
    NSLog(@"kaSlideShowDidPrevious, index : %@",@(slideShow.currentIndex));
}


- (IBAction)addToCart:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.shoppingCart addObject:self.myProduct];
    
    NSLog(@"self my product %d",self.myProduct.id);
    
    NSString *size = [NSString stringWithFormat:@"%lu",(unsigned long)[appDelegate.shoppingCart count]];
    

    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:1] setBadgeValue:size];
    

    
    [self showAlert];
}
-(void)showAlert{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Éxito" message:@"Este producto se ha agregado exitosamente al carrito de compras"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];




}
-(void)facebook{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
        NSString *shareMessage = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %f",@"Mira este increíble plan turístico" ,self.myProduct.name,@"que oferce:",self.myProduct.descriptions,@"con un costo de:",self.myProduct.price];
        
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:shareMessage,mySLComposerSheet.serviceType]]; //the message you want to post
        [mySLComposerSheet addImage:[UIImage imageNamed:@"76x76.png"]]; //an image you could post
        //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                break;
            default:
                break;
        } //check if everything worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
    
}
- (void)tweet {  //!!JCS.25sep2012.Move this to MVC?
    //[SHKTwitter shareImage:pic.image title:@"Emoji Message"];
   NSString *msg = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %f",@"Mira este increíble plan turístico" ,self.myProduct.name,@"que oferce:",self.myProduct.descriptions,@"con un costo de:",self.myProduct.price];
    

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:msg];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
-(void)shareSocial{

    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Redes Sociales", nil)
                                         message:NSLocalizedString(@"Selecciona la red social en donde quieres compartir la oferta", nil)
                                        delegate:self
                               cancelButtonTitle:NSLocalizedString(@"Cancelar", nil)
                               otherButtonTitles:@"Facebook", @"Twitter",nil]; //!!JCS.8aug2012.Agregar FB
    [alert setTag:1];
    [alert show];


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1){
    
        switch (buttonIndex) {
            case 0:
                //Do nothing, cancelled;
                break;
            case 1:{
                [self facebook];
                
            break;
                
            }
            case 2:{
                [self tweet];
                break;
            }
    
        }
   }
}
- (IBAction)ViewVideo:(id)sender {
    self.btnClose.hidden = NO;
    self.webView.hidden = NO;

    


    [self.webView setAllowsInlineMediaPlayback:YES];
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    
    [self.view addSubview:self.webView];
    NSString * video = @"8kUU-DWOqmI";
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                           <script type='text/javascript'>\
                           function onYouTubeIframeAPIReady()\
                           {\
                           ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady(a)\
                           { \
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                           </body>\
                           </html>", 300, 200, video];
    [self.webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
}
- (IBAction)closeVideo:(id)sender {
    self.btnClose.hidden = YES;
    self.webView.hidden = YES;
}

- (IBAction)selectSection:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;

    if (selectedSegment == 0) {
    // Description view
        self.viewDescription.hidden =NO;
        self.viewOther.hidden=YES;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.viewDescription cache:YES];
        [UIView commitAnimations];
        
     
        
    }else{
    //More services View
        self.viewDescription.hidden =YES;
        self.viewOther.hidden=NO;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.viewOther cache:YES];
        [UIView commitAnimations];
        
        self.APIConnection.delegate = self;
        
        NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
        NSString *strFromInt = [NSString stringWithFormat:@"%d",self.myProduct.id];

        [params setObject:strFromInt forKey:@"idproduct"];
        [self.APIConnection getAdditionalValues: params];
        
    }
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - TableView Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //return tourlist.count;
    return self.returnP.count;
    
    
}
#pragma mark - TableView Delegate Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //NSString * cellString;
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
    }
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    cell.textLabel.text = @"Cannopy";
    
    cell.detailTextLabel.text = @"Atrévete al mejor canoppy de la ciudad";
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imgView2.image = [UIImage imageNamed:@"travel@2x.png"];
    cell.imageView.image = imgView2.image;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // cell.backgroundColor = [self colorWithHexString:@"4A706A"];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
}
-(void)getAdditionalValuesDidFinishSuccessfully:(NSDictionary*)responseObject{
    self.returnP = [[NSMutableArray alloc]init];
    
    NSLog(@"additional values %@",responseObject);

}
-(void)getAdditionalValuesDidFinishWithFailure:(NSDictionary*)responseObject{


}


@end
