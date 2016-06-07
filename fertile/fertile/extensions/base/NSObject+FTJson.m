//
//  NSObject+FTJson.m
//  fertile
//
//  Created by vincent on 16/6/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSObject+FTJson.h"

@implementation NSObject (FTJson)

-(NSString *) ftModel2JsonStr
{
    return [self yy_modelToJSONString];
}

-(id) ftModel2JsonObj
{
    return [self yy_modelToJSONObject];
}


+ (nullable instancetype)ftModelWithJSON:(id)json
{
    return [self yy_modelWithJSON:json];
}

@end
