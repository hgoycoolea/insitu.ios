//
//  SearchViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 27-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "SearchViewController.h"
#import "SatelliteHelper.h"
#import "DetailViewController.h"
#import "PromoGrid.h"

@interface SearchViewController ()

@property (nonatomic, assign) IBOutlet UITableView *tableView;
@property (nonatomic, assign) IBOutlet UISearchBar *searchBar;

@property (nonatomic, assign) id jsonObjects;
@property (nonatomic, assign) id jsonObjects1;
@property (nonatomic, assign) NSMutableArray *categories;
@property (nonatomic, assign) NSMutableArray *categories_ids;
@property (nonatomic, assign) NSMutableArray *categoriesClientes;

@property (strong,nonatomic) NSMutableArray* photoList;
@property (strong,nonatomic) NSMutableArray* contentList;
@property (strong,nonatomic) NSMutableArray* titleList;
@property (strong,nonatomic) NSMutableArray* logosList;
@property (strong,nonatomic) NSMutableArray* distanceList;
@property (strong,nonatomic) NSMutableArray* promos_ids;

@property (strong,nonatomic) NSMutableArray* search_results;
@property (strong,nonatomic) NSMutableArray* search_ids_results;
@property (strong,nonatomic) NSMutableArray* search_objects_results;
@end

@implementation SearchViewController


@synthesize jsonObjects;
@synthesize locationManager;

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
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    self.search_results =[NSMutableArray arrayWithCapacity:1];
    self.search_ids_results =[NSMutableArray arrayWithCapacity:1];
    self.search_objects_results =[NSMutableArray arrayWithCapacity:1];
    // Do any additional setup after loading the view.
    /// call to downloadPositions Method
    [self downloadPromocionesGeo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)downloadPromocionesGeo {
    // make up some test data
    self.photoList = [NSMutableArray arrayWithCapacity:1];
    self.contentList = [NSMutableArray arrayWithCapacity:1];
    self.logosList = [NSMutableArray arrayWithCapacity:1];
    self.titleList = [NSMutableArray arrayWithCapacity:1];
    self.distanceList = [NSMutableArray arrayWithCapacity:1];
    self.promos_ids = [NSMutableArray arrayWithCapacity:1];
    self.categories_ids =[NSMutableArray arrayWithCapacity:1];
    
    
    // make up some test data
    NSMutableArray *datasource = [[NSMutableArray alloc] initWithObjects:nil];
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// location Manager
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
    /// this will show me the response
    NSString *response = [helper readPromocionesPorGeolocation:lat Longitude:lon Tolerance:@"10000" Barrio:@"1"];
    /// let's configure the data
    NSData* data=[response dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error = nil;
    /// now we get an array of the all json file
    jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    /// let's loop foreach on the statement
    for(NSDictionary *keys in jsonObjects){
        
        PromoGrid *grid_object = [PromoGrid alloc];
        
        NSString *_id = [keys objectForKey:@"ID"];
        NSString *mercante = [keys objectForKey:@"Mercante"];
        //NSString *producto = [keys objectForKey:@"Producto"];
        //NSString *porcentaje = [keys objectForKey:@"Porcentaje"];
        NSString *titulo = [keys objectForKey:@"Titulo"];
        NSString *cuerpo = [keys objectForKey:@"Cuerpo"];
        //NSString *barra = [keys objectForKey:@"Barra"];
        NSString *url_image = [keys objectForKey:@"UrlImage"];
        //NSString *fecha_comienzo = [keys objectForKey:@"FechaComienzo"];
        //NSString *fecha_termino = [keys objectForKey:@"FechaTermino"];
        //NSString *estado = [keys objectForKey:@"Estado"];
        NSString *categoria = [keys objectForKey:@"Categoria"];
        /// we now get the logo from the merchant
        NSString *logo_mercante = [helper getLogoMercantePorID:[NSString stringWithFormat:@"%d" , [mercante intValue]]];
        NSString *distance = [helper getDistanceToPromociones:lat Longitude:lon Mercante:[NSString stringWithFormat:@"%d" , [mercante intValue]]];
        /// we add the promotion
        [datasource addObject:url_image];
        
        grid_object.ID = [_id intValue];
        grid_object.Title = titulo;
        grid_object.Body = cuerpo;
        grid_object.Avatar = url_image;
        
        [self.search_objects_results addObject:grid_object];
        
        [self.contentList addObject:cuerpo];
        [self.logosList addObject:logo_mercante];
        [self.titleList addObject:titulo];
        [self.distanceList addObject:distance];
        [self.promos_ids addObject:_id];
        [self.categories_ids addObject:categoria];
    }
    //[self createFileList:datasource];
    /// response to the log
    //NSLog(@"%@",response);
}
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
    
    //[self createFileList:datasource];
    /// response to the log
    NSLog(@"%@",response);
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.search_results count];
    } else {
        return [self.titleList count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSUInteger index = [indexPath indexAtPosition:1];
    cell.detailTextLabel.text = @"";
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        PromoGrid *promo = (PromoGrid * )self.search_results[index];
        cell.textLabel.text = promo.Title;
        //cell.textLabel.text = self.search_results[index];

    } else {
        PromoGrid *promo = (PromoGrid * )self.search_objects_results[index];
        cell.textLabel.text = promo.Title;
        //cell.textLabel.text = self.titleList[index];
        
        
    }
    //cell.textLabel.text = self.search_results[index];
    
    return cell;
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
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        /// this is the index form the possition at the path of the collection
        NSUInteger index = [indexPath indexAtPosition:1];
        /// this cast the object
        PromoGrid *promo = (PromoGrid * )self.search_results[index];
        /// NSUserDefaults
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        /// card holder number
        [prefs setObject:[NSString stringWithFormat:@"%d",promo.ID] forKey:@"parent_object_id"];
        /// we syncrho the preferences
        [prefs synchronize];
        
    } else {
        
        NSUInteger index = [indexPath indexAtPosition:1];
        /// this cast the object
        PromoGrid *promo = (PromoGrid * )self.search_objects_results[index];
        /// NSUserDefaults
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        /// card holder number
        [prefs setObject:[NSString stringWithFormat:@"%d",promo.ID] forKey:@"parent_object_id"];
        /// we syncrho the preferences
        [prefs synchronize];
    }
    
    //self performSegueWithIdentifier:@"candyDetail" sender:tableView];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *promotions = (DetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    //PromotionsViewController *promotions = [[PromotionsViewController alloc]init];
    [promotions setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:promotions animated:YES];
}


#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
	// Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
	[self.search_results removeAllObjects];
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.Title contains[c] %@",searchText];
    NSArray *tempArray = [self.search_objects_results filteredArrayUsingPredicate:predicate];
    
    if (![scope isEqualToString:@"Todos"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.Title contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    self.search_results = [NSMutableArray arrayWithArray:tempArray];
}
@end
