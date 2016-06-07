//
//  NSDictionary+object.m
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSDictionary+FTObject.h"

@implementation NSDictionary (FTObject)

+(NSDictionary *) fromObject:(NSObject *)obj
{
    return [obj yy_modelToJSONObject];
}





@end
