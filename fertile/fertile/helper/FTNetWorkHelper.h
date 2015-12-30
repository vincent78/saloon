//
//  FTNetWorkHelper.h
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"

@interface FTNetWorkHelper : FTBaseHelper


+(FTNetWorkHelper *) sharedInstance;



/**
 *  @brief  清除web的缓存
 */
+ (void)clearWebCache;


/**
 *  @brief  检查指定链接是否有缓存
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)checkWebCache:(NSURL *)url;


@end
