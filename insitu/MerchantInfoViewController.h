//
//  MerchantInfoViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 4/7/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MerchantInfoViewController;

@protocol MerchantInfoViewControllerDelegate
- (void)merchantInfoViewControllerDidFinish:(MerchantInfoViewController *)controller;
@end

@interface MerchantInfoViewController : UIViewController

@property (strong, nonatomic) id <MerchantInfoViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
