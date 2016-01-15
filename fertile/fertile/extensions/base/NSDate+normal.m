//
//  NSDate+normal.m
//  fertile_oc
//
//  Created by vincent on 15/11/2.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSDate+normal.h"

@implementation NSDate (normal)

#pragma mark - 日期计算

+ (NSCalendar *)getCurrentCalendar
{

    NSCalendar *calendar_ = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar_ setFirstWeekday:1];
    [calendar_ setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [calendar_ setMinimumDaysInFirstWeek:1];
    [calendar_ setTimeZone:[NSTimeZone timeZoneWithName:ftTimeZone_CN]];
    
    return calendar_;
}


+(NSDate *)calculateDate:(NSDate *)date field:(FTDATEFIELD)field amount:(int)amount
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSCalendar *calendar = [NSDate getCurrentCalendar];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    
    switch (field)
    {
        case FTDATEFIELD_YEAR:
            [comps setYear:comps.year + amount];
            break;
        case FTDATEFIELD_MONTH:
            [comps setMonth:comps.month + amount];
            break;
        case FTDATEFIELD_DAY:
            [comps setDay:comps.day + amount];
            break;
        case FTDATEFIELD_HOUR:
            [comps setHour:comps.hour + amount];
            break;
        case FTDATEFIELD_MINUTE:
            [comps setMinute:comps.minute + amount];
            break;
        case FTDATEFIELD_SECOND:
            [comps setSecond:comps.second + amount];
            break;
    }
    
    return  [calendar dateFromComponents:comps];
}

-(long long) subtract:(NSDate *)otherDate
{
    NSTimeInterval time = [self timeIntervalSinceDate:otherDate];
    return [[NSNumber numberWithDouble:time] longLongValue];
}

-(NSDate *) add:(long long) milliSecond
{
    return [self dateByAddingTimeInterval:milliSecond];
}

#pragma mark - 日期比较

-(BOOL) isBefore:(NSDate *) otherDate
{

    if ([self compare:otherDate] == NSOrderedAscending)
        return YES;
    else
        return NO;
}


-(BOOL) isEqual:(NSDate *) otherDate
{
    if (!otherDate)
        return NO;
    
    if ([self compare:otherDate] == NSOrderedSame)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


#pragma mark - 特殊日期

- (NSDate *)getLastDateOfMonth
{
    return nil;
}


- (NSDate *)getFirstDateOfMonth
{
    return nil;
}

-(NSString *) getWeekStr
{
    NSCalendar *calendar = [NSDate getCurrentCalendar];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    NSInteger week = [comps weekday];
    
    NSString *dateStr = @"";
    
    switch (week)
    {
        case 1:
            dateStr = @"周日";
            break;
        case 2:
            dateStr = @"周一";
            break;
        case 3:
            dateStr = @"周二";
            break;
        case 4:
            dateStr = @"周三";
            break;
        case 5:
            dateStr = @"周四";
            break;
        case 6:
            dateStr = @"周五";
            break;
        case 7:
            dateStr = @"周六";
            break;
        default:
            break;
    }
    
    return dateStr;

}


- (NSInteger)getWeek
{
    NSCalendar *calendar = [NSDate getCurrentCalendar];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    NSInteger week = [comps weekday];
    
    return week;
}



@end
