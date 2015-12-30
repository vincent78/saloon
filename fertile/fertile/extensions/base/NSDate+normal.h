//
//  NSDate+normal.h
//  fertile_oc
//
//  Created by vincent on 15/11/2.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief  时间的单位
 */
typedef NS_ENUM(NSInteger,FTDATEFIELD) {
    /**
     *  <#Description#>
     */
    FTDATEFIELD_YEAR = 1,
    /**
     *  <#Description#>
     */
    FTDATEFIELD_MONTH = 2,
    /**
     *  <#Description#>
     */
    FTDATEFIELD_DAY = 3,
    /**
     *  <#Description#>
     */
    FTDATEFIELD_HOUR = 4,
    /**
     *  <#Description#>
     */
    FTDATEFIELD_MINUTE= 5,
    /**
     *  <#Description#>
     */
    FTDATEFIELD_SECOND = 6
};

@interface NSDate (normal)


#pragma mark - 日期计算

/**
 *  @brief  按指定的内容计算
 *
 *  @param date   时间
 *  @param field  FTDATEFIEDL
 *  @param amount 计算值
 *
 *  @return 计算后的值
 */
+(NSDate *)calculateDate:(NSDate *)date field:(FTDATEFIELD)field amount:(int)amount;

/**
 *  @brief  获取当前使用的calendar
 *
 *  @return <#return value description#>
 */
+ (NSCalendar *)getCurrentCalendar;


/**
 *  @brief  当前日期减去指定日期
 *
 *  @param otherDate <#otherDate description#>
 *
 *  @return 毫秒数
 */
-(long long) subtract:(NSDate *)otherDate;


/**
 *  @brief  返回当前日期加上的豪秒数后得到的日期
 *
 *  @param milliSecond <#milliSecond description#>
 *
 *  @return <#return value description#>
 */
-(NSDate *) add:(long long) milliSecond;


#pragma mark - 日期比较

/**
 *  @brief  是否比指定的日期早
 *
 *  @param otherDate <#otherDate description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) isBefore:(NSDate *) otherDate;

/**
 *  @brief  是否与指定的日期相等
 *
 *  @param otherDate <#otherDate description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) isEqual:(NSDate *) otherDate;


#pragma mark - 特殊日期
/**
 *  @brief  得到指定日期当月的最后一天
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSDate *)getLastDateOfMonth;

/**
 *  @brief  得到指定日期当月的第一天
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSDate *)getFirstDateOfMonth;


@end
