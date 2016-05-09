//
//  FTThreadHelper.h
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"

@interface FTThreadHelper : FTBaseHelper

+(FTThreadHelper *) sharedInstance;



/**
 *  @brief  在系统默认的串行队列中运行
 *
 *  @param block <#block description#>
 */
-(void) doInDefaultSerialQueue:(void(^)(void))block;


/**
 *  @brief 运行在主线程中
 */
void FTExecuteOnMainThread(dispatch_block_t block, BOOL sync);




// Execute the specified block on the main thread. Unlike dispatch_sync/async
// this will not context-switch if we're already running on the main thread.
FT_EXTERN void FTExecuteOnMainThread(dispatch_block_t block, BOOL sync);

@end

