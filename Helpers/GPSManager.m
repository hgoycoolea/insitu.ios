//
//  GPSManager.m
//  insitu
//
//  Created by Hector Goycoolea on 11-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "GPSManager.h"

@implementation GPSManager

@synthesize lon, lat, speed, alt;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static GPSManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        lat = [[NSString alloc] initWithString:@"0.0"];
        lon = [[NSString alloc] initWithString:@"0.0"];
        speed = [[NSString alloc] initWithString:@"0"];
        alt = [[NSString alloc] initWithString:@"0"];
    }
    return self;
}
@end
