//
//  NSString+Security.m
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+FTSecurity.h"

@implementation NSString (FTSecurity)


- (NSString *)MD5 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:strlen(cstr)];
    return [data MD5];
}


- (NSString *)SHA1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:strlen(cstr)];
    return [data SHA1];
}

- (NSString *)SHA256 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:strlen(cstr)];
    return [data SHA256];
}



/**
 *  将字符串进行base64 编码
 *
 *  @return base64编码之后的字符串
 */
- (NSString *)Base64EncodeToString  {
    if ([self length] == 0) {
        return nil;
    }
    
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodeToString];
}

/**
 *  字符串base64解码成字符串
 *
 *  @param base64String 需要解码的base64字符串
 *
 *  @return 解码之后的base64字符串
 */
- (NSString *)Base64DecodeToString {
    NSData *decodeData = [NSData base64DecodeToData:self];
    return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
}

/**
 *  将base64字符串解码成Data
 *
 *  @return base64字符串解码之后的Data
 */
- (NSData *)Base64DecodeToData {
    return [NSData base64DecodeToData:self];
}

@end
