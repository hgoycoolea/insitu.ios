//
//  SatelliteHelper.h
//  insitu
//
//  Created by Hector Goycoolea on 3/27/14.
//  Copyright (c) 2014 Hector Goycoolea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SatelliteHelper : NSObject

-(NSString *) acknowledgeRutas: (NSString *)lat Longitude:(NSString *)lon Speed:(NSString *)speed Altitude:(NSString *)alt Client:(NSString *) client;
-(NSString *) readRutas: (NSString *)client;
-(NSString *) readPromocionesPorCategorias: (NSString *)categorias;
-(NSString *) readPromocionesPorGeolocation: (NSString *)lat Longitude:(NSString *)lon Tolerance:(NSString *)tolerance;
-(NSString *) getLogoMercantePorID: (NSString *)mercante;
@end
