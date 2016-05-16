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

@end
