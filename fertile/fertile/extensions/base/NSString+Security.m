//
//  NSString+Security.m
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+Security.h"

@implementation NSString (Security)


- (NSString *)MD5 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data MD5];
}

@end
