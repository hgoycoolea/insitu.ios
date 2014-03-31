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
-(NSString *) readPromocionesPorCategorias: (NSString *)categorias Barrio:(NSString *)barrio;
-(NSString *) readPromocionesPorGeolocation: (NSString *)lat Longitude:(NSString *)lon Tolerance:(NSString *)tolerance Barrio:(NSString *)barrio;
-(NSString *) getLogoMercantePorID: (NSString *)mercante;
-(NSString *) getDistanceToPromociones: (NSString *)lat Longitude:(NSString *)lon Mercante:(NSString *)mercante;
@end
