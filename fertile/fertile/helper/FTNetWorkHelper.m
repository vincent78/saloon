//
//  FTNetWorkHelper.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTNetWorkHelper.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <UIKit/UIKit.h>
#import "AFNetworkReachabilityManager.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface FTNetWorkHelper() {
    
}
@property (nonatomic, strong) CTTelephonyNetworkInfo *telephonyInfo;
@property (nonatomic, assign) eNetworkType innerNetworkType;
@property (nonatomic, assign) eNetworkQuality networkQuality;
@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;
@property (nonatomic, copy) void (^networkQualityBlock)(eNetworkQuality status);

@end

@implementation FTNetWorkHelper
#pragma mark - single

static FTNetWorkHelper *sharedInstance = nil;

+(FTNetWorkHelper *) sharedInstance
{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTNetWorkHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

-(void)helperInit
{
    [super helperInit];
    
    self.telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    WS(weakSelf);
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        SS(strongSelf,weakSelf);
        [strongSelf networkChangedActionRA];
    }];
    [self.reachabilityManager startMonitoring];
    
    self.innerNetworkType = [self getNetworkType];

    
}

-(void)helperRelease
{
    
    [super helperRelease];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    
}

#pragma mark - custom area
/**
 *  @brief  清除web的缓存
 */
+ (void)clearWebCache
{
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
}

+(BOOL)checkWebCache:(NSURL *)url;
{
    NSCachedURLResponse *response =
    [[NSURLCache sharedURLCache] cachedResponseForRequest:[NSURLRequest requestWithURL:url]];
    //判断是否有缓存
    if (response != nil)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}


- (void)networkChangedActionRA
{
    eNetworkType tmpNetworkType = [self getNetworkType];
    if (self.innerNetworkType != tmpNetworkType) {
        self.innerNetworkType = tmpNetworkType;
        [self performSelectorOnMainThread:@selector(notifyNetworkChanged:) withObject:NULL waitUntilDone:NO];
    }
}


- (void)notifyNetworkChanged:(NSObject *)obj {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkDidChangedNotification object:NULL userInfo:NULL];
    [self startNetworkQualityDetect];
}


- (eNetworkType)networkType
{
    eNetworkType tmpNetworkType = self.innerNetworkType;
    
    /*可能没有监听到网络变更，增强保护*/
    if (tmpNetworkType == NetworkType_None ) {
        tmpNetworkType = [self getNetworkType];
    }
    
    return tmpNetworkType;
}

- (NSString *)networkTypeInfo
{
    NSString *ret = @"None";
    eNetworkType netType = self.networkType;
    switch (netType ) {
        case NetworkType_Unknown:
            ret = @"Unknown";
            break;
        case NetworkType_None:
            ret = @"None";
            break;
        case NetworkType_WIFI:
            ret = @"WIFI";
            break;
        case NetworkType_2G:
            ret = @"2G";
            break;
        case NetworkType_3G:
            ret = @"3G";
            break;
        case NetworkType_4G:
            ret = @"4G";
            break;
        default:
            break;
    }
    
    return ret;
}

- (BOOL)isNetworkAvaiable
{
    BOOL isReachable = [self.reachabilityManager isReachable];
    return isReachable || (self.networkType != NetworkType_None);
}

- (NSString *)carrierName
{
    NSString *provider;
    CTCarrier *carrier = self.telephonyInfo.subscriberCellularProvider;
    NSString *providerCode = [carrier mobileNetworkCode];
    
    if (providerCode == nil) {
        provider = @"无运营商信息";
    }
    else {
        provider = carrier.carrierName;
    }
    return provider;
}

- (BOOL)isFast:(NSString*)radioAccessTechnology {
    if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
        return NO;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]) {
        return NO;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA]) {
        return YES;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA]) {
        return YES;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA]) {
        return YES;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
        return YES;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
        return YES;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
        return YES;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
        return YES;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
        return YES;
    } else if ([radioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
        return YES;
    }
    
    return YES;
}

- (eNetworkType )getNetworkType {
    
    eNetworkType netType = NetworkType_None;
    AFNetworkReachabilityStatus status = [self.reachabilityManager networkReachabilityStatus];
    
    if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
        netType = NetworkType_WIFI;
    }
    else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
        BOOL isFast = [self isFast:self.telephonyInfo.currentRadioAccessTechnology];
        if (isFast) {
            if ([self.telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                netType = NetworkType_4G;
            }
            else {
                netType = NetworkType_3G;
            }
        } else {
            netType = NetworkType_2G;
        }
    }
    else if (status == AFNetworkReachabilityStatusUnknown) {
        netType = NetworkType_Unknown;
    }
    else if (status == AFNetworkReachabilityStatusNotReachable) {
        netType = NetworkType_None;
    }
    
    return netType;
}

- (void)startNetworkQualityDetect:(void (^)(eNetworkQuality status))block
{
    self.networkQualityBlock = block;
    [self startNetworkQualityDetect];
}

+ (NSString *)getWIFIIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

- (void)startNetworkQualityDetect
{
    return;//先屏蔽掉，解决启动卡死问题。
//    CTHostPinger *pinger = [[CTHostPinger alloc] init];
//    NSString *host = @"mobileap.ctrip.com";//m.google.com
//    
//    [pinger pingWithHost:host finishBlcok:^(NSString *host, NSTimeInterval pingInterval) {
//        eNetworkQuality networkQuality = eNetworkQualityInvalid;
//        
//        if (pingInterval > 0 && pingInterval < 0.1) {
//            networkQuality = eNetworkQualityExcellent;
//        } else if (pingInterval > 0.1 && pingInterval < 0.3) {
//            networkQuality = eNetworkQualityGood;
//        } else if (pingInterval > 0.3 && pingInterval < 0.5) {
//            networkQuality = eNetworkQualityModerate;
//        } else if (pingInterval > 0.5) {
//            networkQuality = eNetworkQualityPoor;
//        } else {
//            networkQuality = eNetworkQualityInvalid;
//        }
//        
//        __strong CTNetworkUtil *strongSelf = self;
//        strongSelf.networkQuality = networkQuality;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (strongSelf.networkQualityBlock) {
//                strongSelf.networkQualityBlock(networkQuality);
//            }
//        });
//    }];
}



@end
