//
//  MainViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 3/26/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//
#import "MainViewController.h"
#include "SatelliteHelper.h"

@interface MainViewController ()
@property (strong,nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray* photoList;
@end

#define kCollectionCellBorderTop 17.0
#define kCollectionCellBorderBottom 17.0
#define kCollectionCellBorderLeft 17.0
#define kCollectionCellBorderRight 17.0

@implementation MainViewController

@synthesize locationManager;
@synthesize refreshControl;

-(void)viewDidAppear:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [self.collectionView reloadData];
                       
                   });
}
/*
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *aView = [UIView new];
    [self.collectionView addSubview:aView];
    //[self InitializeCLControler];
    /// we download the categories
    [self downloadPromocionesCategorias];
    
    // set up delegates
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // set inter-item spacing in the layout
    PCollectionViewLayout* customLayout = (PCollectionViewLayout*)self.collectionView.collectionViewLayout;
    customLayout.interitemSpacing = 14.0;
    // make up some test data
    self.photoList = [NSMutableArray arrayWithCapacity:1];
    // make up some test data
    NSMutableArray *datasource = [[NSMutableArray alloc] initWithObjects:nil];
    [datasource addObject:@"danielle.jpg"];
    [datasource addObject:@"bodegahead.png"];
    [datasource addObject:@"egret.png"];
    [datasource addObject:@"betceemay.jpg"];
    [datasource addObject:@"baby.jpg"];
    
    [self createFileList:datasource];
    
    [self.collectionView reloadData];
    
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Do the work associated with the task, preferably in chunks.
        NSTimer* t = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(InitializeCLControler) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:t forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
    /// Refresh Control for the UITabletView
    UIRefreshControl *_refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [UIColor blackColor];
    [_refreshControl addTarget:self action:@selector(reRender) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = _refreshControl;
    /// Addsubview
    [self.collectionView addSubview: refreshControl];

}
-(void)addNewCells {
    [self.collectionView performBatchUpdates:^{
        int resultsSize = [self.photoList count];
        [self.photoList addObjectsFromArray:self.photoList];
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        for (int i = resultsSize; i < resultsSize + self.photoList.count; i++){
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
     [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
    }    completion:nil];
}
/// -(void)reRenderCoupons
-(void)reRender
{
    [self.photoList removeAllObjects];
    [self.collectionView reloadData];
    
    //[self getUsersTransactions];
    
    [self performSelector:@selector(updateTable) withObject:nil afterDelay:1];
}
/// UpdateTable Method
- (void)updateTable
{
    /// Reload Data
    [self.collectionView reloadData];
    /// End Refreshing
    [self.refreshControl endRefreshing];
}
/*
 *
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
 * InitializeCLControler
 *
 * Method that initializes the Core Location Controller
 */
-(void) InitializeCLControler
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}
/*
 *
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if([locationManager.delegate conformsToProtocol:@protocol(CLLocationManagerDelegate)]) {  // Check if the class assigning itself as the delegate conforms to our protocol.  If not, the message will go nowhere.  Not good.
		[self locationUpdate:newLocation];
	}
}
/*
 *
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	if([locationManager.delegate conformsToProtocol:@protocol(CLLocationManagerDelegate)]) {  // Check if the class assigning itself as the delegate conforms to our protocol.  If not, the message will go nowhere.  Not good.
		//[self locationError:error];
	}
}
/*
 *
 */
- (void)locationUpdate:(CLLocation *)location {
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    // we set the errro to manager
    self.locationManager.distanceFilter = 50.0f;
    /// we set the acuracy
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    /// we delegate them to self
    self.locationManager.delegate = self;
    /// first we get the location Manager location
    CLLocation *ulocation = [locationManager location];
    /// we now get the coordinates
    CLLocationCoordinate2D userCoordinate = ulocation.coordinate;
    /// we now get users speed
    NSString *speed = [NSString stringWithFormat:@"%f", [location speed]];
    /// x coordinate
    NSString *lat = [[NSString alloc]initWithFormat:@"%f", userCoordinate.latitude];
    /// y coordinate
    NSString *lon = [[NSString alloc ]initWithFormat:@"%f", userCoordinate.longitude ];
    /// altitude
    NSString *alt = [NSString stringWithFormat:@"%f", [location altitude]];
    /// client
    NSString *client = @"1";
    /// this will show me the response
    NSString *response = [helper acknowledgeRutas:lat Longitude:lon Speed:speed Altitude:alt Client:client];
    /// response to the log
    NSLog(@"%@",response);
}
/*
 *
 */
- (void)downloadPromocionesCategorias {
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// this will show me the response
    NSString *response = [helper readPromocionesPorCategorias:@"1"];
    /// response to the log
    NSLog(@"%@",response);
}

#pragma mark - Target Actions



- (IBAction)onAddCell
{
    [self.photoList addObject:@"egret.png"];
    
    NSUInteger newNumCells = [self.photoList count];
    NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:newNumCells - 1
                                                    inSection:0];
    [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]];
    
    [self.collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

- (void)createFileList:(NSArray *)items
{
    
    for(NSString *item in items)
    {
        [self.photoList addObject:item];
        //[self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:[self.photoList count]-1 inSection:0]]];
    }
}

#pragma mark - UICollectionViewDelegateJSPintLayout




- (CGFloat)columnWidthForCollectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
{
    return 153.0;
}

- (NSUInteger)maximumNumberOfColumnsForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
{
    NSUInteger numColumns = 2;
    
    return numColumns;
}

- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath*)indexPath
{
    NSUInteger index = [indexPath indexAtPosition:1];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.photoList[index]]];
    CGSize rctSizeOriginal = imageView.bounds.size;
    double scale = (222  - (kCollectionCellBorderLeft + kCollectionCellBorderRight)) / rctSizeOriginal.width;
    CGSize rctSizeFinal = CGSizeMake(rctSizeOriginal.width * scale,rctSizeOriginal.height * scale);
    imageView.frame = CGRectMake(kCollectionCellBorderLeft,kCollectionCellBorderTop,rctSizeFinal.width,rctSizeFinal.height);
    
    CGFloat height = imageView.bounds.size.height + 100;
    
    return height;
}

- (BOOL)collectionView:(UICollectionView*)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView*)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath*)indexPath withSender:(id)sender
{
    return([NSStringFromSelector(action) isEqualToString:@"cut:"]);
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath*)indexPath withSender:(id)sender
{
    if([NSStringFromSelector(action) isEqualToString:@"cut:"])
    {
        NSUInteger index = [indexPath indexAtPosition:1];
        
        [self.photoList removeObjectAtIndex:index];
        
        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }
}



#pragma mark = UICollectionViewDataSource



- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photoList count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PintReuse" forIndexPath:indexPath];
    
    CGRect rectReference = cell.bounds;
    
    PCollectionCellBackgroundView* backgroundView = [[PCollectionCellBackgroundView alloc] initWithFrame:rectReference];
    cell.backgroundView = backgroundView;
    
    UIView* selectedBackgroundView = [[UIView alloc] initWithFrame:rectReference];
    selectedBackgroundView.backgroundColor = [UIColor clearColor];   // no indication of selection
    cell.selectedBackgroundView = selectedBackgroundView;
    
    // remove subviews from previous usage of this cell
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger index = [indexPath indexAtPosition:1];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.photoList[index]]];
    CGSize rctSizeOriginal = imageView.bounds.size;
    double scale = (cell.bounds.size.width  - (kCollectionCellBorderLeft + kCollectionCellBorderRight)) / rctSizeOriginal.width;
    CGSize rctSizeFinal = CGSizeMake(rctSizeOriginal.width * scale,rctSizeOriginal.height * scale);
    imageView.frame = CGRectMake(kCollectionCellBorderLeft,kCollectionCellBorderTop,rctSizeFinal.width,rctSizeFinal.height);
    
    [cell.contentView addSubview:imageView];
    
    CGRect rctLabel = CGRectMake(kCollectionCellBorderLeft,kCollectionCellBorderTop + rctSizeFinal.height + 5,rctSizeFinal.width,65);
    
    UILabel* label = [[UILabel alloc] initWithFrame:rctLabel];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    
    label.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
    
    [cell.contentView addSubview:label];
    
    
    return cell;
    
}

@end
