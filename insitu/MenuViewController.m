//
//  MenuViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 4/1/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (nonatomic, strong) IBOutlet UILabel *nombre_social;
@property (nonatomic, strong) IBOutlet UIImageView *img_user;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadUserInfo];
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

#pragma mark - Flipside View
/*
 *
 */
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
 *
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

/**/
-(void) loadUserInfo
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *screen_name = [prefs objectForKey:@"screen_name"];
    NSString *name = [prefs objectForKey:@"name"];
    NSString *profile_image_url = [prefs objectForKey:@"profile_image_url"];
    
    if(screen_name!=nil){
        
        [self.nombre_social setText:name];
        //[self.usuario_social setText:screen_name];
        /// let's make a circle of the avatar for the company
        [self.img_user initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profile_image_url]]] ];
        //imageViewAvatar.layer.cornerRadius = 8.f;
        self.img_user.layer.cornerRadius = 36;
        self.img_user.clipsToBounds = YES;
        self.img_user.layer.borderColor = [UIColor whiteColor].CGColor;
        self.img_user.layer.borderWidth = 3.0;
    }
}
@end
