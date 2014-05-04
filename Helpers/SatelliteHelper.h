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
-(NSString *) readPositions;
-(NSString *) readCategories;
-(NSString *) readClientCategories: (NSString *)client;
-(NSString *) readPromocionesPorCategorias: (NSString *)categorias Barrio:(NSString *)barrio;
-(NSString *) readPromocionesPorGeolocation: (NSString *)lat Longitude:(NSString *)lon Tolerance:(NSString *)tolerance Barrio:(NSString *)barrio;
-(NSString *) readPromocionesPorMercante: (NSString *)mercante;

-(NSString *) getLogoMercantePorID: (NSString *)mercante;
-(NSString *) getDistanceToPromociones: (NSString *)lat Longitude:(NSString *)lon Mercante:(NSString *)mercante;

-(NSString *) getMercantePorID: (NSString *)mercante;
-(NSString *) getPromocionPorID: (NSString *)ID;
-(NSString *) readMercantesPorMembresias: (NSString *)membresias;
-(NSString *) readBarriosPorCiudad: (NSString *)ciudad;

-(NSString *) getCiudadPorID: (NSString *)ciudad;
-(NSString *) getPaisPorID: (NSString *)pais;
-(NSString *) getPositionsPorMercante: (NSString *)mercante;
@end
