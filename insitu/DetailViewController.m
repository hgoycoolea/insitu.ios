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
    NSString *response = [helper getPromocionPorID:id_interno];
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
    //NSString *logo_mercante_url = [helper getLogoMercantePorID:[NSString stringWithFormat:@"%d" , [mercante intValue]]];
    /// images from the promo
    UIImage *imagePromo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url_image]]];
    /// Promotion Avatar Image
    self.PromoAvatarImage.image = imagePromo;
    /// Merchant Avatar Image
    /*UIImage *imageAvatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:logo_mercante_url]]];
    //imageViewAvatar.layer.cornerRadius = 8.f;
    self.MerchantAvatarImage.layer.cornerRadius = 20;
    self.MerchantAvatarImage.clipsToBounds = YES;
    self.MerchantAvatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.MerchantAvatarImage.layer.borderWidth = 3.0;
    self.MerchantAvatarImage.image = imageAvatar;*/
    //imageViewAvatar.layer.cornerRadius = 8.f;
    self.PromoAvatarImage.layer.cornerRadius = 36;
    self.PromoAvatarImage.clipsToBounds = YES;
    self.PromoAvatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.PromoAvatarImage.layer.borderWidth = 3.0;
    self.PromoAvatarImage.image = imagePromo;
    /// promotion
    self.PromoBody.text = cuerpo;
    self.PromoTitle.text = titulo;
    /// we now load the merchant info
    [self loadMerchant:mercante];
}
///
- (void) loadMerchant:(NSString *) Merchant
{
    /// we initialize the helper
    SatelliteHelper *helper = [[SatelliteHelper alloc] init];
    /// this will show me the response
    NSString *response = [helper getMercantePorID:[NSString stringWithFormat:@"%d" , [Merchant intValue]]];
    /// let's configure the data
    NSData* data=[response dataUsingEncoding: [NSString defaultCStringEncoding] ];
    /// error for the json objects
    NSError *error = nil;
    /// now we get an array of the all json file
    jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    /// we get the data form the web
    NSString *logo = [jsonObjects objectForKey:@"UrlImageLogo"];
    NSString *web_site = [jsonObjects objectForKey:@"WebSite"];
    NSString *telefono = [jsonObjects objectForKey:@"Telefono"];
    NSString *tienda = [jsonObjects objectForKey:@"NombreTienda"];
    /// we add the promotion
    /// let's make a circle of the avatar for the company
    UIImage *imagesHome = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:logo]]];
    //[self.usuario_social setText:screen_name];
    /// let's make a circle of the avatar for the company
    [self.MerchantAvatarImage initWithImage: imagesHome ];
    self.MerchantAvatarImage.layer.cornerRadius = 20;
    self.MerchantAvatarImage.clipsToBounds = YES;
    self.MerchantAvatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.MerchantAvatarImage.layer.borderWidth = 3.0;
    //[self.website setText:web_site];
    [self.MerchantNumber setText:telefono];
    [self.MerchantName setText:tienda];

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
