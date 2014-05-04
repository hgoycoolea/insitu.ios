//
//  AppDelegate.h
//  insitu
//
//  Created by Hector Goycoolea on 3/26/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>{
    //Signature Drawing Items
    CGPoint lastPoint;
    //
    // CLLocationManager
    //
#pragma mark - CLLocationManager
    //// Location Manager Controller
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *myViewController;
#pragma mark - CLLocationManager
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;
@end
