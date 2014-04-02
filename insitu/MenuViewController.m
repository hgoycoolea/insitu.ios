//
//  MenuViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 4/1/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate menuViewControllerDidFinish:self];
}

@end
