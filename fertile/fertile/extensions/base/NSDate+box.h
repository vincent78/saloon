//
//  NSDate+box.h
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ftTimeZone_CN   @"Asia/Shanghai"
#define ftTimeZone_GMT  @"GMT"
#define ftTimeZone_UTC @"UTC"




@interface NSDate (box)

#pragma mark - 格式化

/*
 
 http://unicode.org/reports/tr35/tr35-10.html#Date_Format_Patterns
 
 a:  AM/PM
 A:  0~86399999 (Millisecond of Day)
 
 c/cc:   1~7 (Day of Week)
 ccc:    Sun/Mon/Tue/Wed/Thu/Fri/Sat
 cccc: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday
 
 d:  1~31 (0 padded Day of Month)
 D:  1~366 (0 padded Day of Year)
 
 e:  1~7 (0 padded Day of Week)
 E~EEE:  Sun/Mon/Tue/Wed/Thu/Fri/Sat
 EEEE: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday
 
 F:  1~5 (0 padded Week of Month, first day of week = Monday)
 
 g:  Julian Day Number (number of days since 4713 BC January 1)
 G~GGG:  BC/AD (Era Designator Abbreviated)
 GGGG:   Before Christ/Anno Domini
 
 h:  1~12 (0 padded Hour (12hr))
 H:  0~23 (0 padded Hour (24hr))
 
 k:  1~24 (0 padded Hour (24hr)
 K:  0~11 (0 padded Hour (12hr))
 
 L/LL:   1~12 (0 padded Month)
 LLL:    Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec
 LLLL: January/February/March/April/May/June/July/August/September/October/November/December
 
 m:  0~59 (0 padded Minute)
 M/MM:   1~12 (0 padded Month)
 MMM:    Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec
 MMMM: January/February/March/April/May/June/July/August/September/October/November/December
 
 q/qq:   1~4 (0 padded Quarter)
 qqq:    Q1/Q2/Q3/Q4
 qqqq:   1st quarter/2nd quarter/3rd quarter/4th quarter
 Q/QQ:   1~4 (0 padded Quarter)
 QQQ:    Q1/Q2/Q3/Q4
 QQQQ:   1st quarter/2nd quarter/3rd quarter/4th quarter
 
 s:  0~59 (0 padded Second)
 S:  (rounded Sub-Second)
 
 u:  (0 padded Year)
 
 v~vvv:  (General GMT Timezone Abbreviation)
 vvvv:   (General GMT Timezone Name)
 
 w:  1~53 (0 padded Week of Year, 1st day of week = Sunday, NB: 1st week of year starts from the last Sunday of last year)
 W:  1~5 (0 padded Week of Month, 1st day of week = Sunday)
 
 y/yyyy: (Full Year)
 yy/yyy: (2 Digits Year)
 Y/YYYY: (Full Year, starting from the Sunday of the 1st week of year)
 YY/YYY: (2 Digits Year, starting from the Sunday of the 1st week of year)
 
 z~zzz:  (Specific GMT Timezone Abbreviation)
 zzzz:   (Specific GMT Timezone Name)
 Z:  +0000 (RFC 822 Timezone)
 
 
 
 时区：
 
 GMT 格林威治标准时间 GMT
 UTC 全球标准时间 GMT
 ECT 欧洲中部时间 GMT+1:00
 EET 东欧时间 GMT+2:00
 ART （阿拉伯）埃及标准时间 GMT+2:00
 EAT 东非时间 GMT+3:00
 MET 中东时间 GMT+3:30
 NET 近东时间 GMT+4:00
 PLT 巴基斯坦拉合尔时间 GMT+5:00
 IST 印度标准时间 GMT+5:30
 BST 孟加拉国标准时间 GMT+6:00
 VST 越南标准时间 GMT+7:00
 CTT 中国台湾时间 GMT+8:00
 JST 日本标准时间 GMT+9:00
 ACT 澳大利亚中部时间 GMT+9:30
 AET 澳大利亚东部时间 GMT+10:00
 SST 所罗门标准时间 GMT+11:00
 NST 新西兰标准时间 GMT+12:00
 MIT 中途岛时间 GMT-11:00
 HST 夏威夷标准时间 GMT-10:00
 AST 阿拉斯加标准时间 GMT-9:00
 PST 太平洋标准时间 GMT-8:00
 PNT 菲尼克斯标准时间 GMT-7:00
 MST 西部山脉标准时间 GMT-7:00
 CST 中部标准时间 GMT-6:00
 EST 东部标准时间 GMT-5:00
 IET 印第安那东部标准时间 GMT-5:00
 PRT 波多黎各和美属维尔京群岛时间 GMT-4:00
 CNT 加拿大纽芬兰时间 GMT-3:30
 AGT 阿根廷标准时间 GMT-3:00
 BET 巴西东部时间 GMT-3:00
 CAT 中非时间 GMT-1:00
 
 */


/**
 *  @brief  得到指定的格式转换器
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+(NSDateFormatter *) getFormatterByStr:(NSString *)str;


/**
 *  @brief 转成时间格式的字符串
 *
 *  @return <#return value description#>
 */
+(NSString *)timeStr;

/**
 *  @brief 转成日期格式的字符串
 *
 *  @return <#return value description#>
 */
+(NSString *)dateStr;

/**
 *  @brief  格式化成字符串
 *
 *
 *  @param formatStr <#formatStr description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)toString:(NSString *)formatStr;

/**
 *  @brief  转成毫秒数
 *
 *  @return 从1970年1月1日开始的毫秒数
 */
-(long long)toMilliSecond;

/**
 *  @brief  转成毫秒数的字符串
 *
 *  @return <#return value description#>
 */
-(NSString *)toMilliSecondStr;



@end
