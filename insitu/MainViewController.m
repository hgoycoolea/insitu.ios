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

@end


@implementation MainViewController

@synthesize locationManager;
@synthesize refreshControl;
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
