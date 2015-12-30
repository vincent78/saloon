//
//  NSNumber+box.h
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (box)

#pragma mark - 时间 

/**
 *  @brief  将毫秒数转成日期（距1970的毫秒数）
 *
 *  @return <#return value description#>
 */
-(NSDate *) toDateSince1970;

/**
 *  @brief  将毫秒数转成时间
 *
 *  @return 00:00:00
 */
-(NSString *) toTimeStr;

@end
