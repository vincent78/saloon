//
//  NSString+regExp.h
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FTRegExp)

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
 *  对字符中全角字符的验证
 *
 *  @param aString 需要判断的字符串
 *
 *  @return YES:是全角 NO:不是全角
 */
-(BOOL) isValidSBCWithString;

/**
 *  @brief  是否正确的Email格式字符串
 *
 *  @return <#return value description#>
 */
-(BOOL)isValidEMail;


/**
 * 验证输入的手机号是否正确 长度为11位，第一个数字是1
 手机格式验证     移动：134X(0-8)、135-9、150-1、157X(0-79)(TD)、158-9、182 -4、187（3G4G)、188(3G)、147(数据卡）、178（4G）
 联通：130-2、152、155-6、185-6(3G)、145(数据卡）、176（4G）
 电信：180-1(3G)、189(3G)、133、153、（1349卫通） 、177（4G）
 虚拟运营商：170
 * @param mobile
 * @return
 */
-(BOOL) isMobileNumber:(NSString *) mobile;

/**
 *  @brief 是否为合法的身份证号
 *
 *  @param idcard <#idcard description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) verifyID:(NSString *)idcard;

@end
