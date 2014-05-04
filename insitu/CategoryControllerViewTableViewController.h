//
//  CategoryControllerViewTableViewController.h
//  insitu
//
//  Created by Hector Goycoolea on 17-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryControllerViewTableViewController;

@protocol CategoryViewControllerDelegate
- (void)categoryViewControllerDidFinish:(CategoryControllerViewTableViewController *)controller;
@end

@interface CategoryControllerViewTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    
}

@property (strong, nonatomic) id <CategoryViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
