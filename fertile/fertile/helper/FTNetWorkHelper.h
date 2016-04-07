//
//  FTNetWorkHelper.h
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"

typedef  NS_ENUM(NSInteger,FTNetworkType)
{
    FTNetworkType_UNKNOW = -1,
    FTNetworkType_NONE = 0,
    FTNetworkType_WIFI,
    FTNetworkType_2G,
    FTNetworkType_3G,
    FTNetworkType_4G,
    FTNetworkType_5G,
};

typedef NS_ENUM(NSInteger,FTNetworkQuality)
{
    FTNetworkQuality_Invalid = 0,
    FTNetworkQuality_Poor,
    FTNetworkQuality_Moderate,
    FTNetworkQuality_Good,
    FTNetworkQuality_Excellent,
};



typedef enum eNetworkType {
    NetworkType_Unknown = -1,
    NetworkType_None = 0,
    NetworkType_WIFI = 1,
    NetworkType_2G = 2,
    NetworkType_3G = 3,
    NetworkType_4G = 4
} eNetworkType;

typedef enum eNetworkQuality {
    eNetworkQualityInvalid = 0,
    eNetworkQualityPoor,
    eNetworkQualityModerate,
    eNetworkQualityGood,
    eNetworkQualityExcellent
} eNetworkQuality;

//网络状态变更的时候通知
#define  kNetworkDidChangedNotification @"kNetworkDidChangedNotification"

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




/*当前网络类型，None,WIFI,2G,3G,4G*/
@property (nonatomic, readonly) eNetworkType networkType;

/*当前网络类型描述，None,WIFI,2G,3G,4G*/
@property (nonatomic, readonly) NSString *networkTypeInfo;

/*当前网络是否可用*/
@property (nonatomic, readonly) BOOL isNetworkAvaiable;

/*当前运营商*/
@property (nonatomic, readonly) NSString *carrierName;

/*当前网络速度*/
@property (nonatomic, readonly) eNetworkQuality networkQuality;

- (void)startNetworkQualityDetect:(void (^)(eNetworkQuality status))block;
+ (NSString *)getWIFIIPAddress;


@end
