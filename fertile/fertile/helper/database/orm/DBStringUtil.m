//
//  DBStringUtil.m
//  CtripTest
//
//  Created by ctrip ctrip on 12-8-20.
//  Copyright (c) 2012年 1234cc. All rights reserved.
//

/***
 *  create by andy
 *  
 */

#import "DBStringUtil.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CLLocation.h>

@implementation DBStringUtil


/**
 * 判断字串是否为空
 * @param str
 * @return
 */
+(bool) emptyOrNull:(NSString *)str
{
    return str == nil || (NSNull *)str == [NSNull null] || str.length == 0;
}

@end