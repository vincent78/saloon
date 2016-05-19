//
//  NSObject+FTProperty.h
//  fertile
//
//  Created by vincent on 16/5/16.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FTProperty)

/**
 *  @brief 自定义的属性
 */
@property(nonatomic, strong) id ftTagObj ;



/**
 *  @brief 按字符串获取属性 支持多级
 *
 *  @param key 属性的字符串（xxx.xxx）
 *
 *  @return <#return value description#>
 */
-(id) getPropertyValueByString:(NSString *)key;

/**
 *  @brief 按字符串设置属性  支持多级
 *
 *  @param name  属性的字符串（xxx.xxx）
 *  @param value <#value description#>
 */
-(void) setPropertyByString:(NSString *)name withValue:(id)value;

@end
