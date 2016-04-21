//
//  NSDictionary+object.m
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSDictionary+object.h"
#import "MJExtension.h"

@implementation NSDictionary (object)

+(NSDictionary *) fromObject:(NSObject *)obj
{
    return obj.mj_keyValues;
}





@end
