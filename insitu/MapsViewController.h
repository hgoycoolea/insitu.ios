//
//  MapViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 13-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapsViewController;

@protocol MapsViewControllerDelegate
- (void)mapsViewControllerDidFinish:(MapsViewController *)controller;
@end

@interface MapsViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) id <MapsViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
@end
