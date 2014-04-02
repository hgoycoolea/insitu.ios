//
//  MenuViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 4/1/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate
- (void)menuViewControllerDidFinish:(MenuViewController *)controller;
@end

@interface MenuViewController : UIViewController

@property (strong, nonatomic) id <MenuViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
