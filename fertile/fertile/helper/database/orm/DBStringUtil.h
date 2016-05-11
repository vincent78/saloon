//
//  DBStringUtil.h
//  CtripTest
//
//  Created by ctrip ctrip on 12-8-20.
//  Copyright (c) 2012年 1234cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBStringUtil : NSObject
/**
 判断字串是否为空
 @param str
 @return
 */
+(bool) emptyOrNull:(NSString *)str;

@end