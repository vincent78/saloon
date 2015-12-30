//
//  FTNetWorkHelper.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTNetWorkHelper.h"

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
    
}

-(void)helperRelease
{
    
    [super helperRelease];
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


@end
