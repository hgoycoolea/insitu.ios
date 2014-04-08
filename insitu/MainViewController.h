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
#import "MerchantInfoViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,WallViewControllerDelegate,MenuViewControllerDelegate, MerchantInfoViewControllerDelegate,CLLocationManagerDelegate>{
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
    
    UIPageControl *pageControl;
    
    BOOL pageControlBeingUsed;
}
#pragma mark - CLLocationManager
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;
#pragma mark - UIRefreshControl
@property (nonatomic, retain) IBOutlet UIRefreshControl *refreshControl;
#pragma mark - id jsonObjects
@property (nonatomic, retain) IBOutlet id jsonObjects;

@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UIImageView *ui_slides;

- (IBAction) changePage:(id)sender ;
@end
