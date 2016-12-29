//
//  NSURL+FTNormal.h
//  fertile
//
//  Created by vincent on 2016/12/26.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (FTNormal)

/**
 *  将URL字符串转化成key/value形式的dictionary
 *
 *  @param urlString 需要转换的url字符串
 *
 *  @return url转换成的map
 */

+ (NSDictionary *)parameterDictionary:(NSString *)urlString;

- (NSURL *)addQueryItemName:(NSString *)queryItemName value:(NSString *)value;

- (NSURL *)addFromFlagForURL;

+ (BOOL)isBlankURL:(NSURL *)url;


@end
