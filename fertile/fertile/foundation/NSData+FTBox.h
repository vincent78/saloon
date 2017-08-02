//
//  NSData+box.h
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FTBox)

/**
 *  @brief 转成字符串
 *
 *  @return <#return value description#>
 */
-(NSString *) toString;

/**
 *  @brief 转成二进制
 *
 *  @return <#return value description#>
 */
-(Byte *) toBytes;


/**
 *  @brief 转成16进制的字符串
 *
 *  @return <#return value description#>
 */
-(NSString *) toHexString;

@end
