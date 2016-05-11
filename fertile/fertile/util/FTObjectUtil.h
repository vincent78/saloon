//
//  FTObjectUtil.h
//  fertile
//
//  Created by vincent on 16/5/10.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTObjectUtil : NSObject

/**
 *  @brief 获取所有的属性
 *
 *  @return <#return value description#>
 */
- (NSArray *)getAllProperties;

/**
 *  @brief 获取所有的属性及值
 *
 *  @return <#return value description#>
 */
- (NSDictionary *)getAllPropertiesAndValue;

/**
 *  @brief 获取所有的成员变量和属性
 *
 *  @param className <#className description#>
 *
 *  @return <#return value description#>
 */
-(NSArray *) getAllIvars:(NSString *)className;
/**
 *  @brief 获取对象的所有方法
 */
-(NSMutableArray *)getAllMethods;


@end
