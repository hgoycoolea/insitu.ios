//
//  MainViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 3/26/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//
#import "MainViewController.h"
#include "SatelliteHelper.h"

@interface MainViewController ()
/// propertie de las imagenes de cada mercante
@property (strong,nonatomic) NSMutableArray* avatarList;
/// id de cada uno de los mercantes
@property (strong,nonatomic) NSMutableArray* idsList;
/// imagen del home de cada
@property (strong,nonatomic) NSMutableArray* homeList;

@property (strong,nonatomic) NSMutableArray *vistas;

@property (strong, nonatomic) IBOutlet UIImageView *barra_top;
@property (strong, nonatomic) IBOutlet UIImageView *barra_down;
@end


@implementation MainViewController

@synthesize locationManager;
@synthesize refreshControl;
@synthesize jsonObjects;
@synthesize pageControl;
@synthesize ui_slides;
@synthesize barra_down, barra_top;
/*
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Do the work associated with the task, preferably in chunks.
        NSTimer* t = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(InitializeCLControler) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
    
    [self downloadMercantesMembresiasPagadas];
    // Call changePage each time value of pageControl changes
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedUpButton:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedDownButton:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeDown];

}

- (IBAction)infoForMechant:(id)sender{
    
}

- (IBAction)tappedUpButton:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.7f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionFade;
    
    [barra_top.layer addAnimation:transition forKey:nil];
    [barra_down.layer addAnimation:transition forKey:nil];
    
    barra_top.hidden = YES;
    barra_down.hidden = YES;
}

- (IBAction)tappedDownButton:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.7f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    
    [barra_top.layer addAnimation:transition forKey:nil];
    [barra_down.layer addAnimation:transition forKey:nil];
    
    barra_top.hidden = NO;
    barra_down.hidden = NO;
}

- (IBAction)tappedRightButton:(id)sender
{
    int pageToGo = [self.pageControl currentPage] - 1;
    if(pageToGo>=0){
        
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        transition.type = kCATransitionFade;
        
        [self.ui_slides.layer addAnimation:transition forKey:nil];
        
        self.ui_slides.image =[self.vistas objectAtIndex:pageToGo];
        self.pageControl.currentPage = pageToGo;
        
        /// NSUserDefaults
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        /// card holder number
        [prefs setObject:[self.idsList objectAtIndex:pageToGo] forKey:@"id_merchant_selected"];
        /// we syncrho the preferences
        [prefs synchronize];

    }
}

- (IBAction)tappedLeftButton:(id)sender
{
    int pageToGo = [self.pageControl currentPage] + 1;
    if(pageToGo>=0){
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        transition.type = kCATransitionFade;
        
        [self.ui_slides.layer addAnimation:transition forKey:nil];
        
        self.ui_slides.image =[self.vistas objectAtIndex:pageToGo];
        self.pageControl.currentPage = pageToGo;
        
        /// NSUserDefaults
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        /// card holder number
        [prefs setObject:[self.idsList objectAtIndex:pageToGo] forKey:@"id_merchant_selected"];
        /// we syncrho the preferences
        [prefs synchronize];
    }
}

- (IBAction) changePage:(id)sender {
    self.ui_slides.image =[self.vistas objectAtIndex:[self.pageControl currentPage]];
}


- (void)downloadMercantesMembresiasPagadas {
    // make up some test data
    self.avatarList = [NSMutableArray arrayWithCapacity:1];
    self.idsList = [NSMutableArray arrayWithCapacity:1];
    self.homeList = [NSMutableArray arrayWithCapacity:1];
    // Set up the views array with 3 UIImageViews
    self.vistas = [NSMutableArray arrayWithCapacity:1];
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// this will show me the response
    NSString *response = [helper readMercantesPorMembresias:@"1,2,3"];
    /// let's configure the data
    NSData* data=[response dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error = nil;
    /// now we get an array of the all json file
    jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    int count = 0;
    /// let's loop foreach on the statement
    for(NSDictionary *keys in jsonObjects){
        NSString *_id = [keys objectForKey:@"ID"];
        NSString *avatar = [keys objectForKey:@"UrlImageLogo"];
        NSString *img_home = [keys objectForKey:@"UrlImageHome"];
        
        /// let's make a circle of the avatar for the company
        UIImage *imagesHome = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img_home]]];
        if(imagesHome!=nil){
            /// we add the promotion
            [self.avatarList addObject:avatar];
            [self.idsList addObject:_id];
            [self.homeList addObject:img_home];
            [self.vistas addObject:imagesHome];
            count++;
        }
    }
    /// first image load
    self.ui_slides.image =[self.vistas objectAtIndex:0];
    /// we set the pages with the images that we have
    self.pageControl.numberOfPages = count;
    self.pageControl.currentPage = 0;
    /// NSUserDefaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    /// card holder number
    [prefs setObject:[self.idsList objectAtIndex:0] forKey:@"id_merchant_selected"];
    /// we syncrho the preferences
    [prefs synchronize];

    /// response to the log
    NSLog(@"%@",response);
}
/*
 *
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Flipside View
/*
 *
 */
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
 *
 */
- (void)menuViewControllerDidFinish:(MenuViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
 *
 */
- (void)wallViewControllerDidFinish:(WallViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
///
- (void)merchantInfoViewControllerDidFinish:(MerchantInfoViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
 *
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}
/*
 * InitializeCLControler
 *
 * Method that initializes the Core Location Controller
 */
-(void) InitializeCLControler
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}
/*
 *
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if([locationManager.delegate conformsToProtocol:@protocol(CLLocationManagerDelegate)]) {  // Check if the class assigning itself as the delegate conforms to our protocol.  If not, the message will go nowhere.  Not good.
		[self locationUpdate:newLocation];
	}
}
/*
 *
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	if([locationManager.delegate conformsToProtocol:@protocol(CLLocationManagerDelegate)]) {  // Check if the class assigning itself as the delegate conforms to our protocol.  If not, the message will go nowhere.  Not good.
		//[self locationError:error];
	}
}
/*
 *
 */
- (void)locationUpdate:(CLLocation *)location {
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    // we set the errro to manager
    self.locationManager.distanceFilter = 50.0f;
    /// we set the acuracy
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    /// we delegate them to self
    self.locationManager.delegate = self;
    /// first we get the location Manager location
    CLLocation *ulocation = [locationManager location];
    /// we now get the coordinates
    CLLocationCoordinate2D userCoordinate = ulocation.coordinate;
    /// we now get users speed
    NSString *speed = [NSString stringWithFormat:@"%f", [location speed]];
    /// x coordinate
    NSString *lat = [[NSString alloc]initWithFormat:@"%f", userCoordinate.latitude];
    /// y coordinate
    NSString *lon = [[NSString alloc ]initWithFormat:@"%f", userCoordinate.longitude ];
    /// altitude
    NSString *alt = [NSString stringWithFormat:@"%f", [location altitude]];
    /// client
    NSString *client = @"1";
    /// this will show me the response
    NSString *response = [helper acknowledgeRutas:lat Longitude:lon Speed:speed Altitude:alt Client:client];
    /// response to the log
    NSLog(@"%@",response);
}
@end
