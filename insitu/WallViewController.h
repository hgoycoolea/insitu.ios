//
//  WallViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 4/5/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"
#import "PCollectionViewLayout.h"
#import "PCollectionCellBackgroundView.h"

@class WallViewController;

@protocol WallViewControllerDelegate
- (void)wallViewControllerDidFinish:(WallViewController *)controller;
@end

@interface WallViewController : UIViewController<CLLocationManagerDelegate,UICollectionViewDelegateJSPintLayout,UICollectionViewDelegate,UICollectionViewDataSource, FlipsideViewControllerDelegate>{
    // Signature Drawing Items
    CGPoint lastPoint;
#pragma mark - UIRefreshControl
    /// refreshControl
    UIRefreshControl *refreshControl;
#pragma mark - CLLocationManager
    //// Location Manager Controller
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) id <WallViewControllerDelegate> delegate;
#pragma mark - UIRefreshControl
@property (nonatomic, retain) IBOutlet UIRefreshControl *refreshControl;
#pragma mark - id jsonObjects
@property (nonatomic, retain) IBOutlet id jsonObjects;
#pragma mark - CLLocationManager
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;

- (IBAction)done:(id)sender;

@end
