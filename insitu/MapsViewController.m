//
//  MapViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 13-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "MapsViewController.h"
#include "SatelliteHelper.h"
#include "MapPin.h"

@interface MapsViewController ()
/// Mapview Controllers
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
#pragma mark - id jsonObjects
@property (nonatomic, retain) IBOutlet id jsonObjects;
@property (nonatomic, retain) IBOutlet id jsonObjects1;

@property (strong,nonatomic) NSMutableArray* annotations;
@end

@implementation MapsViewController

@synthesize mapView;

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
    mapView.delegate = self;
    // Do any additional setup after loading the view.
    [self downloadPositions];
    
    MKMapRect flyTo = MKMapRectNull;
	for (MapPin *annotation in self.annotations) {

        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    // Position the map so that all overlays and annotations are visible on screen.
    mapView.visibleMapRect = flyTo;
    
    //[mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
}

- (void)downloadPositions {
    ///
    self.annotations=[[NSMutableArray alloc] init];
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// this will show me the response
    NSString *response = [helper readPositions];
    /// let's configure the data
    NSData* data=[response dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error = nil;
    /// now we get an array of the all json file
    self.jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    /// let's loop foreach on the statement
    for(NSDictionary *keys in self.jsonObjects){
        NSString *Mercante = [keys objectForKey:@"Mercante"];
        NSString *Axis = [keys objectForKey:@"Axis"];
        NSArray *split_axis = [Axis componentsSeparatedByString:@","];
        NSString *lon = [split_axis objectAtIndex:1];
        NSString *lat = [split_axis objectAtIndex:0];
        
        CLLocationCoordinate2D  ctrpoint;
        ctrpoint.latitude = [lat floatValue];
        ctrpoint.longitude = [lon floatValue];
        
        /// this will show me the response
        NSString *response1 = [helper getMercantePorID:Mercante];
        /// let's configure the data
        NSData* data1=[response1 dataUsingEncoding: [NSString defaultCStringEncoding] ];
        /// error for the json objects
        NSError *error1 = nil;
        /// now we get an array of the all json file
        self.jsonObjects1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:&error1];

        NSString *nombre_tienda = [self.jsonObjects1 objectForKey:@"NombreTienda"];
        NSString *id_mercante =[self.jsonObjects1 objectForKey: @"ID"];
        NSString *website =[self.jsonObjects1 objectForKey: @"WebSite"];
        NSString *telefono=[self.jsonObjects1 objectForKey:@"Telefono"];
        NSString *url_image = [self.jsonObjects1 objectForKey:@"UrlImageLogo"];

        /// let's make a circle of the avatar for the company
        UIImage *logo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url_image]]];
        
        NSString *descr1 = [website stringByAppendingString:@","];
        NSString *descr2 = [descr1 stringByAppendingString:telefono];
        
        MapPin *pin = [[MapPin alloc] initWithCoordinates:ctrpoint placeName:nombre_tienda description:descr2 image:logo direccion:@"" telefono:telefono website:website mercante:id_mercante];
        
        [mapView addAnnotation:pin];
        [self.annotations addObject:pin];
        /// let's make a circle of the avatar for the company
        //UIImage *imagesHome = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img_home]]];
    }
    /// response to the log
    NSLog(@"%@",response);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MapPin class]]) {
        
        MapPin *pin = (MapPin *)annotation;
        
        static NSString *identifier = @"myIdentifier";
        MKAnnotationView *annotationView = (MKAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        //Lazy instantation
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
            CGRect rect = CGRectMake(0,0,30,30);
            UIGraphicsBeginImageContext( rect.size );
            [pin.image drawInRect:rect];
            UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            NSData *imageData = UIImagePNGRepresentation(picture1);
            UIImage *img=[UIImage imageWithData:imageData];
            
            annotationView.image = [self roundCornersOfImage:img];
            
            annotationView.centerOffset = CGPointMake(0,-annotationView.frame.size.height*0.5);
            annotationView.canShowCallout = YES;
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.annotation = annotation;
            /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            NSString *id_merchant_selected = [prefs objectForKey:@"id_merchant_selected"];
            [prefs autorelease];
            
            if(id_merchant_selected == pin.merchant_id){
                annotationView.selected = YES;
            }*/
            
            
        } else {
            
            annotationView.annotation = annotation;
            
        }
        
        return annotationView;
        
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MapPin *pin = (MapPin *)view.annotation;
    
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// this will show me the response
    NSString *response1 = [helper getMercantePorID:[NSString stringWithFormat:@"%@",pin.merchant_id]];
    /// let's configure the data
    NSData* data1=[response1 dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error1 = nil;
    /// now we get an array of the all json file
    self.jsonObjects1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:&error1];
    
    //NSString *nombre_tienda = [self.jsonObjects1 objectForKey:@"NombreTienda"];
    //NSString *id_mercante =[self.jsonObjects1 objectForKey: @"ID"];
    NSString *website =[self.jsonObjects1 objectForKey: @"WebSite"];
    NSString *telefono=[self.jsonObjects1 objectForKey:@"Telefono"];
    NSString *url_image = [self.jsonObjects1 objectForKey:@"UrlImageLogo"];
    NSString *email = [self.jsonObjects1 objectForKey:@"Email"];
    NSString *calle = [self.jsonObjects1 objectForKey:@"Calle"];
    NSString *numero = [self.jsonObjects1 objectForKey:@"Numero"];
    NSString *local = [self.jsonObjects1 objectForKey:@"Local"];
    NSString *pais = [self.jsonObjects1 objectForKey:@"Pais"];
    NSString *s_pais = [helper getPaisPorID:[NSString stringWithFormat:@"%@",pais]];
    NSString *ciudad = [self.jsonObjects1 objectForKey:@"Ciudad"];
    NSString *s_ciudad = [helper getCiudadPorID:[NSString stringWithFormat:@"%@",ciudad]];
    /*
    NSString *a1 = [calle stringByAppendingString:@" "];
    NSString *a2 = [a1 stringByAppendingString:numero];
    NSString *a3 = [a2 stringByAppendingString:@" "];
    NSString *a4 = [a3 stringByAppendingString:local];
    
    NSDictionary *address = @{
                              (NSString *)kABPersonAddressStreetKey: a4,
                              (NSString *)kABPersonAddressCityKey: s_ciudad,
                              //(NSString *)kABPersonAddressStateKey: @"NY",
                              //(NSString *)kABPersonAddressZIPKey: @"10118",
                              (NSString *)kABPersonAddressCountryCodeKey: s_pais
                              };*/
    
    MKPlacemark *placeMark = [[MKPlacemark alloc]initWithCoordinate:pin.coordinate addressDictionary:nil];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placeMark];
    [mapItem setName:pin.title];
    [mapItem setPhoneNumber:telefono];
    [mapItem setUrl:[NSURL URLWithString: website]];
    
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                              MKLaunchOptionsMapTypeKey:
                                  [NSNumber numberWithInteger:MKMapTypeStandard],
                              MKLaunchOptionsShowsTrafficKey:@YES,
                              
                              };
    
    [mapItem openInMapsWithLaunchOptions:options];
    
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate mapsViewControllerDidFinish:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
	float fw, fh;
	if (ovalWidth == 0 || ovalHeight == 0) {
		CGContextAddRect(context, rect);
		return;
	}
	CGContextSaveGState(context);
	CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextScaleCTM (context, ovalWidth, ovalHeight);
	fw = CGRectGetWidth (rect) / ovalWidth;
	fh = CGRectGetHeight (rect) / ovalHeight;
	CGContextMoveToPoint(context, fw, fh/2);
	CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
	CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
	CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
	CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}

- (UIImage *)roundCornersOfImage:(UIImage *)source {
	int w = source.size.width;
    int h = source.size.height;
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
	CGContextBeginPath(context);
	CGRect rect = CGRectMake(0, 0, w, h);
	// Set the oval width and height to be quarter of the image width and height
	addRoundedRectToPath(context, rect, w/4, h/4);
	CGContextClosePath(context);
	CGContextClip(context);
    
	CGContextDrawImage(context, CGRectMake(0, 0, w, h), source.CGImage);
    
	CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	UIImage *newImage = [[UIImage imageWithCGImage:imageMasked] retain];
    
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(imageMasked);
    
	return newImage;    
}


@end
