//
//  AppDelegate.m
//  insitu
//
//  Created by Hector Goycoolea on 3/26/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "AppDelegate.h"
#include "SatelliteHelper.h"


@implementation AppDelegate

@synthesize locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    __block UIBackgroundTaskIdentifier bgTask = 0;

    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Do the work associated with the task, preferably in chunks.
        NSTimer* t = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(InitializeCLControler) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    });

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
