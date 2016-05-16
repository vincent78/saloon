//
//  NSDictionary+object.m
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSDictionary+FTObject.h"
#import "MJExtension.h"

@implementation NSDictionary (FTObject)

+(NSDictionary *) fromObject:(NSObject *)obj
{
    return obj.mj_keyValues;
}





@end
