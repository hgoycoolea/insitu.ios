//
//  MapPin.h
//  insitu
//
//  Created by Hector Goycoolea on 13-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

@interface MapPin : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    UIImage  *image;
    NSString *telefono_r;
    NSString *website_r;
    NSString *direccion_r;
    NSString *merchant_id;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *subtitle;
@property (nonatomic, readonly) NSString *telefono_r;
@property (nonatomic, readonly) NSString *website_r;
@property (nonatomic, readonly) NSString *direccion_r;
@property (nonatomic, readonly) NSString *merchant_id;
@property (nonatomic,retain) UIImage  *image;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description image:(UIImage *)img direccion:(NSString *)direccion telefono:(NSString *)telefono website:(NSString *)website mercante:(NSString *)mercante;

@end
