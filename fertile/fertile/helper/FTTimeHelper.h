//
//  FTTimeHelper.h
//  fertile
//
//    时间管理，同步服务器时间与本地时间
//  Created by vincent on 16/5/10.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

// 日历使用到的时区信息
#define kCtripCalendarTimeZone_CN   @"Asia/Shanghai"
#define kCtripCalendarTimeZone_GMT  @"GMT"

@interface FTTimeHelper : FTBaseHelper

+ (FTTimeHelper *)sharedInstance;


/**	本地时间 */
@property (nonatomic, strong) NSDate *localGMTTime;
/**	服务器时间 */
@property (nonatomic, strong) NSDate *serverGMTTime;
/**	采用哪个时间标志变量 */
@property (nonatomic, assign) BOOL timeFlag;//本地时间和服务端时间是否很接近

/**
 根据服务器传过来的时间初始化时间
 @param time 初始化日期字符串（GMT）
 */
- (void)initTime:(NSString *)time;

/**
 获取当前的时间，如果已经同步，返回服务器的时间，否则返回本地的系统事件
 */
+ (NSDate *)getCurrentDate;


@end
