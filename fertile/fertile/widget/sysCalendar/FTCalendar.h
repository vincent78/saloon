//
//  FTCalendar.h
//  fertile
//
//  Created by vincent on 2017/3/24.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * result 结果
 {
 errorCode:(-201)未授权/(-202)授权失败/(-203)参数错误/(-204)系统接口返回失败,
 }
 */
typedef void(^AddCalendarEventResultBlock)(NSDictionary *result);


@interface FTCalendar : NSObject

/**
 * @description 添加日历事件
 * @param eventInfo
 {
 title:'测试添加日历事件',
 desc:'测试添加日历事件note',
 location:'地点',
 start:'1444375788000',
 end:'1444376788000',
 hasAlarm:True,
 remindMinutes:'10'
 }
 * @param resultBlock 结果回调
 */
+ (void)addEvent:(NSDictionary *)eventInfo completion:(AddCalendarEventResultBlock)resultBlock;


@end
