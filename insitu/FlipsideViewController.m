//
//  FlipsideViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 3/26/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "FlipsideViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface FlipsideViewController ()
@property (nonatomic, strong) IBOutlet UILabel *biogragia;
@property (nonatomic, strong) IBOutlet UILabel *location;
@property (nonatomic, strong) IBOutlet UITextField *usuario_social;
@property (nonatomic, strong) IBOutlet UILabel *nombre_social;
@property (nonatomic, strong) IBOutlet UIImageView *img_user;
@property (nonatomic, strong) IBOutlet UIButton *twitter_button;
@property (nonatomic, strong) IBOutlet UIButton *fb_button;
@end

@implementation FlipsideViewController

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
    [self.delegate flipsideViewControllerDidFinish:self];
}

-(IBAction)fbTapped:(id)sender{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            } else
                
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Test Post from insitu app"];
        
        //Adding the URL to the facebook post value from iOS
        
        [controller addURL:[NSURL URLWithString:@"http://insituapps.com"]];
        
        //Adding the Image to the facebook post value from iOS
        
        //[controller addImage:[UIImage imageNamed:@"fb.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }

}

- (IBAction)tweetTapped:(id)sender
{
    /*
        if ([TWTweetComposeViewController canSendTweet])
        {
            TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
            [tweetSheet setInitialText: @"Tweeting from initu Application"];
            [self presentModalViewController:tweetSheet animated:YES];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure  your device has an internet connection and you have at least one Twitter account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }*/
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            } else
                
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Test Post from insitu app"];
        
        //Adding the URL to the facebook post value from iOS
        
        [controller addURL:[NSURL URLWithString:@"http://insituapps.com"]];
        
        //Adding the Image to the facebook post value from iOS
        
        //[controller addImage:[UIImage imageNamed:@"fb.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }
}
-(IBAction)fbSigninRequest:(id)sender
{
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    [store requestAccessToAccountsWithType:twitterType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted) {
            // Access has been granted, now we can access the accounts
            // Remember that twitterType was instantiated above
            NSArray *fbAccounts = [store accountsWithAccountType: twitterType];
            
            // If there are no accounts, we need to pop up an alert
            if(fbAccounts != nil && [fbAccounts count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Accounts"
                                                                message:@"There are no Twitter accounts configured. You can add or create a Twitter account in Settings."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            } else {
                ACAccount *account = [fbAccounts objectAtIndex:0];
                // Do something with their Twitter account
                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/account/verify_credentials.json"];
                TWRequest *req = [[TWRequest alloc] initWithURL:url
                                                     parameters:nil
                                                  requestMethod:TWRequestMethodGET];
                
                // Important: attach the user's Twitter ACAccount object to the request
                req.account = account;
                
                [req performRequestWithHandler:^(NSData *responseData,
                                                 NSHTTPURLResponse *urlResponse,
                                                 NSError *error) {
                    
                    // If there was an error making the request, display a message to the user
                    if(error != nil) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Error"
                                                                        message:@"There was an error talking to Twitter. Please try again later."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return;
                    }
                    
                    // Parse the JSON response
                    NSError *jsonError = nil;
                    id resp = [NSJSONSerialization JSONObjectWithData:responseData
                                                              options:0
                                                                error:&jsonError];
                    
                    // If there was an error decoding the JSON, display a message to the user
                    if(jsonError != nil) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Error"
                                                                        message:@"Twitter is not acting properly right now. Please try again later."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return;
                    }
                    
                    NSString *screenName = [resp objectForKey:@"screen_name"];
                    NSString *fullName = [resp objectForKey:@"name"];
                    NSString *location = [resp objectForKey:@"location"];
                    NSString *description = [resp objectForKey:@"description"];
                    NSString *profile_image_url = [resp objectForKey:@"profile_image_url"];
                    
                    [self.nombre_social setText:fullName];
                    [self.usuario_social setText:[@"@" stringByAppendingString:screenName]];
                    //[self.usuario_social setText:screenName];
                    [self.biogragia setText:description];
                    [self.location setText:location];
                    
                    /// let's make a circle of the avatar for the company
                    [self.img_user initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profile_image_url]]] ];
                    //imageViewAvatar.layer.cornerRadius = 8.f;
                    self.img_user.layer.cornerRadius = 36;
                    self.img_user.clipsToBounds = YES;
                    self.img_user.layer.borderColor = [UIColor whiteColor].CGColor;
                    self.img_user.layer.borderWidth = 3.0;
                    
                    /// NSUserDefaults
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    /// card holder number
                    [prefs setObject:screenName forKey:@"screen_name"];
                    [prefs setObject:fullName forKey:@"name"];
                    [prefs setObject:location forKey:@"location"];
                    [prefs setObject:description forKey:@"description"];
                    [prefs setObject:profile_image_url forKey:@"profile_image_url"];
                    [prefs setObject:@"0" forKey:@"social_type"];
                    /// we syncrho the preferences
                    [prefs synchronize];
                    
                    // Make sure to perform our operation back on the main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Do something with the fetched data
                    });
                }];
            }
        }
        // Handle any error state here as you wish
    }];
    
    
}

-(IBAction)tweetSigninRequest:(id)sender
{
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [store requestAccessToAccountsWithType:twitterType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted) {
            // Access has been granted, now we can access the accounts
            // Remember that twitterType was instantiated above
            NSArray *twitterAccounts = [store accountsWithAccountType: twitterType];
            
            // If there are no accounts, we need to pop up an alert
            if(twitterAccounts != nil && [twitterAccounts count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Accounts"
                                                                message:@"There are no Twitter accounts configured. You can add or create a Twitter account in Settings."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
            } else {
                ACAccount *account = [twitterAccounts objectAtIndex:0];
                // Do something with their Twitter account
                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/account/verify_credentials.json"];
                TWRequest *req = [[TWRequest alloc] initWithURL:url
                                                     parameters:nil
                                                  requestMethod:TWRequestMethodGET];
                
                // Important: attach the user's Twitter ACAccount object to the request
                req.account = account;
                
                [req performRequestWithHandler:^(NSData *responseData,
                                                 NSHTTPURLResponse *urlResponse,
                                                 NSError *error) {
                    
                    // If there was an error making the request, display a message to the user
                    if(error != nil) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Error"
                                                                        message:@"There was an error talking to Twitter. Please try again later."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return;
                    }
                    
                    // Parse the JSON response
                    NSError *jsonError = nil;
                    id resp = [NSJSONSerialization JSONObjectWithData:responseData
                                                              options:0
                                                                error:&jsonError];
                    
                    // If there was an error decoding the JSON, display a message to the user
                    if(jsonError != nil) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Error"
                                                                        message:@"Twitter is not acting properly right now. Please try again later."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return;
                    }
                    
                    NSString *screenName = [resp objectForKey:@"screen_name"];
                    NSString *fullName = [resp objectForKey:@"name"];
                    NSString *location = [resp objectForKey:@"location"];
                    NSString *description = [resp objectForKey:@"description"];
                    NSString *profile_image_url = [resp objectForKey:@"profile_image_url"];
                    
                    [self.nombre_social setText:fullName];
                    [self.usuario_social setText:[@"@" stringByAppendingString:screenName]];
                    //[self.usuario_social setText:screenName];
                    [self.biogragia setText:description];
                    [self.location setText:location];
                    
                    /// let's make a circle of the avatar for the company
                    [self.img_user initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profile_image_url]]] ];
                    //imageViewAvatar.layer.cornerRadius = 8.f;
                    self.img_user.layer.cornerRadius = 36;
                    self.img_user.clipsToBounds = YES;
                    self.img_user.layer.borderColor = [UIColor whiteColor].CGColor;
                    self.img_user.layer.borderWidth = 3.0;
                    
                    /// NSUserDefaults
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    /// card holder number
                    [prefs setObject:screenName forKey:@"screen_name"];
                    [prefs setObject:fullName forKey:@"name"];
                    [prefs setObject:location forKey:@"location"];
                    [prefs setObject:description forKey:@"description"];
                    [prefs setObject:profile_image_url forKey:@"profile_image_url"];
                    [prefs setObject:@"0" forKey:@"social_type"];
                    /// we syncrho the preferences
                    [prefs synchronize];

                    // Make sure to perform our operation back on the main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Do something with the fetched data
                    });
                }];
            }
        }
        // Handle any error state here as you wish
    }];
    
    
}
/**/
-(void) loadUserInfo
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *social_type = [prefs objectForKey:@"social_type"];
    NSString *screen_name = [prefs objectForKey:@"screen_name"];
    NSString *name = [prefs objectForKey:@"name"];
    NSString *location = [prefs objectForKey:@"location"];
    NSString *description = [prefs objectForKey:@"description"];
    NSString *profile_image_url = [prefs objectForKey:@"profile_image_url"];
    
    if(screen_name!=nil){
        
        [self.nombre_social setText:name];
        //[self.usuario_social setText:screen_name];
        [self.usuario_social setText:[@"@" stringByAppendingString:screen_name]];
        [self.biogragia setText:description];
        [self.location setText:location];
        /// let's make a circle of the avatar for the company
        [self.img_user initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profile_image_url]]] ];
        //imageViewAvatar.layer.cornerRadius = 8.f;
        self.img_user.layer.cornerRadius = 36;
        self.img_user.clipsToBounds = YES;
        self.img_user.layer.borderColor = [UIColor whiteColor].CGColor;
        self.img_user.layer.borderWidth = 3.0;
        
        if([social_type intValue] == 0){
            self.twitter_button.enabled = NO;
        }else{
            self.twitter_button.enabled = YES;
        }
    }
}
@end
