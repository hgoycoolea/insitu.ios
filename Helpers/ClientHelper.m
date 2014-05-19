//
//  ClientHelper.m
//  insitu
//
//  Created by Hector Goycoolea on 18-05-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import "ClientHelper.h"
#include "ASIFormDataRequest.h"
#import "EncryptionHelper.h"

@implementation ClientHelper
/// Buy Promotion from and id and client id
-(NSString *) buyPromotionID: (NSString *) idPromotion andClient:(NSString *) idClient{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/buyPromocion.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_idc = [rsa Encrypt:[NSString stringWithFormat:@"%@",idClient]];
        NSString *encr_idp = [rsa Encrypt:[NSString stringWithFormat:@"%@",idPromotion]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_idc forKey:@"__idc"];
        [request setPostValue:encr_idp forKey:@"__idp"];
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
/// Change Promotion State
-(NSString *) changePromotionState: (NSString *)State andPromotionID:(NSString *) idPromotion{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/changePromocion.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_idc = [rsa Encrypt:[NSString stringWithFormat:@"%@",idPromotion]];
        NSString *encr_e = [rsa Encrypt:[NSString stringWithFormat:@"%@",State]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_idc forKey:@"__idc"];
        [request setPostValue:encr_e forKey:@"__e"];
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
//// Create a Client
-(NSString *) createClient: (NSString *)Nombre apellido:(NSString *)Apellido barrio:(NSString *)Barrio email:(NSString *)Email telefono:(NSString *)Telefono sexo:(NSString *)Sexo Uuid:(NSString *)Uuid{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/createCliente.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_n = [rsa Encrypt:[NSString stringWithFormat:@"%@",Telefono]];
        NSString *encr_e = [rsa Encrypt:[NSString stringWithFormat:@"%@",Email]];
        NSString *encr_s = [rsa Encrypt:[NSString stringWithFormat:@"%@",Sexo]];
        NSString *encr_no = [rsa Encrypt:[NSString stringWithFormat:@"%@",Nombre]];
        NSString *encr_a = [rsa Encrypt:[NSString stringWithFormat:@"%@",Apellido]];
        NSString *encr_u = [rsa Encrypt:[NSString stringWithFormat:@"%@",Uuid]];
        NSString *encr_b = [rsa Encrypt:[NSString stringWithFormat:@"%@",Barrio]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_n forKey:@"__n"];
        [request setPostValue:encr_e forKey:@"__e"];
        [request setPostValue:encr_s forKey:@"__s"];
        [request setPostValue:encr_no forKey:@"__no"];
        [request setPostValue:encr_a forKey:@"__a"];
        [request setPostValue:encr_u forKey:@"__u"];
        [request setPostValue:encr_b forKey:@"__b"];
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
/// get all Client Purchases
-(NSString *) getClientPurchases: (NSString *)idCliente{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/getComprasPorCliente.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_id = [rsa Encrypt:[NSString stringWithFormat:@"%@",idCliente]];
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
/// save client profile
-(NSString *) saveClientProfile: (NSString *) client aprendisaje:(NSString *) aprendisaje alerta:(NSString *)alerta tolerancia:(NSString *)tolerancia profile:(NSString *)profile{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/savePerfilCliente.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_id = [rsa Encrypt:[NSString stringWithFormat:@"%@",profile]];
        NSString *encr_c = [rsa Encrypt:[NSString stringWithFormat:@"%@",client]];
        NSString *encr_t = [rsa Encrypt:[NSString stringWithFormat:@"%@",tolerancia]];
        NSString *encr_a = [rsa Encrypt:[NSString stringWithFormat:@"%@",aprendisaje]];
        NSString *encr_ta = [rsa Encrypt:[NSString stringWithFormat:@"%@",alerta]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_id forKey:@"__id"];
        [request setPostValue:encr_c forKey:@"__c"];
        [request setPostValue:encr_t forKey:@"__t"];
        [request setPostValue:encr_a forKey:@"__a"];
        [request setPostValue:encr_ta forKey:@"__ta"];
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
/// save social profile
-(NSString *) saveSocialClientProfile: (NSString *) client description:(NSString *)description location:(NSString *)location socialName:(NSString *)socialName socialType:(NSString *)socialType imageUrl:(NSString *) ImageUrl socialUser:(NSString *) socialUser id: (NSString *) idSocialProfile{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/saveSocialCliente.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_id = [rsa Encrypt:[NSString stringWithFormat:@"%@",idSocialProfile]];
        NSString *encr_u = [rsa Encrypt:[NSString stringWithFormat:@"%@",socialUser]];
        NSString *encr_t = [rsa Encrypt:[NSString stringWithFormat:@"%@",socialType]];
        NSString *encr_l = [rsa Encrypt:[NSString stringWithFormat:@"%@",location]];
        NSString *encr_d = [rsa Encrypt:[NSString stringWithFormat:@"%@",description]];
        NSString *encr_ui = [rsa Encrypt:[NSString stringWithFormat:@"%@",ImageUrl]];
        NSString *encr_n = [rsa Encrypt:[NSString stringWithFormat:@"%@",socialName]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_id forKey:@"__id"];
        [request setPostValue:encr_u forKey:@"__u"];
        [request setPostValue:encr_t forKey:@"__t"];
        [request setPostValue:encr_l forKey:@"__l"];
        [request setPostValue:encr_d forKey:@"__d"];
        [request setPostValue:encr_ui forKey:@"__ui"];
        [request setPostValue:encr_n forKey:@"__n"];
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
//// Create a Client
-(NSString *) updateClient: (NSString*)Client Nombre:(NSString *)Nombre apellido:(NSString *)Apellido barrio:(NSString *)Barrio email:(NSString *)Email telefono:(NSString *)Telefono sexo:(NSString *)Sexo Uuid:(NSString *)Uuid{
    @try {
        /// url for the request
        NSURL *url = [NSURL URLWithString:@"http://bus.insituapps.com/updateCliente.ashx"];
        /// encryption helper in action allocation of memmory
        EncryptionHelper *rsa = [[EncryptionHelper alloc] init];
        /// we encrypt the data to send it
        NSString *encr_n = [rsa Encrypt:[NSString stringWithFormat:@"%@",Telefono]];
        NSString *encr_e = [rsa Encrypt:[NSString stringWithFormat:@"%@",Email]];
        NSString *encr_s = [rsa Encrypt:[NSString stringWithFormat:@"%@",Sexo]];
        NSString *encr_no = [rsa Encrypt:[NSString stringWithFormat:@"%@",Nombre]];
        NSString *encr_a = [rsa Encrypt:[NSString stringWithFormat:@"%@",Apellido]];
        NSString *encr_u = [rsa Encrypt:[NSString stringWithFormat:@"%@",Uuid]];
        NSString *encr_b = [rsa Encrypt:[NSString stringWithFormat:@"%@",Barrio]];
        NSString *encr_id = [rsa Encrypt:[NSString stringWithFormat:@"%@",Client]];
        //NSString *encr_alt = [rsa Encrypt:alt];
        /// now a new request
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:encr_n forKey:@"__n"];
        [request setPostValue:encr_e forKey:@"__e"];
        [request setPostValue:encr_s forKey:@"__s"];
        [request setPostValue:encr_no forKey:@"__no"];
        [request setPostValue:encr_a forKey:@"__a"];
        [request setPostValue:encr_u forKey:@"__u"];
        [request setPostValue:encr_b forKey:@"__b"];
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
