//
//  ClientHelper.h
//  insitu
//
//  Created by Hector Goycoolea on 18-05-14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//
#import <Foundation/Foundation.h>
/// interface client helper
@interface ClientHelper : NSObject
/// Buy Promotion from and id and client id
-(NSString *) buyPromotionID: (NSString *) idPromotion andClient:(NSString *) idClient;
/// Change Promotion State
-(NSString *) changePromotionState: (NSString *)State andPromotionID:(NSString *) idPromotion;
//// Create a Client
-(NSString *) createClient: (NSString *)Nombre apellido:(NSString *)Apellido barrio:(NSString *)Barrio email:(NSString *)Email telefono:(NSString *)Telefono sexo:(NSString *)Sexo Uuid:(NSString *)Uuid;
/// get all Client Purchases
-(NSString *) getClientPurchases: (NSString *)idCliente;
/// save client profile
-(NSString *) saveClientProfile: (NSString *) client aprendisaje:(NSString *) aprendisaje alerta:(NSString *)alerta tolerancia:(NSString *)tolerancia profile:(NSString *)profile;
/// save social profile
-(NSString *) saveSocialClientProfile: (NSString *) client description:(NSString *)description location:(NSString *)location socialName:(NSString *)socialName socialType:(NSString *)socialType imageUrl:(NSString *) ImageUrl socialUser:(NSString *) socialUser  id: (NSString *) idSocialProfile;
//// Create a Client
-(NSString *) updateClient: (NSString*)Client Nombre:(NSString *)Nombre apellido:(NSString *)Apellido barrio:(NSString *)Barrio email:(NSString *)Email telefono:(NSString *)Telefono sexo:(NSString *)Sexo Uuid:(NSString *)Uuid;
@end
