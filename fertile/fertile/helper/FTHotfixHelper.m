//
//  FTHotfixHelper.m
//  fertile_oc
//
//  Created by vincent on 15/11/18.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTHotfixHelper.h"

@implementation FTHotfixHelper

static FTHotfixHelper *sharedInstance = nil;

+(FTHotfixHelper *) sharedInstance
{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTHotfixHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

/**
 *  @brief  初始化
 */
- (void)helperInit
{
    
}
/**
 *  @brief  重置
 */
- (void)helperRelease
{
    
}

- (void)didReceiveMemoryWarning
{
    
}

@end
