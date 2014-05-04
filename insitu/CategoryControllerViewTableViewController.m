//
//  CategoryControllerViewTableViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 17-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "CategoryControllerViewTableViewController.h"
#import "SatelliteHelper.h"
#import "PromotionsViewController.h"

@interface CategoryControllerViewTableViewController ()
@property (nonatomic, assign) id jsonObjects;
@property (nonatomic, assign) id jsonObjects1;
@property (nonatomic, assign) NSMutableArray *categories;
@property (nonatomic, assign) NSMutableArray *categories_ids;
@property (nonatomic, assign) NSMutableArray *categoriesClientes;
@property (nonatomic, assign) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UILabel *nombre_social;
@property (nonatomic, strong) IBOutlet UIImageView *img_user;
@property (nonatomic, strong) IBOutlet UILabel *location;
@end

@implementation CategoryControllerViewTableViewController
@synthesize jsonObjects;

///
- (void)viewDidLoad
{
    [super viewDidLoad];
    /// call to downloadPositions Method
    [self downloadCategories];
    /// we load the users info detail
    [self loadUserInfo];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
///
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///
- (void)downloadCategories {
    ///
    self.categories=[[NSMutableArray alloc] init];
    self.categories_ids=[[NSMutableArray alloc] init];
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// this will show me the response
    NSString *response = [helper readCategories];
    /// let's configure the data
    NSData* data=[response dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error = nil;
    /// now we get an array of the all json file
    self.jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    /// let's loop foreach on the statement
    for(NSDictionary *keys in self.jsonObjects){
        /// id for the table
        NSString *_id = [keys objectForKey:@"ID"];
        /// nombre for the category
        NSString *_nombre = [keys objectForKey:@"Nombre"];
        /// category array
        [self.categories addObject:_nombre];
        /// id to the target array
        [self.categories_ids addObject:_id];
        /// let's make a circle of the avatar for the company
        //UIImage *imagesHome = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img_home]]];
    }
    /// response to the log
    NSLog(@"%@",response);
}
///
- (void)downloadClientCategories {
    /// Client ID
    NSString *client_id = @"1";
    /// Mutable Array Collection
    self.categories=[[NSMutableArray alloc] init];
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// this will show me the response
    NSString *response = [helper readClientCategories: client_id];
    /// let's configure the data
    NSData* data=[response dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error = nil;
    /// now we get an array of the all json file
    self.jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    /// let's loop foreach on the statement
    for(NSDictionary *keys in self.jsonObjects){
        /// id for the table
        NSString *_id = [keys objectForKey:@"ID"];
        /// nombre for the category
        NSString *_client = [keys objectForKey:@"Cliente"];
        /// nombre for the category
        NSString *_category = [keys objectForKey:@"Categoria"];
        /// category array
        [self.categoriesClientes addObject:_category];
    }
    /// response to the log
    NSLog(@"%@",response);
}

/**/
-(void) loadUserInfo
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *screen_name = [prefs objectForKey:@"screen_name"];
    NSString *name = [prefs objectForKey:@"name"];
    NSString *profile_image_url = [prefs objectForKey:@"profile_image_url"];
    NSString *gps = [prefs objectForKey:@"location"];
    
    if(screen_name!=nil){
        
        [self.location setText:gps];
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
#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate categoryViewControllerDidFinish:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSUInteger index = [indexPath indexAtPosition:1];
    
    cell.textLabel.text = self.categories[index];
    
    cell.detailTextLabel.text = @"";
    /*
    cell.imageView.image = [UIImage imageNamed:@"eat.png"];
    //imageViewAvatar.layer.cornerRadius = 8.f;
    cell.imageView.layer.cornerRadius = 36;
    cell.imageView.clipsToBounds = YES;
    cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.imageView.layer.borderWidth = 3.0;*/
    /*
    CGRect rctLabelTitle = CGRectMake(4,0,300,65);
    UILabel* labelt = [[UILabel alloc] initWithFrame:rctLabelTitle];
    labelt.numberOfLines = 0;
    labelt.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    labelt.text = self.categories[index];
    [cell.contentView addSubview:labelt];*/
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger index = [indexPath indexAtPosition:1];
    NSLog(@"Category id>> %@",self.categories_ids[index]);
    
    NSLog(@"Selected section>> %ld",(long)indexPath.section);
    NSLog(@"Selected row of section >> %ld",(long)indexPath.row);
    
    /// NSUserDefaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    /// card holder number
    [prefs setObject:self.categories_ids[index] forKey:@"parent_category"];
    /// we syncrho the preferences
    [prefs synchronize];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PromotionsViewController *promotions = (PromotionsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PromotionsViewController"];
    //PromotionsViewController *promotions = [[PromotionsViewController alloc]init];
    [promotions setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:promotions animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
