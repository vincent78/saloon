//
//  NSMutableDictionary+normal.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSMutableDictionary+normal.h"

@implementation NSMutableDictionary (normal)

- (void)setSafeObject:(id)anObject forKey:(id)aKey {
    if (aKey == nil) {
        NSAssert(false, @"aKey is NULL, crashed");
    }
    else if ([aKey isKindOfClass:[NSString class]]) {
        [self setValue:anObject forKey:aKey];
    }
    else if ([aKey conformsToProtocol:@protocol(NSCopying)]) {
        if (anObject == NULL) {
            [self removeSafeObjectForKey:aKey];
        }
        else {
            [self setObject:anObject forKey:aKey];
        }
    }
}

- (void)removeSafeObjectForKey:(id)aKey
{
    if (!aKey) {
        NSAssert(false, @"aKey is NULL, crashed");
    } else if ([aKey conformsToProtocol:@protocol(NSCopying)]) {
        [self removeObjectForKey:aKey];
    }
}

@end
