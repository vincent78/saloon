//
//  FTDeviceHelper.m
//  fertile
//
//  Created by vincent on 16/3/28.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTDeviceHelper.h"

#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AdSupport/AdSupport.h>

@interface FTDeviceHelper()
{
}

@end

@implementation FTDeviceHelper

#pragma mark - single

static FTDeviceHelper *sharedInstance = nil;

+(FTDeviceHelper *) sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTDeviceHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

- (void)helperInit
{
    self.device = [UIDevice currentDevice];
    
}

-(void)helperRelease
{
    self.device = nil;
}

#pragma mark - custom area

+(NSString *) ownerName
{
    return FTDeviceHelper.sharedInstance.device.name;
}

+(NSString *) systemModel
{
    return FTDeviceHelper.sharedInstance.device.model;
}

+(NSString *) localizedModel
{
    return FTDeviceHelper.sharedInstance.device.localizedModel;
}

+(NSString *) systemName
{
    return FTDeviceHelper.sharedInstance.device.systemName;
}

+(NSString *) systemVersion
{
    return FTDeviceHelper.sharedInstance.device.systemVersion;
}

+(NSString *) unameInfo
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

}



+ (NSString *)macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0)
    {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
    {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = (char *)malloc(len)) == NULL)
    {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
    {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}

#pragma mark 不带冒号的mac地址

+ (NSString *)macaddressWithoutColon
{
    return [[self macaddress] stringByReplacingOccurrencesOfString:@":" withString:@""];
}
#pragma mark 根据Mac地址加密取唯一串

+ (NSString *)uniqueIdentifierWithMac
{
    NSString *macaddress = [self macaddress];
    NSString *uniqueIdentifier = [macaddress MD5];
    
    return uniqueIdentifier;
}

+ (NSString *)getDeviceInfo
{
    NSString *uuid = [self uniqueIdentifierWithMac];
    //Mac
    NSString *macAddress = [self macaddressWithoutColon];//注意:此macAddress需要去掉冒号.使用[CTDevice macaddressWithoutColon]
    //厂商
    NSString *vendor = @"Apple";
    //操作系统的版本
    NSString *systemVersion = [self systemVersion];
    NSString *systemName = [self systemName];
    //IDFA
    NSString *idfaString = @"";
    
    idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if(idfaString.length <= 0){
        idfaString = @"";
    }
    
    NSString *model = [self systemModel];
    
    NSString *retStr = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@|%@|%@"
                        ,uuid
                        ,vendor
                        ,model
                        ,macAddress
                        ,systemName
                        ,systemVersion
                        ,idfaString
                        ,[self ownerName]
                        ,[self unameInfo]
                        ];
    
    return retStr;
}



//+ (NSString *)deviceString
//{
//    struct utsname systemInfo;
//    uname(&systemInfo);
//    NSString* deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//    
//    if ([deviceString isEqualToString:@"iPhone1,1"]) {
//        return @"iPhone 1G";
//    }
//    else if([deviceString isEqualToString:@"iPhone1,2"]){
//        return @"iPhone 3G";
//    }
//    else if([deviceString hasPrefix:@"iPhone2,"]){
//        return @"iPhone 3GS";
//    }
//    else if([deviceString hasPrefix:@"iPhone3,"]){
//        return @"iPhone 4";
//    }
//    else if([deviceString hasPrefix:@"iPhone4,"]){
//        return @"iPhone 4S";
//    }
//    else if([deviceString hasPrefix:@"iPhone5,1"] || [deviceString hasPrefix:@"iPhone5,2"]){
//        return @"iPhone 5";
//    }
//    else if([deviceString hasPrefix:@"iPhone5,3"] || [deviceString hasPrefix:@"iPhone5,4"]){
//        return @"iPhone 5c";
//    }
//    else if([deviceString hasPrefix:@"iPhone6,"]){
//        return @"iPhone 5s";
//    }
//    else if([deviceString hasPrefix:@"iPhone7,2"]){
//        return @"iPhone 6";
//    }
//    else if([deviceString hasPrefix:@"iPhone7,1"]){
//        return @"iPhone 6 Plus";
//    }
//    else if([deviceString hasPrefix:@"iPhone8,1"])
//    {
//        return @"iPhone 6s";
//    }
//    else if([deviceString hasPrefix:@"iPhone8,2"])
//    {
//        return @"iPhone 6s Plus";
//    }
//    else if([deviceString hasPrefix:@"iPod1,"]) {
//        return @"iPod Touch 1G";
//    }
//    else if([deviceString hasPrefix:@"iPod2,"]) {
//        return @"iPod Touch 2G";
//    }
//    else if([deviceString hasPrefix:@"iPod3,"]) {
//        return @"iPod Touch 3G";
//    }
//    else if([deviceString hasPrefix:@"iPod4,"]) {
//        return @"iPod Touch 4G";
//    }
//    else if([deviceString hasPrefix:@"iPod5,"]) {
//        return @"iPod Touch 5G";
//    }
//    else if([deviceString hasPrefix:@"iPad1,"]) {
//        return @"iPad 1G";
//    }
//    else if([deviceString hasPrefix:@"iPad2,1"]||[deviceString hasPrefix:@"iPad2,2"]||[deviceString hasPrefix:@"iPad2,3"]||[deviceString hasPrefix:@"iPad2,4"]) {
//        return @"iPad 2";
//    }
//    else if([deviceString hasPrefix:@"iPad3,1"]||[deviceString hasPrefix:@"iPad3,2"]||[deviceString hasPrefix:@"iPad3,3"]) {
//        return @"iPad 3";
//    }
//    else if([deviceString hasPrefix:@"iPad3,4"]||[deviceString hasPrefix:@"iPad3,5"]||[deviceString hasPrefix:@"iPad3,6"]) {
//        return @"iPad 4";
//    }
//    else if([deviceString hasPrefix:@"iPad4,1"]||[deviceString hasPrefix:@"iPad4,2"]||[deviceString hasPrefix:@"iPad4,3"]) {
//        return @"iPad Air";
//    }
//    else if([deviceString hasPrefix:@"iPad2,5"]||[deviceString hasPrefix:@"iPad2,6"]||[deviceString hasPrefix:@"iPad2,7"]) {
//        return @"iPad mini 1G";
//    }
//    else if([deviceString hasPrefix:@"iPad4,4"]||[deviceString hasPrefix:@"iPad4,5"]||[deviceString hasPrefix:@"iPad4,6"]) {
//        return @"iPad mini 2G";
//    }
//    else if ([deviceString isEqualToString:@"i386"] || [deviceString isEqualToString:@"x86_64"])
//    {
//        return @"Simulator";
//    }
////    (@"NOTE: Unknown device type: %@", deviceString);
//    
//    return deviceString;
//}




@end
