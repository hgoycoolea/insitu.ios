//
//  MerchantInfoViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 4/7/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCollectionViewLayout.h"
#import "PCollectionCellBackgroundView.h"

@class MerchantInfoViewController;

@protocol MerchantInfoViewControllerDelegate
- (void)merchantInfoViewControllerDidFinish:(MerchantInfoViewController *)controller;
@end

@interface MerchantInfoViewController : UIViewController<CLLocationManagerDelegate,UICollectionViewDelegateJSPintLayout,UICollectionViewDelegate,UICollectionViewDataSource>{
#pragma mark - UIRefreshControl
    /// refreshControl
    UIRefreshControl *refreshControl;
#pragma mark - CLLocationManager
    //// Location Manager Controller
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) id <MerchantInfoViewControllerDelegate> delegate;
#pragma mark - id jsonObjects
@property (nonatomic, retain) IBOutlet id jsonObjects;
#pragma mark - UIRefreshControl
@property (nonatomic, retain) IBOutlet UIRefreshControl *refreshControl;
#pragma mark - CLLocationManager
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;
- (IBAction)done:(id)sender;

@end
