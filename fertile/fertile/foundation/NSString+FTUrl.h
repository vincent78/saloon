//
//  NSString+FTUrl.h
//  fertile
//
//  Created by vincent on 16/5/19.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FTUrl)

/**
 *  字符串转换成URL对象，#会在内部处理
 *
 *  @return 转换成的URL对象
 */
- (NSURL *)toURL;

/**
 *  对URL做UTF8编码
 *
 *  @return UTF8编码之后的URL字符串
 */
- (NSString *)URLEncode;
/**
 *  对NSString做URLEncode编码
 *
 *  @return NSString的URLEncode字符串
 */
- (NSString *)stringURLEncoded;

/**
 *  对NSString做URLDecoded编码
 *
 *  @return NSString的URLDecoded字符串
 */
-(NSString *)stringURLDecode;

/**
 *  对NSString做URIEncoded编码
 *
 *  @return NSString的URIEncoded字符串
 */
-(NSString*)encodeAsURIComponent;

/**
 *  对URL做UTF8解码
 *
 *  @return UTF8解码之后的URL字符串
 */
- (NSString *)URLDecode;

/**
 *  @brief 获取URL的scheme   http  https
 *
 *  @return <#return value description#>
 */
- (NSString *)getURLScheme;


- (NSString *)getURLResourceSpecifier;

- (NSNumber *)getURLPort;

- (NSString *)getURLQueryString;

- (NSArray *)getURLQueryArray;

- (NSString *)getURLParameterString;


- (NSString *)encodeURLComponent;

- (NSString *)decodeURLComponent;



@end
