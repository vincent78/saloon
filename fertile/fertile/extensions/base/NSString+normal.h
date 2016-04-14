//
//  NSString+normal.h
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (normal)

/**
 *  @brief  是否为空字符串
 *
 *  @return <#return value description#>
 */
-(BOOL)isEmpty;

/**
 *  @brief  判断是否为空，字符串长度不为0
 *
 *  @param obj <#obj description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)emptyOrNil:(id)obj;

/**
 *  @brief  是否包含子串
 *
 *  @param subStr <#subStr description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) isContainer:(NSString *) subStr;


/**
 *  @brief  是否包含子串（忽略大小写）
 *
 *  @param subStr <#subStr description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) isContainerIgnoreCase:(NSString *)subStr;


/**
 *  @brief  去掉左边的空格
 *
 *  @return <#return value description#>
 */
-(NSString *)trimLeft;

/**
 *  @brief  去掉右边的空格
 *
 *  @return <#return value description#>
 */
-(NSString *)trimRight;


/**
 *  @brief  去掉两边的空格
 *
 *  @return <#return value description#>
 */
-(NSString *)trim;


/**
 *  @brief 去掉字符串中所有的空格（包括中间的空格）
 *
 *  @return <#return value description#>
 */
-(NSString *) replaceBlankString;

/**
 *  @brief 是否为纯数字
 *
 *  @return <#return value description#>
 */
-(BOOL) isPureInt;

/**
 *  @brief 将字符串按lengthes的长度分成n段，并用separateStr连接起来
 
 NSString *sourceStr = @"13512154768123";
 NSLog(@"the target str is :%@",[sourceStr join:@" " withLength:@3,@4, nil]);
 
 *
 *  @param subStr   <#subStr description#>
 *  @param position <#position description#>
 *
 *  @return <#return value description#>
 */
-(NSString *) join:(NSString *)separateStr withLength:(id)lengthes,...NS_REQUIRES_NIL_TERMINATION;

#pragma mark - static function
/**
 *  @brief  获取随机的UUID
 *
 *  @return <#return value description#>
 */
+ (NSString *)UUID;




@end
