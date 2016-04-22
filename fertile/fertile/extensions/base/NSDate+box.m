//
//  NSDate+box.m
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSDate+box.h"

@implementation NSDate (box)

#pragma mark - 格式化



static NSMutableDictionary * dateFormatters ;

+(NSDateFormatter *) getFormatterByStr:(NSString *)str
{
    if (dateFormatters)
    {
        dateFormatters = [NSMutableDictionary dictionary];
    }
    
    NSDateFormatter *dateFormater = [dateFormatters objectForKey:str];
    if (!dateFormater)
    {
        dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [dateFormater setTimeZone:[NSTimeZone timeZoneWithAbbreviation:ftTimeZone_CN]];
        [dateFormater setDateFormat:str];
        [dateFormatters setObjectForFT:dateFormater forKey:str];
    }
    
    return dateFormater;
}

- (NSString *)toString:(NSString *)formatStr
{
    return [[NSDate getFormatterByStr:formatStr ] stringFromDate:self];
}


-(long long)toMilliSecond
{
    NSTimeInterval time = [self timeIntervalSince1970];
    // NSTimeInterval返回的是double类型，输出会显示为10位整数加小数点加一些其他值
    // 如果想转成int型，必须转成long long型才够大。
    return  [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
}


-(NSString *)toMilliSecondStr
{
    return [NSString stringWithFormat:@"%llu",[self toMilliSecond]];
}

+(NSString *)timeStr
{
    NSDate *date = [NSDate new];
    return [date toString:@"HH:mm:ss.SSS"];
}

+(NSString *)dateStr
{
    NSDate *date = [NSDate new];
    return [date toString:@"yyyy-MM-dd"];
}


@end
