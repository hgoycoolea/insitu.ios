//
//  MainViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 3/26/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "FlipsideViewController.h"
#import "PCollectionViewLayout.h"
#import "PCollectionCellBackgroundView.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,CLLocationManagerDelegate,UICollectionViewDelegateJSPintLayout,UICollectionViewDelegate,UICollectionViewDataSource>{
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
#pragma mark - id jsonObjects
@property (nonatomic, retain) IBOutlet id jsonObjects;
@end
