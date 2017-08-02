//
//  NSMutableArray+normal.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSMutableArray+FTNormal.h"

@implementation NSMutableArray (FTNormal)

- (void)addObjectForFT:(id)obj {
    if (obj != NULL) {
        [self addObject:obj];
    }
}

-(BOOL) isContainer:(id)value compare:(BOOL (^)(id value , id obj))compare
{
    if (value && self.count >0)
    {
        for (id obj in self)
        {
            if (compare(value,obj))
            {
                return YES;
            }
        }
    }
    return NO;
}

-(void) reverse
{
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j)
    {
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];
        i++;
        j--;
    }
}


@end
