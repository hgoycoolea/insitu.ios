//
//  MerchantHelper.m
//  insitu
//
//  Created by Hector Goycoolea on 18-05-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "MerchantHelper.h"
#include "ASIFormDataRequest.h"
#import "EncryptionHelper.h"

@implementation MerchantHelper
/// Check if the Client follows the merchant
-(NSString *) checkFollowMerchant: (NSString *) idMerchant andClient:(NSString *) idClient{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/checkFollowMercante.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_idc = [rsa Encrypt:[NSString stringWithFormat:@"%@",idClient]];
        NSString *encr_idm = [rsa Encrypt:[NSString stringWithFormat:@"%@",idMerchant]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_idc forKey:@"__idc"];
        [request setPostValue:encr_idm forKey:@"__idm"];
        [request setDelegate:self];
        [request startSynchronous];
        /// this gets the response from the server
        NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        /// we return the response
        return response;
    }
    @catch (NSException *exception) {
        /// we return the nack to the user
        return @"NACK";
    }

}
/// Follow a Merchant
-(NSString *) followMerchant: (NSString *) idMerchant fromClient :(NSString *) idClient{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/followMerchant.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_idc = [rsa Encrypt:[NSString stringWithFormat:@"%@",idClient]];
        NSString *encr_idm = [rsa Encrypt:[NSString stringWithFormat:@"%@",idMerchant]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_idc forKey:@"__idc"];
        [request setPostValue:encr_idm forKey:@"__idm"];
        [request setDelegate:self];
        [request startSynchronous];
        /// this gets the response from the server
        NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        /// we return the response
        return response;
    }
    @catch (NSException *exception) {
        /// we return the nack to the user
        return @"NACK";
    }

}
/// UnFollow a Merchant
-(NSString *) unfollowMerchant: (NSString *) idMerchant fromClient :(NSString *) idClient{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/unfollowMerchant.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_idc = [rsa Encrypt:[NSString stringWithFormat:@"%@",idClient]];
        NSString *encr_idm = [rsa Encrypt:[NSString stringWithFormat:@"%@",idMerchant]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_idc forKey:@"__idc"];
        [request setPostValue:encr_idm forKey:@"__idm"];
        [request setDelegate:self];
        [request startSynchronous];
        /// this gets the response from the server
        NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        /// we return the response
        return response;
    }
    @catch (NSException *exception) {
        /// we return the nack to the user
        return @"NACK";
    }

}
/// Number of Merchants
-(NSString *) getFollowerNumbersFromMerchant: (NSString *) idMerchant{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/getNumeroSeguidoresPorMercante.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_id = [rsa Encrypt:[NSString stringWithFormat:@"%@",idMerchant]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_id forKey:@"__id"];
        [request setDelegate:self];
        [request startSynchronous];
        /// this gets the response from the server
        NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        /// we return the response
        return response;
    }
    @catch (NSException *exception) {
        /// we return the nack to the user
        return @"NACK";
    }
}
/// client Profile from id
-(NSString *) getClientProfile: (NSString *) idClient{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/getPerfilCliente.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_id = [rsa Encrypt:[NSString stringWithFormat:@"%@",idClient]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_id forKey:@"__id"];
        [request setDelegate:self];
        [request startSynchronous];
        /// this gets the response from the server
        NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        /// we return the response
        return response;
    }
    @catch (NSException *exception) {
        /// we return the nack to the user
        return @"NACK";
    }
}
/// get Followers
-(NSString *) getFollowers: (NSString *) idMerchant{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/getFollowers.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_id = [rsa Encrypt:[NSString stringWithFormat:@"%@",idMerchant]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_id forKey:@"__id"];
        [request setDelegate:self];
        [request startSynchronous];
        /// this gets the response from the server
        NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        /// we return the response
        return response;
    }
    @catch (NSException *exception) {
        /// we return the nack to the user
        return @"NACK";
    }

}
@end
