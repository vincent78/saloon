//
//  NSObject+FTProperty.m
//  fertile
//
//  Created by vincent on 16/5/16.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSObject+FTProperty.h"

static NSString * FT_OBJECT_PROPERTY_TAGOBJ = @"com.fruit.fertile.object.property.tagobj";


@implementation NSObject (FTProperty)

- (id) ftTagObj {
    return objc_getAssociatedObject(self, (__bridge const void *)FT_OBJECT_PROPERTY_TAGOBJ)  ;
}

- (void) setFtTagObj:(id)ftTagObj {
    objc_setAssociatedObject(self, (__bridge const void *)FT_OBJECT_PROPERTY_TAGOBJ, ftTagObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




-(id) getPropertyValueByString:(NSString *)key
{
    if ([NSString emptyOrNil:key])
    {
        return nil;
    }
    __block id tmpObj = self;
    NSArray *properties = [key componentsSeparatedByString:@"."];
    [properties bk_each:^(id  _Nonnull obj) {
        if (tmpObj)
        {
            tmpObj = [tmpObj valueForKey:(NSString *)obj];
        }
    }];
    return tmpObj;
}

-(void) setPropertyByString:(NSString *)name withValue:(id)value
{
    if ([NSString emptyOrNil:name])
    {
        return ;
    }
    
    if (value
        && ([value respondsToSelector:@selector(copyWithZone:)] || [value respondsToSelector:@selector(mutableCopyWithZone:)]) )
    {
        value = [value copy];
    }
    
    
    __block id tmpObj = self;
    NSString *propertyName = @"";
    NSMutableArray *properties = [[name componentsSeparatedByString:@"."] mutableCopy];
    propertyName = [properties lastObject];
    [properties removeLastObject];
    [properties bk_each:^(id  _Nonnull obj) {
        if (tmpObj)
        {
            tmpObj = [tmpObj valueForKey:(NSString *)obj];
        }
    }];
    if (tmpObj)
    {
        SEL seletor = NSSelectorFromString(propertyName);
        if ([tmpObj respondsToSelector:seletor])
        {
            [tmpObj setValue:value forKey:propertyName];
        }
    }
}

@end
