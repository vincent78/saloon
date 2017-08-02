//
//  NSDate+normal.m
//  fertile_oc
//
//  Created by vincent on 15/11/2.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSDate+FTNormal.h"
#import "NSString+FTBox.h"

@implementation NSDate (FTNormal)

#pragma mark - 日期计算

static NSCalendar *currCalendar;

+ (NSCalendar *)getCurrentCalendar
{

    if (!currCalendar)
    {
        currCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [currCalendar setFirstWeekday:1];
        [currCalendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [currCalendar setMinimumDaysInFirstWeek:1];
        [currCalendar setTimeZone:[NSTimeZone timeZoneWithName:ftTimeZone_CN]];
    }
    return currCalendar;
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

-(NSDate *) calculate:(FTDATEFIELD)field amount:(int)amount
{
    return [[self class] calculateDate:self field:field amount:amount];
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


/**
 两个DateTime时间间隔
 
 @param departTime 时间1
 @param arriveTime 时间2
 @return x天x时x分
 */
+(NSString *)getStayTimeInt:(NSString*)departTime arriveTime:(NSString*)arriveTime
{
    //    NSDate* departDate = [DateUtil getDateByDateTimeStr:departTime];
    //    NSDate* arriveDate = [DateUtil getDateByDateTimeStr:arriveTime];
    //    int allMin = [departDate timeIntervalSinceDate:arriveDate]/60;//总分钟
    //    allMin = (abs(allMin));
    int allMin = [self getStayTimeRetInt:departTime arriveTime:arriveTime];
    
    NSString* tempStr = [self convertMinutesToEngLishTimeStr:allMin];
    return tempStr;
}

/**
 *  @brief  两个时间间隔
 *
 *  @param departTime 时间1
 *  @param arriveTime 时间2
 *
 *  @return 分钟
 */
+(int) getStayTimeRetInt:(NSString*)departTime arriveTime:(NSString*)arriveTime
{
    NSDate *departDate = [departTime toDate:@"yyyyMMddHHmmss"];
    NSDate *arriveDate = [arriveTime toDate:@"yyyyMMddHHmmss"];
    int allMin = [departDate timeIntervalSinceDate:arriveDate]/60;//总分钟
    allMin = (abs(allMin));
    return allMin;
}

/**
 *	将分钟数转换为时间字符串(英文)
 *
 *	@param	minutes	分钟数
 *
 *	@return	NSString
 */
+(NSString *)convertMinutesToEngLishTimeStr:(int)minutes{
    NSString * result = @"";
    if (minutes <= 0) {
        return result;
    }
    int hour = minutes/60;    //小时
    int minute = minutes%60;    //分钟
    if (hour) {
        result = [NSString stringWithFormat:@"%@%dh",result,hour];
    }
    if (minute) {
        result = [NSString stringWithFormat:@"%@%dm",result,minute];
    }
    return result;
}

/**
 *  @brief  将分钟数转换为时间字符串（00:00)
 *
 *  @param minutes minutes	分钟数
 *
 *  @return NSString
 */
+(NSString *)convertMinutesToShowTimeStr:(int)minutes {
    if (minutes <= 0) {
        return @"";
    }
    return [NSString stringWithFormat:@"%2d:%2d",minutes/60,minutes%60];
}


/**
 计算2个时间的跨天数目
 
 @param startTime 开始时间
 @param endTime 结束时间
 @return 2个时间的跨天数目
 */
+ (NSString *)getSpaceTimeStrWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    if([startTime length] == 14 && [endTime length] == 14)
    {
        return [self getWtNextDay:startTime arriveTime:endTime];
    }
    return @"";
}


+ (NSString *)getWtNextDay:(NSString*)departTime arriveTime:(NSString *)arriveTime
{
    if (arriveTime == nil || departTime == nil)
    {
        return @"Error";
    }
    else
    {
        if ([departTime length] != 14 || [arriveTime length] != 14
            ) {
            return @"length error";
        }
        NSString *departYear = [departTime substringToIndex:4];
        NSString *arriveYear = [arriveTime substringToIndex:4];
        NSString *departMonth = [departTime substringWithRange:NSMakeRange(4, 2)];
        NSString *arriveMonth = [arriveTime substringWithRange:NSMakeRange(4, 2)];
        NSString *departDay = [departTime substringWithRange:NSMakeRange(6, 2)];
        NSString *arriveDay = [arriveTime substringWithRange:NSMakeRange(6, 2)];
        if ([departMonth intValue]!=[arriveMonth intValue])
        {
            if ([departDay intValue]< [arriveDay intValue]) //8月1日  7月30日
            {
                if ([arriveMonth isEqualToString:@"01"]||[arriveMonth isEqualToString:@"03"]||[arriveMonth isEqualToString:@"05"]||[arriveMonth isEqualToString:@"07"]||[arriveMonth isEqualToString:@"08"]||[arriveMonth isEqualToString:@"10"]||[arriveMonth isEqualToString:@"12"]) {
                    int departNum = [departDay intValue]+31;
                    if (departNum<10)
                    {
                        departDay = [NSString stringWithFormat:@"0%d",departNum];
                    }
                    else
                    {
                        departDay = [NSString stringWithFormat:@"%d",departNum];
                    }
                }
                else if ([arriveMonth isEqualToString:@"04"]||[arriveMonth isEqualToString:@"06"]||[arriveMonth isEqualToString:@"09"]||[arriveMonth isEqualToString:@"11"])
                {
                    int departNum = [departDay intValue]+30;
                    if (departNum<10)
                    {
                        departDay = [NSString stringWithFormat:@"0%d",departNum];
                    }
                    else
                    {
                        departDay = [NSString stringWithFormat:@"%d",departNum];
                    }
                }
                else if([arriveMonth isEqualToString:@"02"])
                {
                    int departNum = [departDay intValue]+28;
                    if (([arriveYear intValue]%4==0&&[arriveYear intValue]%100!=0)||[arriveYear intValue]%400==0)
                    {
                        departNum = [departDay intValue]+29;
                    }
                    departDay = [NSString stringWithFormat:@"0%d",departNum];
                }
            }
            else if ([arriveDay intValue]< [departDay intValue])    //8月1日  7月30日
            {
                if ([departMonth isEqualToString:@"01"]||[departMonth isEqualToString:@"03"]||[departMonth isEqualToString:@"05"]||[departMonth isEqualToString:@"07"]||[departMonth isEqualToString:@"08"]||[departMonth isEqualToString:@"10"]||[departMonth isEqualToString:@"12"])
                {
                    int arriveNum = [arriveDay intValue]+31;
                    if (arriveNum<10) {
                        arriveDay = [NSString stringWithFormat:@"0%d",arriveNum];
                    }
                    else
                    {
                        arriveDay = [NSString stringWithFormat:@"%d",arriveNum];
                    }
                }
                else if ([departMonth isEqualToString:@"04"]||[departMonth isEqualToString:@"06"]||[departMonth isEqualToString:@"09"]||[departMonth isEqualToString:@"11"])
                {
                    int arriveNum = [arriveDay intValue]+30;
                    if (arriveNum<10)
                    {
                        arriveDay = [NSString stringWithFormat:@"0%d",arriveNum];
                    }
                    else
                    {
                        arriveDay = [NSString stringWithFormat:@"%d",arriveNum];
                    }
                }
                else if([departMonth isEqualToString:@"02"])
                {
                    int arriveNum = [arriveDay intValue]+28;
                    if (([departYear intValue]%4==0&&[departYear intValue]%100!=0)||[departYear intValue]%400==0)
                    {
                        arriveNum = [arriveDay intValue]+29;
                    }
                    arriveDay = [NSString stringWithFormat:@"0%d",arriveNum];
                }
            }
        }
        
        NSString *result = @"";
        if ([arriveDay intValue]-[departDay intValue] > 0)
        {
            result = [NSString stringWithFormat:@"+%d天", [arriveDay intValue]-[departDay intValue]];
        }
        else if([arriveDay intValue]-[departDay intValue]< 0)
        {
            result = [NSString stringWithFormat:@"-%d天", [departDay intValue]-[arriveDay intValue]];
        }
        
        return result;
    }
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

-(NSDateComponents *) getComponents
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSCalendar *calendar = [NSDate getCurrentCalendar];
    
    return  [calendar components:unitFlags fromDate:self];
}

-(NSInteger)getYear
{

    return [[self getComponents] year];
}

-(NSInteger)getMonth
{
    return [[self getComponents] month];
}

-(NSInteger)getDay
{
    return [[self getComponents] day];
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


- (NSString *)lunarForSolar
{
    //天干名称
    //    NSArray *cTianGan = [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸", nil];
    //
    //    //地支名称
    //    NSArray *cDiZhi = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
    //
    //    //属相名称
    //    NSArray *cShuXiang = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
    
    //农历日期名
    NSArray *cDayName = [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                         @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                         @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName = [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static NSInteger wCurYear,wCurMonth,wCurDay;
    static NSInteger nTheDate,nIsEnd,m,k,n,i,nBit;
    
    //取当前公历年、月、日
    NSDateComponents *components = [[NSDate getCurrentCalendar] components:NSCalendarUnitDay |NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    wCurYear = [components year];
    wCurMonth = [components month];
    wCurDay = [components day];
    
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        
        if(nIsEnd)
            break;
        m = m + 1;
    }
    
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    //生成农历天干、地支、属相
    //    NSString *szShuXiang = (NSString *)[cShuXiang objectAtIndexForCtrip:((wCurYear - 4) % 60) % 12];
    
    //    NSString *szNongli = [NSString stringWithFormat:@"%@(%@%@)年",szShuXiang, (NSString *)[cTianGan objectAtIndexForCtrip:((wCurYear - 4) % 60) % 10],(NSString *)[cDiZhi objectAtIndexForCtrip:((wCurYear - 4) % 60) %12]];
    
    //生成农历月、日
    NSString *szNongliDay;
    
    if (wCurMonth < 1)
    {
        szNongliDay = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndexForFT:-1 * wCurMonth]];
    }else
    {
        szNongliDay = (NSString *)[cMonName objectAtIndexForFT:wCurMonth];
    }
    
    //  NSString *lunarDate = [NSString stringWithFormat:@"%@ %@月 %@",szNongli,szNongliDay,(NSString*)[cDayName objectAtIndexForCtrip:wCurDay]];
    NSString *lunarDate = [NSString stringWithFormat:@"%@月%@",szNongliDay,(NSString*)[cDayName objectAtIndexForFT:wCurDay]];
    
    return lunarDate;
}
@end
