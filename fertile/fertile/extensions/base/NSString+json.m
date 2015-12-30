//
//  NSString+json.m
//  fertile_oc
//
//  Created by vincent on 15/10/28.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+json.h"

@implementation NSString (json)

-(id)json2Obj
{
    if (self.isEmpty)
        return nil;
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                    options:NSJSONReadingMutableLeaves
                                                      error:&error];
    if (error)
        return nil;
    else
        return jsonObject;
}

-(NSDictionary *) json2Dic
{
    id jsonObj = [self json2Obj];
    if (jsonObj && [jsonObj isKindOfClass:[NSDictionary class]])
    {
        return (NSDictionary *) jsonObj;
    }
    return nil;
}


-(NSArray *) json2Array
{
    id jsonObj = [self json2Obj];
    if (jsonObj && [jsonObj isKindOfClass:[NSArray class]])
    {
        return (NSArray *) jsonObj;
    }
    return nil;
}

@end
