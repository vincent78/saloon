//
//  NSDictionary+object.h
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FTObject)

/**
 *  @brief 将对象中转换成NSDictionary
 *
 *  @param obj <#obj description#>
 */
+(NSDictionary *) fromObject:(NSObject *)obj;

@end
