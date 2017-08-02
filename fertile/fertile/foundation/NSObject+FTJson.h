//
//  NSObject+FTJson.h
//  fertile
//
//  Created by vincent on 16/6/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FTJson)


/**
 *  @brief 对象转为json字符串
 *
 *  @return <#return value description#>
 */
-(nullable NSString *) ftModel2JsonStr;

/**
 *  @brief 对象转为json对象
 *
 *  @return <#return value description#>
 */
-(nullable id) ftModel2JsonObj;

/**
 *  @brief 将JSON对象转为对象
 *
 *  @param json <#json description#>
 *
 *  @return <#return value description#>
 */
+ (nullable instancetype)ftModelWithJSON:(nonnull id)json;

@end
