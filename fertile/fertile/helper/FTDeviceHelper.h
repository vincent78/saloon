//
//  FTDeviceHelper.h
//  fertile
//
//  Created by vincent on 16/3/28.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"

@interface FTDeviceHelper : FTBaseHelper
+(FTDeviceHelper *) sharedInstance;

@property (nonatomic,strong)UIDevice *device;

/**
 *  @brief 设备所有者的名称
 *
 *  @return <#return value description#>
 */
+(NSString *) ownerName;

/**
 *  @brief 设备的类别
 *
 *  @return <#return value description#>
 */
+(NSString *) model;

/**
 *  @brief 设备本地化的版本
 *
 *  @return <#return value description#>
 */
+(NSString *) localizedModel;

/**
 *  @brief 当前系统的名称
 *
 *  @return <#return value description#>
 */
+(NSString *) systemName;

/**
 *  @brief 当前系统的版本号
 *
 *  @return <#return value description#>
 */
+(NSString *) systemVersion;

@end
