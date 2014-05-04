//
//  SearchViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 27-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchViewController;

@protocol SearchViewControllerDelegate
- (void)searchViewControllerDidFinish:(SearchViewController *)controller;
@end

@interface SearchViewController : UIViewController<CLLocationManagerDelegate,UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>{
    //// Location Manager Controller
    CLLocationManager *locationManager;
}
#pragma mark - CLLocationManager
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;

@property (strong, nonatomic) id <SearchViewControllerDelegate> delegate;
@end
