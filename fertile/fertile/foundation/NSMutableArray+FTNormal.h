//
//  NSMutableArray+normal.h
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (FTNormal)

- (void)addObjectForFT:(id)obj;


/**
 *  @brief 判断数组中是否包含指定的对象
 *
 *  @param value   <#value description#>
 *  @param compare <#compare description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) isContainer:(id)value compare:(BOOL (^)(id value , id obj))compare;


-(void) reverse;

@end
