//
//  EncryptM.m
//  EncryptTest
//
//  Created by Roicxy Alonso on 12/28/17.
//  Copyright © 2017 Roicxy Alonso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncryptM.h"

@implementation EncryptM: NSObject
+(void) sRandom:(unsigned int)seed
{
    srandom(seed);
}
+(double) randomN: (double) limit
{
    return random() % (int)(limit);
}
@end
