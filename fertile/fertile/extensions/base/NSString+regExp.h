//
//  NSString+regExp.h
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (regExp)

-(BOOL) isValidDigit;

/**
 *  @brief  是否有效的Integer
 *
 *  @return <#return value description#>
 */
-(BOOL) isValidInteger;

/**
 *  @brief  是否数字
 *
 *  @return <#return value description#>
 */
-(BOOL)isNum;

/**
 *  @brief  是否是字母
 *
 *  @return <#return value description#>
 */
-(BOOL)isEn;

/**
 *  @brief  是否是字母或数字
 *
 *  @return <#return value description#>
 */
-(BOOL)isOnlyEnOrNum;

/**
 *  @brief  是否是中文
 *
 *  @return <#return value description#>
 */
-(BOOL)isValidCN;

/**
 *  @brief  是否正确的Email格式字符串
 *
 *  @return <#return value description#>
 */
-(BOOL)isValidEMail;


/**
 *  @brief 是否为合法的身份证号
 *
 *  @param idcard <#idcard description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) verifyID:(NSString *)idcard;

@end
