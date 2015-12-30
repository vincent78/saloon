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

@end
