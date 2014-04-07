//
//  MainViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 3/26/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "FlipsideViewController.h"
#import "MenuViewController.h"
#import "WallViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,WallViewControllerDelegate,MenuViewControllerDelegate,CLLocationManagerDelegate>{
    //Signature Drawing Items
    CGPoint lastPoint;
    //
    // CLLocationManager
    //
    #pragma mark - CLLocationManager
    //// Location Manager Controller
    CLLocationManager *locationManager;
#pragma mark - UIRefreshControl
    UIRefreshControl *refreshControl;
}
#pragma mark - CLLocationManager
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;
#pragma mark - UIRefreshControl
@property (nonatomic, retain) IBOutlet UIRefreshControl *refreshControl;

@end
