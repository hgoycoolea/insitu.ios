//  Created by Hector Melo Goycolea on 12/3/11.
//  Copyright (c) 2011 Viento. All rights reserved.
#import "EncryptionHelper.h"
/// Chillkat Import
#import "CkoRsa.h"
/// Implementation for the Helper Header
@implementation EncryptionHelper
/// public key for the communication with the server
NSString *publicKey = @"<BitStrength>2048</BitStrength><RSAKeyValue><Modulus>lLTUuYOXpEub1k3tF+1ZVbyT5R0mxF6zoyGOgh1N4ULxUT5l5ZZ7DMzeaGGEt7Zxus8oD9QVW6Xwf0AOj/R/14pi9UWCjJySb6UslinF+MGqOdS/BNK5vh2xgCYaiEzXHiDj6hsjllVdmYK79qtFRn08ABY4y7qTrCfJmB6OVw+rkj1aBb+VPh/vDEkd/ycNxcCKOCGdfHZ0xJ3NzpjsAjafh/mxww3jqvdzNX/+XisfJOTOxVmAxYFTnhaU3dnwyxiUjhHukDh8mRI/Jp+8WfnpUzsQoK8sZiRJot4SA8XJwbuIZvHeI4DDriUXMx44KcrwPGKchKB7U6r+/k/71w==</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>";
/// private key for the communication with the server
NSString *privateKey = @"<BitStrength>2048</BitStrength><RSAKeyValue><Modulus>lLTUuYOXpEub1k3tF+1ZVbyT5R0mxF6zoyGOgh1N4ULxUT5l5ZZ7DMzeaGGEt7Zxus8oD9QVW6Xwf0AOj/R/14pi9UWCjJySb6UslinF+MGqOdS/BNK5vh2xgCYaiEzXHiDj6hsjllVdmYK79qtFRn08ABY4y7qTrCfJmB6OVw+rkj1aBb+VPh/vDEkd/ycNxcCKOCGdfHZ0xJ3NzpjsAjafh/mxww3jqvdzNX/+XisfJOTOxVmAxYFTnhaU3dnwyxiUjhHukDh8mRI/Jp+8WfnpUzsQoK8sZiRJot4SA8XJwbuIZvHeI4DDriUXMx44KcrwPGKchKB7U6r+/k/71w==</Modulus><Exponent>AQAB</Exponent><P>w0MQ0fkeEWAOMJgrSXH5Az+6/+aRSHwCCgNlS6q9jGpB48YlawsPCF+4dbYHtDWyaEmZ4tyNd5sHE174in50T6Ulir4186WeBZUUXWKTJ9nk27T0kOPpGwm+WxGU4FibDXycD8M6I1ZGDo5bLiW5BKSv5KkZ6IzWxsP0axB89OU=</P><Q>wvZ9P5CirRZcxtdS/MCNCEWnjMNbxlbK4YDLZ+Mw/9aLaAYbc2447wPgbq40sREFAU9QAJqWwXTqz3PS8SW7QUuX6BanN8ruTE4MN5O4UNauOzVXKgT4d0OIBQLKO3qkCPUXMUjX+f7jfEUX5fGqIW8BlcgYpjVxJLnecIb6Pgs=</Q><DP>aIhl39Ma6rhewFsmiVovsjKTHN5FluV0fgHVX83XTe2wuozgiU7RTG1aJgI+W5aHnVcRwCbMwWRIRHGKYzJReDX0RDOSVI6sa1alIV1dZG89GvXkHBE3QRdVRhHCftxQncbBEZs1a6eLN820OJ9PTpIP7D0vNpT3gk9zcUHRc5U=</DP><DQ>eYpgmnf4ch82x18FBTykrzt9MGu5kvQYlmxMYf9oVJXTYo4sHtHf/GFWUKmZf6k0jZR8M2QsB35zw9BY+KylCBewI6e7pzSDSl59j0gv53VuOMsQA8oFe5RF/5m1qU7TZCImyzq2KcuU1avdMiRuA1nIiy+q7jLyzgpxeYUsC/E=</DQ><InverseQ>l9Diz9ShXMFGrXWwxYEaaa3yEwC3usLbZkR43nyyKGv+UGS3S96ABOmV5y8tZnXI/8uzhfE4OpiJNdwXtQzdbjeRrT7FZ2Xinit9ITfuEspG+5pu9ghR5DurCVoB3TtVTDKZGvtlwPKch65Mu9V5Zi943WoRotbVwER1J6RiKF4=</InverseQ><D>g7KWxul1DitsC2KePNeWi6jkLkAgCj94xlu8sx0y0PIReAtUAP3BYne57SWYfX9Vv8UhTMteUvlmQbxAaVt3MTO9Kk1yLgeoZLoa/65lR0Z09Jymw6XAnE/92GlmjBnJVkR4tOduIADgUUkIIJBUXPYigk0r5boKeKgQEOnW0+CSULWD81ShcOKjfLfkYLSjos/a8+s2AapFBMrbOjPpdAhNAO7SKP7hn99tioVcevmd6ifB51SmenRbx59t6rUqCN82waipuk4m0VYCjKTD+641YHu+JXcwJx+5bdqhPB6/hXyffSq2vcdfcce/mvqVLP9FZDrdpKX8VL4DtFz/qQ==</D></RSAKeyValue>";
/*
 * (NSString *) Decrypt
 */
- (NSString *) Decrypt: (NSString *)w
{
    NSMutableString *strOutput = [NSMutableString stringWithCapacity:1000];
    
    CkoRsa *rsa = [[[CkoRsa alloc] init] autorelease];
    
    BOOL success = [rsa UnlockComponent:@"VIENTORSA_TbpfVVr01Or6"];
    
    if(success != YES){
        NSLog(@"Licence Invalid");
    }

    //CkoRsa *rsa = [[[CkoRsa alloc] init] autorelease];
    
    //BOOL success;
    //success = [rsa UnlockComponent: @"Anything for 30-day trial"];
    //if (success != YES) {
        //[strOutput appendString: @"RSA component unlock failed"];
        //[strOutput appendString: @"\n"];
        //self.mainTextField.stringValue = strOutput;
        //return;
    //}
    
    //  This example also generates the public and private
    //  keys to be used in the RSA encryption.
    //  Normally, you would generate a key pair once,
    //  and distribute the public key to your partner.
    //  Anything encrypted with the public key can be
    //  decrypted with the private key.  The reverse is
    //  also true: anything encrypted using the private
    //  key can be decrypted using the public key.
    
    //  Generate a 1024-bit key.  Chilkat RSA supports
    //  key sizes ranging from 512 bits to 4096 bits.
    //  Keys are exported in XML format:
    NSString *plainText;
    plainText = @"Encrypting and decrypting should be easy!";
    
    BOOL usePrivateKey;
    usePrivateKey = NO;
    //NSString *encryptedStr;
    
    //  Now decrypt:
    CkoRsa *rsaDecryptor = [[[CkoRsa alloc] init] autorelease];
    
    rsaDecryptor.EncodingMode = @"hex";
    [rsaDecryptor ImportPrivateKey: privateKey];
    
    usePrivateKey = YES;
    NSString *decryptedStr;
    decryptedStr = [rsaDecryptor DecryptStringENC: w bUsePrivateKey: usePrivateKey];
    
    [strOutput appendString: decryptedStr];
    [strOutput appendString: @"\n"];
    
    return  strOutput;
    //self.mainTextField.stringValue = strOutput;

}
/*
 * (NSString *) Encrypt
 */
- (NSString *) Encrypt:(NSString *)w
{
    NSMutableString *strOutput = [NSMutableString stringWithCapacity:1000];
    
    CkoRsa *rsa = [[[CkoRsa alloc] init] autorelease];
    
    BOOL success = [rsa UnlockComponent:@"VIENTORSA_TbpfVVr01Or6"];
    
    if(success != YES){
        NSLog(@"Licence Invalid");
    }
    //  Start with a new RSA object to demonstrate that all we
    //  need are the keys previously exported:
    CkoRsa *rsaEncryptor = [[[CkoRsa alloc] init] autorelease];
    //  Encrypted output is always binary.  In this case, we want
    //  to encode the encrypted bytes in a printable string.
    //  Our choices are "hex", "base64", "url", "quoted-printable".
    rsaEncryptor.EncodingMode = @"base64";
    //  We'll encrypt with the public key and decrypt with the private
    //  key.  It's also possible to do the reverse.
    [rsaEncryptor ImportPublicKey: publicKey];

    NSString *encryptedStr = [rsaEncryptor EncryptStringENC: w bUsePrivateKey: NO];
    [strOutput appendString: encryptedStr];
    return strOutput;
}
@end
