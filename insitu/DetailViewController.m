//
//  DetailViewController.m
//  insitu
//
//  Created by Hector Goycoolea on 27-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "DetailViewController.h"
#import "SatelliteHelper.h"

@interface DetailViewController ()
/// Merchant Avatar Image
@property (nonatomic, assign) IBOutlet UIImageView *MerchantAvatarImage;
/// Promotion Avatar Image
@property (nonatomic, assign) IBOutlet UIImageView *PromoAvatarImage;
/// Merchant Name
@property (nonatomic, assign) IBOutlet UILabel *MerchantName;
/// Merchant Telephone Number
@property (nonatomic, assign) IBOutlet UILabel *MerchantNumber;
/// Promotion Title
@property (nonatomic, assign) IBOutlet UILabel *PromoTitle;
/// Promotion Body
@property (nonatomic, assign) IBOutlet UILabel *PromoBody;
@end

@implementation DetailViewController

@synthesize jsonObjects;
/// id interno
NSString *id_interno;

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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    /// we look the selected id
    NSString *id_merchant_selected = [prefs objectForKey:@"parent_object_id"];
    /// we pass the setter
    id_interno = id_merchant_selected;
    /// we release the object
    [prefs autorelease];
    /// we load the promo and the merchant information
    [self loadPromo];
}

-(void) loadPromo
{
    SatelliteHelper *helper = [SatelliteHelper alloc];
    /// this reads the promo from the web and loads it into the json string
    NSString *response = [helper getMercantePorID:id_interno];
    /// let's configure the data
    NSData* data=[response dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error = nil;
    /// now we get an array of the all json file
    jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    /// id from the object array
    NSString *_id = [jsonObjects objectForKey:@"ID"];
    NSString *mercante = [jsonObjects objectForKey:@"Mercante"];
    NSString *producto = [jsonObjects objectForKey:@"Producto"];
    NSString *porcentaje = [jsonObjects objectForKey:@"Porcentaje"];
    NSString *titulo = [jsonObjects objectForKey:@"Titulo"];
    NSString *cuerpo = [jsonObjects objectForKey:@"Cuerpo"];
    NSString *barra = [jsonObjects objectForKey:@"Barra"];
    NSString *url_image = [jsonObjects objectForKey:@"UrlImage"];
    NSString *fecha_comienzo = [jsonObjects objectForKey:@"FechaComienzo"];
    NSString *fecha_termino = [jsonObjects objectForKey:@"FechaTermino"];
    NSString *estado = [jsonObjects objectForKey:@"Estado"];
    NSString *categoria = [jsonObjects objectForKey:@"Categoria"];
    /// we now get the logo from the merchant
    NSString *logo_mercante_url = [helper getLogoMercantePorID:[NSString stringWithFormat:@"%d" , [mercante intValue]]];
    /// images from the promo
    UIImage *imagePromo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url_image]]];
    /// Promotion Avatar Image
    self.PromoAvatarImage.image = imagePromo;
    /// Merchant Avatar Image
    UIImage *imageAvatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:logo_mercante_url]]];
    //imageViewAvatar.layer.cornerRadius = 8.f;
    self.MerchantAvatarImage.layer.cornerRadius = 36;
    self.MerchantAvatarImage.clipsToBounds = YES;
    self.MerchantAvatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.MerchantAvatarImage.layer.borderWidth = 3.0;
    self.MerchantAvatarImage.image = imageAvatar;
    /// promotion
    self.PromoBody.text = cuerpo;
    self.PromoTitle.text = titulo;
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

@end
