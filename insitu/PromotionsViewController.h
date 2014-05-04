//
//  PromotionsViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 19-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryControllerViewTableViewController.h"
#import "PCollectionViewLayout.h"
#import "PCollectionCellBackgroundView.h"

@class PromotionsViewController;

@protocol PromotionsViewControllerDelegate
- (void)promotionsViewControllerDidFinish:(PromotionsViewController *)controller;
@end

@interface PromotionsViewController : UIViewController<CLLocationManagerDelegate,UICollectionViewDelegateJSPintLayout,UICollectionViewDelegate,UICollectionViewDataSource, CategoryViewControllerDelegate>{
    // Signature Drawing Items
    CGPoint lastPoint;
#pragma mark - UIRefreshControl
    /// refreshControl
    UIRefreshControl *refreshControl;
#pragma mark - CLLocationManager
    //// Location Manager Controller
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) id <PromotionsViewControllerDelegate> delegate;
#pragma mark - UIRefreshControl
@property (nonatomic, retain) IBOutlet UIRefreshControl *refreshControl;
#pragma mark - id jsonObjects
@property (nonatomic, retain) IBOutlet id jsonObjects;
#pragma mark - CLLocationManager
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;

- (IBAction)done:(id)sender;

@end
