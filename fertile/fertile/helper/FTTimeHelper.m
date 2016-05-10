//
//  FTTimeHelper.m
//  fertile
//
//  Created by vincent on 16/5/10.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTTimeHelper.h"

@implementation FTTimeHelper


static FTTimeHelper *sharedInstance = nil;

+(FTTimeHelper *) sharedInstance
{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTTimeHelper new];
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

#pragma mark - system circle

- (id)init
{
    self = [super init];
    if(self)
    {
        //        NSDate *now = [NSDate date];
        //        NSTimeZone *tz = [NSTimeZone timeZoneWithName:kCtripCalendarTimeZone_GMT];
        //        NSInteger interval = [tz secondsFromGMTForDate:now];
        //        self.localGMTTime = [now dateByAddingTimeInterval:interval];
        self.localGMTTime = [NSDate date];
        
        self.timeFlag = YES;
    }
    return self;
}


- (void)dealloc
{
    if (_localGMTTime) {
        _localGMTTime = nil;
    }
    if (_serverGMTTime) {
        _serverGMTTime = nil;
    }
}

- (void)initWithTime:(NSString *)time offsetHour:(NSInteger)offsetHour
{
    //    NSDate *nowLocalTime = [NSDate date];
    //    NSTimeZone *tz = [NSTimeZone timeZoneWithName:kCtripCalendarTimeZone_GMT];
    //    NSInteger interval = [tz secondsFromGMTForDate:nowLocalTime];
    //    self.localGMTTime = [nowLocalTime dateByAddingTimeInterval:interval];
    self.localGMTTime = [NSDate date];
    
    if(time.length == 0 || [time length] < 14){
        self.serverGMTTime = _localGMTTime;
        self.timeFlag = YES;
        return;
    }
    
    self.serverGMTTime = [time toDate:@"yyyyMMddHHmmss"];
    self.timeFlag = YES;
    
    //如果本地时间和服务器时间相差大于30秒,强制使用服务器时间
    if(fabs([self.localGMTTime timeIntervalSinceDate:self.serverGMTTime]) > 30)
    {
        self.timeFlag = NO;
    }
}

#pragma mark - custom area



/**
 *  @brief 获取时间
 *
 *  @return <#return value description#>
 */
- (NSDate *)getCurrentDate
{
    NSDate *nowLocalDate = [NSDate date];
    //    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    NSInteger interval = [tz secondsFromGMTForDate: nowLocalDate];
    //    nowLocalDate = [nowLocalDate dateByAddingTimeInterval:interval];
    
    if(self.timeFlag)
    {
        return nowLocalDate;
    }else
    {
        NSTimeInterval interval = [nowLocalDate timeIntervalSinceDate:_localGMTTime];
        nowLocalDate = [NSDate dateWithTimeInterval:interval sinceDate:self.serverGMTTime];
    }
    return nowLocalDate;
}


/**
 *  @brief 根据服务器传过来的时间初始化时间
 *
 *  @param time <#time description#>
 */
- (void)initTime:(NSString *)time
{
    [self initWithTime:time offsetHour:0];
}


/**
 *  @brief 获取当前的时间
 *
 *  @return <#return value description#>
 */
+ (NSDate *)getCurrentDate
{
    return [FTTimeHelper sharedInstance].getCurrentDate;
}

@end
