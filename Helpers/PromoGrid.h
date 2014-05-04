//  PromoGrid.h
//  insitu
//
//  Created by Hector Goycoolea on 03-05-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
#import <Foundation/Foundation.h>
/// interface for the PromoGrid
@interface PromoGrid : NSObject
/// this is the id to identify the promo
@property (nonatomic, assign) int ID;
/// title of the promo
@property (nonatomic, assign) NSString *Title;
/// body of the promo
@property (nonatomic, assign) NSString *Body;
/// url of the image
@property (nonatomic, assign) NSString *Avatar;
@end
