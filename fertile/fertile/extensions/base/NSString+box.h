//
//  NSString+box.h
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (box)

/**
 *  @brief 转成日期类型
 *
 *  @param formatStr <#formatStr description#>
 *
 *  @return <#return value description#>
 */
-(NSDate *)toDate:(NSString *)formatStr;


-(int) toInt;

-(NSInteger) toInteger;

-(float) toFloat;

/**
 *  @brief 转成ascii
 *
 *  @return <#return value description#>
 */
-(int) toAscii;
/**
 *  @brief 转成ascii
 *
 *  @param position 以0开头的位置
 *
 *  @return <#return value description#>
 */
-(int) toAscii:(int)position;

/**
 *  @brief 从ASCII转换
 *
 *  @param num <#num description#>
 *
 *  @return <#return value description#>
 */
-(NSString *) fromAscii:(int)num;

/**
 *  @brief 替换UNICODE
 *
 *  @param unicodeStr <#unicodeStr description#>
 *
 *  @return <#return value description#>
 */
-(NSString *)fromUnicode;

/**
 *  @brief 转成UNICODE
 *
 *  @return <#return value description#>
 */
-(NSString *) toUnicode;

/**
 *  @brief 转换成16进制的字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)toHexString;

/**
 *  @brief 从16进制的字符串转成字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)fromHexString;

/**
 *  @brief 转成NSData
 *
 *  @return <#return value description#>
 */
-(NSData *) toNSData;

@end
