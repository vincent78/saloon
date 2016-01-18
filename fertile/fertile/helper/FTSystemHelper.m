//
//  FTSystemHelper.m
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTSystemHelper.h"

#import <sys/sysctl.h>
#import <mach/mach.h>
#import <CoreText/CoreText.h>

@interface FTSystemHelper () {
}

@end

@implementation FTSystemHelper

#pragma mark - single

static FTSystemHelper* sharedInstance = nil;
static NSMutableArray* ftFontArray = nil;

+ (FTSystemHelper*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTSystemHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

- (void)helperInit
{
    [super helperInit];
    NSString * path = [FTFileUtil getResFullPath:@"common" ofType:@"ttf" withFramework:@"fertile" ];
    [FTSystemHelper registFont:path];
    
//    [FTSystemHelper printSysAllFontInfo];
    
#ifdef DEBUGr
    NSLog(@"screenHeight: %f",[FTSystemHelper screenHeight]);
    NSLog(@"screenWidth: %f",[FTSystemHelper screenWidth]);
    NSLog(@"scale:%f",[FTSystemHelper scale]);
#endif
}

- (void)helperRelease
{

    [super helperRelease];
    
    [ftFontArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [FTSystemHelper unregistFont:(NSString *)obj];
    }];
    [ftFontArray removeAllObjects];
    ftFontArray = nil;
}

- (void)didReceiveMemoryWarning
{
}

#pragma mark - custom area

#pragma mark - 系统属性

+ (CGFloat)statusBarHeight
{
    return 20.0f;
}

+ (CGFloat)navBarHeight
{
    return 44.0f;
}

+ (CGFloat)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)scale
{
    return [UIScreen mainScreen].scale;
}

+(CGFloat) onePixeWidth
{
    return 1 / [UIScreen mainScreen].scale;
}



+ (CGFloat)singleLineAdjustOffset
{
    return (1 / [UIScreen mainScreen].scale) / 2;
}

#pragma mark - 字体相关

+ (void)printSysAllFontInfo
{
    NSLog(@"======================================");
    for (NSString* fontfamilyname in [UIFont familyNames]) {
        NSLog(@"family:'%@'", fontfamilyname);
        for (NSString* fontName in [UIFont fontNamesForFamilyName:fontfamilyname]) {
            NSLog(@"\tfont:'%@'", fontName);
        }
        NSLog(@"-------------");
    }
    NSLog(@"======================================");
}

+ (void)registFont:(NSString*)fontFile
{
    if (!ftFontArray)
    {
        ftFontArray = [NSMutableArray arrayWithCapacity:1];
    }
    else
    {
        if ([ftFontArray containsObject:fontFile])
        {
            return;
        }
    }
    
    NSURL* url = [NSURL fileURLWithPath:fontFile];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    if (fontDataProvider == NULL)
        return;
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CFErrorRef error;
    if (!CTFontManagerRegisterGraphicsFont(newFont, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    }
    else
    {
        [ftFontArray addObject:fontFile];
    }
    CFRelease(newFont);
    CFRelease(fontDataProvider);
    
    
}

+ (void) unregistFont:(NSString *)fontFile
{
    
    if (!ftFontArray || [ftFontArray containsObject:fontFile])
    {
        return;
    }
    
    NSURL* url = [NSURL fileURLWithPath:fontFile];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    if (fontDataProvider == NULL)
        return;
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CFErrorRef error;
    if (!CTFontManagerUnregisterGraphicsFont(newFont, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    }
    CFRelease(newFont);
    CFRelease(fontDataProvider);
}

#pragma mark - 内存相关
- (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
        HOST_VM_INFO,
        (host_info_t)&vmStats,
        &infoCount);

    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }

    return ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
}

- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
        TASK_BASIC_INFO,
        (task_info_t)&taskInfo,
        &infoCount);

    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }

    return taskInfo.resident_size / 1024.0 / 1024.0;
}

@end
