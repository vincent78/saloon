//
//  NSMutableArray+normal.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSMutableArray+normal.h"

@implementation NSMutableArray (normal)

- (void)safeAddObject:(id)obj {
    if (obj != NULL) {
        [self addObject:obj];
    }
}

@end
