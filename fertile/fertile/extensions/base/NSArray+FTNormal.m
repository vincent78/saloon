//
//  NSArray+normal.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSArray+FTNormal.h"

@implementation NSArray (FTNormal)

- (id)objectAtIndexForFT:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (NSArray *)subarrayWithRangeForFT:(NSRange)range
{
    if (range.location+range.length <= self.count)
    {
        return [self subarrayWithRange:range];
    }
    else
    {
        FTLog(@"count:%lu MakeRage(%lu,%lu)", (unsigned long)self.count, (unsigned long)range.location, (unsigned long)range.length);
        return nil;
    }
}

@end
