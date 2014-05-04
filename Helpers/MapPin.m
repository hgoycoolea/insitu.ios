//
//  MapPin.m
//  insitu
//
//  Created by Hector Goycoolea on 13-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize image;
@synthesize telefono_r, website_r, direccion_r;
@synthesize merchant_id;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:placeName description:description image:img direccion:(NSString *)direccion telefono:(NSString *)telefono website:(NSString *)website mercante:(NSString *)mercante {
    self = [super init];
    if (self != nil) {
        coordinate = location;
        title = placeName;
        [title retain];
        subtitle = description;
        image = img;
        telefono_r = telefono;
        website_r = website;
        direccion_r = direccion;
        merchant_id = mercante;
        [subtitle retain];
    }
    return self;
}

- (void)dealloc {
    [title release];
    [subtitle release];
    [super dealloc];
}


@end
