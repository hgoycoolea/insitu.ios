//  Created by Hector Melo Goycolea on 12/3/11.
//  Copyright (c) 2011 Viento. All rights reserved.
#import <Foundation/Foundation.h>
#import "CkoRsa.h"
/// interface Header
@interface EncryptionHelper : NSObject
/// Encryption Method
- (NSString *) Encrypt:(NSString *)w;
/// Deencryption Method
- (NSString *) Decrypt:(NSString *)w;
@end
