//
//  SatelliteHelper.m
//  insitu
//
//  Created by Hector Goycoolea on 3/27/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//
#import "SatelliteHelper.h"
#include "ASIFormDataRequest.h"
#import "EncryptionHelper.h"

@implementation SatelliteHelper
/*
 * (NSString *) acknowledgeRutas: (NSString *)lat Longitude:(NSString *)lon Speed:(NSString *)speed Altitude:(NSString *)alt Client:(NSString *) client
 *
 *
 * Note:
 * --------------------------------------------------------------------
 * This Method Saves the Route of the client to
 * the database, with parameters, latitude, longitude, speed and client
 * --------------------------------------------------------------------
 */
-(NSString *) acknowledgeRutas: (NSString *)lat Longitude:(NSString *)lon Speed:(NSString *)speed Altitude:(NSString *)alt Client:(NSString *) client
{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/AcknowledgeRutas.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we create the axis in the shape lat,long
        NSString *axis_comma = [lat stringByAppendingString:@","];
        NSString *axis = [axis_comma stringByAppendingString:lon];
        /// we encrypt the data to send it
        NSString *encr_a = [rsa Encrypt:axis];
        NSString *encr_c = [rsa Encrypt:client];
        NSString *encr_s = [rsa Encrypt:speed];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_c forKey:@"__c"];
        [request setPostValue:encr_a forKey:@"__a"];
        [request setPostValue:encr_s forKey:@"__s"];
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
/*
 * (NSString *) readRutas: (NSString *)client
 *
 *
 * Note:
 * --------------------------------------------
 * This Method Obtains the Routes of the client
 * given its ID
 * --------------------------------------------
 */
-(NSString *) readRutas: (NSString *)client
{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/ReadRutas.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// client encription
        NSString *encr_c = [rsa Encrypt:client];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_c forKey:@"__c"];
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

-(NSString *) readPromocionesPorCategorias: (NSString *)categorias
{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/ReadPromocionesPorCategorias.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// client encription
        NSString *encr_c = [rsa Encrypt:categorias];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_c forKey:@"__c"];
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

-(NSString *) readPromocionesPorGeolocation: (NSString *)lat Longitude:(NSString *)lon Tolerance:(NSString *)tolerance
{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/ReadPromocionesPorGeolocation.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we create the axis in the shape lat,long
        NSString *axis_comma = [lat stringByAppendingString:@","];
        NSString *axis = [axis_comma stringByAppendingString:lon];
        /// we encrypt the data to send it
        NSString *encr_a = [rsa Encrypt:axis];
        /// client encription
        NSString *encr_t = [rsa Encrypt:tolerance];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_a forKey:@"__a"];
        [request setPostValue:encr_t forKey:@"__t"];
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