//
//  GPSManager.h
//  insitu
//
//  Created by Hector Goycoolea on 11-04-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSManager : NSObject
{
    NSString *lon;
    NSString *lat;
    NSString *alt;
    NSString *speed;
}

@property (nonatomic, retain) NSString *lon;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *alt;
@property (nonatomic, retain) NSString *speed;

+(id) sharedManager;
@end
