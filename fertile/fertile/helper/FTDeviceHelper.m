//
//  FTDeviceHelper.m
//  fertile
//
//  Created by vincent on 16/3/28.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTDeviceHelper.h"

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
    self.device = [[UIDevice alloc] init];
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


+(NSString *) model
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




@end
