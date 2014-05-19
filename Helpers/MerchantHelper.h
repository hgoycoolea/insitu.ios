//
//  MerchantHelper.h
//  insitu
//
//  Created by Hector Goycoolea on 18-05-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <Foundation/Foundation.h>
/// Merchant Interface
@interface MerchantHelper : NSObject
/// Check if the Client follows the merchant
-(NSString *) checkFollowMerchant: (NSString *) idMerchant andClient:(NSString *) idClient;
/// Follow a Merchant
-(NSString *) followMerchant: (NSString *) idMerchant fromClient :(NSString *) idClient;
/// UnFollow a Merchant
-(NSString *) unfollowMerchant: (NSString *) idMerchant fromClient :(NSString *) idClient;
/// Number of Merchants
-(NSString *) getFollowerNumbersFromMerchant: (NSString *) idMerchant;
/// client Profile from id
-(NSString *) getClientProfile: (NSString *) idClient;
/// get Followers
-(NSString *) getFollowers: (NSString *) idMerchant;
@end
