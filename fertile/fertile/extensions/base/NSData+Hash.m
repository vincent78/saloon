//
//  NSData+Hash.m
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSData+Hash.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSData (Hash)



- (NSString *)MD5 {
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5(self.bytes, (unsigned int)self.length, digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02X", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString *)SHA1 {
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (unsigned int)self.length, digest);
    for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02X", digest[i]];
    }
    return output;
}

- (NSString *)SHA256 {
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([self bytes], (unsigned int)([self length]), digest);
    for (NSInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02X", digest[i]];
    }
    return output;
}

- (NSString *)UTF8String {
    NSString *outStr = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    return outStr;
}

@end
