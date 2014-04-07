//
//  WallViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 4/5/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "WallViewController.h"
#include "SatelliteHelper.h"

@interface WallViewController ()
@property (strong,nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray* photoList;
@property (strong,nonatomic) NSMutableArray* contentList;
@property (strong,nonatomic) NSMutableArray* titleList;
@property (strong,nonatomic) NSMutableArray* logosList;
@property (strong,nonatomic) NSMutableArray* distanceList;

@property (nonatomic, strong) IBOutlet UILabel *biogragia;
@property (nonatomic, strong) IBOutlet UILabel *location;
@property (nonatomic, strong) IBOutlet UITextField *usuario_social;
@property (nonatomic, strong) IBOutlet UILabel *nombre_social;
@property (nonatomic, strong) IBOutlet UIImageView *img_user;
@property (nonatomic, strong) IBOutlet UIButton *twitter_button;
@property (nonatomic, strong) IBOutlet UIButton *fb_button;
@end

#define kCollectionCellBorderTop 0
#define kCollectionCellBorderBottom 8.0
#define kCollectionCellBorderLeft 4
#define kCollectionCellBorderRight 2

@implementation WallViewController

@synthesize locationManager;
@synthesize refreshControl;
@synthesize jsonObjects;

-(void)viewDidAppear:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
                       [self.collectionView reloadData];
                   });
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self InitializeCLControler];
    /// we download the categories
    [self downloadPromocionesCategorias];
    
    // set up delegates
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    // set inter-item spacing in the layout
    PCollectionViewLayout* customLayout = (PCollectionViewLayout*)self.collectionView.collectionViewLayout;
    customLayout.interitemSpacing = 14.0;
    
    
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
    
    [self loadUserInfo];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self downloadPromocionesCategorias];
    
    [self performSelector:@selector(updateTable) withObject:nil afterDelay:1];
}
/// UpdateTable Method
- (void)updateTable
{
    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
    [self.collectionView reloadData];
    /// End Refreshing
    [self.refreshControl endRefreshing];
}
#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate wallViewControllerDidFinish:self];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
 *
 */
- (void)downloadPromocionesCategorias {
    // make up some test data
    self.photoList = [NSMutableArray arrayWithCapacity:1];
    self.contentList = [NSMutableArray arrayWithCapacity:1];
    self.logosList = [NSMutableArray arrayWithCapacity:1];
    self.titleList = [NSMutableArray arrayWithCapacity:1];
    self.distanceList = [NSMutableArray arrayWithCapacity:1];
    // make up some test data
    NSMutableArray *datasource = [[NSMutableArray alloc] initWithObjects:nil];
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// this will show me the response
    NSString *response = [helper readPromocionesPorCategorias:@"1" Barrio:@"1"];
    /// let's configure the data
    NSData* data=[response dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error = nil;
    /// now we get an array of the all json file
    jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
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
    /// x coordinate
    NSString *lat = [[NSString alloc]initWithFormat:@"%f", userCoordinate.latitude];
    /// y coordinate
    NSString *lon = [[NSString alloc ]initWithFormat:@"%f", userCoordinate.longitude ];
    
    /// let's loop foreach on the statement
    for(NSDictionary *keys in jsonObjects){
        NSString *_id = [keys objectForKey:@"ID"];
        NSString *mercante = [keys objectForKey:@"Mercante"];
        NSString *producto = [keys objectForKey:@"Producto"];
        NSString *porcentaje = [keys objectForKey:@"Porcentaje"];
        NSString *titulo = [keys objectForKey:@"Titulo"];
        NSString *cuerpo = [keys objectForKey:@"Cuerpo"];
        NSString *barra = [keys objectForKey:@"Barra"];
        NSString *url_image = [keys objectForKey:@"UrlImage"];
        NSString *fecha_comienzo = [keys objectForKey:@"FechaComienzo"];
        NSString *fecha_termino = [keys objectForKey:@"FechaTermino"];
        NSString *estado = [keys objectForKey:@"Estado"];
        NSString *categoria = [keys objectForKey:@"Categoria"];
        /// we now get the logo from the merchant
        NSString *logo_mercante = [helper getLogoMercantePorID:[NSString stringWithFormat:@"%d" , [mercante intValue]]];
        NSString *distance = [helper getDistanceToPromociones:lat Longitude:lon Mercante:[NSString stringWithFormat:@"%d" , [mercante intValue]]];
        /// we add the promotion
        [datasource addObject:url_image];
        [self.contentList addObject:cuerpo];
        [self.logosList addObject:logo_mercante];
        [self.titleList addObject:titulo];
        [self.distanceList addObject:distance];
    }
    
    [self createFileList:datasource];
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
    }
}

#pragma mark - UICollectionViewDelegateJSPintLayout




- (CGFloat)columnWidthForCollectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
{
    return 310;
}

- (NSUInteger)maximumNumberOfColumnsForCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
{
    NSUInteger numColumns = 1;
    
    return numColumns;
}

- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath*)indexPath
{
    NSUInteger index = [indexPath indexAtPosition:1];
    
    //UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.photoList[index]]];
    UIImageView* imageView = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.photoList[index]]]] ];
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
    
    /// this is the actual size of the cell
    CGRect fPrev = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath].frame;
    CGFloat height = fPrev.size.height;
    CGFloat width = fPrev.size.width;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        UIImageView* imageView = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.photoList[index]]]] ];
        dispatch_sync(dispatch_get_main_queue(), ^{
            /// when finished what it does
            
            //UIImageView* imageView = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.photoList[index]]]] ];
            
            CGSize rctSizeOriginal = imageView.bounds.size;
            double scale = (cell.bounds.size.width  - (kCollectionCellBorderLeft + kCollectionCellBorderRight)) / rctSizeOriginal.width;
            CGSize rctSizeFinal = CGSizeMake(rctSizeOriginal.width * scale,rctSizeOriginal.height / 4 );
            imageView.frame = CGRectMake(kCollectionCellBorderLeft,kCollectionCellBorderTop,rctSizeFinal.width,rctSizeFinal.height);
            
            [cell.contentView addSubview:imageView];
            
            CGRect rctLabelTitle = CGRectMake(4,kCollectionCellBorderTop + rctSizeFinal.height + 1,rctSizeFinal.width-4,65);
            UILabel* labelt = [[UILabel alloc] initWithFrame:rctLabelTitle];
            labelt.numberOfLines = 0;
            labelt.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
            labelt.text = self.titleList[index];
            [cell.contentView addSubview:labelt];
            
            CGRect rctLabel = CGRectMake(4,kCollectionCellBorderTop + rctSizeFinal.height + 30,rctSizeFinal.width-4,65);
            UILabel* label = [[UILabel alloc] initWithFrame:rctLabel];
            label.numberOfLines = 0;
            label.font = [UIFont fontWithName:@"Helvetica" size:9];
            label.text = self.contentList[index];
            [cell.contentView addSubview:label];
            
            CGRect rctLabelDist = CGRectMake(4,height-110,width-4,65);
            UILabel* labeld = [[UILabel alloc] initWithFrame:rctLabelDist];
            labeld.numberOfLines = 0;
            labeld.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
            NSInteger d = [self.distanceList[index] integerValue];
            if(d>1000){
                CGFloat dk = d/1000;
                NSString *dks =[NSString stringWithFormat:@"%f" , dk];
                NSInteger dki = [dks intValue];
                labeld.text = [[NSString stringWithFormat:@"%d" , dki] stringByAppendingString:@" kilometros de ti."];
            }else{
                labeld.text = [[NSString stringWithFormat:@"%d" , d] stringByAppendingString:@" metros de ti."];
            }
            [cell.contentView addSubview:labeld];
            
            
            /// let's make a circle of the avatar for the company
            UIImageView* imageViewSpliter = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"splitImage.png"] ];
            imageViewSpliter.frame = CGRectMake(0,height-70,width,1);
            [cell.contentView addSubview:imageViewSpliter];
            
            /// let's make a circle of the avatar for the company
            UIImageView* imageViewTag = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"1396308511_tag_fill.png"] ];
            imageViewTag.frame = CGRectMake(width-30,height-60,20,20);
            [cell.contentView addSubview:imageViewTag];
            
            /// let's make a circle of the avatar for the company
            UIImageView* imageViewShare = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"1396308581_share.png"] ];
            imageViewShare.frame = CGRectMake(width-65,height-60,20,20);
            [cell.contentView addSubview:imageViewShare];
            
            
            /// let's make a circle of the avatar for the company
            UIImageView* imageViewFavorite = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"1396306261_star.png"] ];
            imageViewFavorite.frame = CGRectMake(width-30,height-30,20,20);
            [cell.contentView addSubview:imageViewFavorite];
            
            /// let's make a circle of the avatar for the company
            UIImageView* imageViewPin = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"1396307328_pin.png"] ];
            imageViewPin.frame = CGRectMake(width-65,height-30,20,20);
            [cell.contentView addSubview:imageViewPin];
            
            /// let's make a circle of the avatar for the company
            UIImageView* imageViewAvatar = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.logosList[index]]]] ];
            //imageViewAvatar.layer.cornerRadius = 8.f;
            imageViewAvatar.layer.cornerRadius = 25;
            imageViewAvatar.clipsToBounds = YES;
            // imageViewAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
            // imageViewAvatar.layer.borderWidth = 3.0;
            
            imageViewAvatar.frame = CGRectMake(4,height-60,50,50);
            [cell.contentView addSubview:imageViewAvatar];
            
        });
    });
    
    
    return cell;
    
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
