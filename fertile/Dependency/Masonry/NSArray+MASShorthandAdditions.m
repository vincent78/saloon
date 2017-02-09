//
//  TestModel.m
//  TestRefrence
//
//  Created by tczhu on 16/6/27.
//  Copyright © 2016年 ztc. All rights reserved.
//

#import "NSArray+MASShorthandAdditions.h"

#ifdef MAS_SHORTHAND

@implementation NSArray (MASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end

#endif
