//
//  NSArray+normal.h
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FTNormal)

- (id)objectAtIndexForFT:(NSUInteger)index;

- (NSArray *)subarrayWithRangeForFT:(NSRange)range;

@end