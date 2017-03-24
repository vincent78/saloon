//
//  FTCalendar.m
//  fertile
//
//  Created by vincent on 2017/3/24.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import "FTCalendar.h"
#import <EventKit/EventKit.h>

@implementation FTCalendar

+ (void)addEvent:(NSDictionary *)eventInfo completion:(AddCalendarEventResultBlock)resultBlock
{
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]){
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError* error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if(!granted){
                    [resultDictionary setObject:@"(-201)未授权" forKey:@"errorCode"];
                }else if(error){
                    [resultDictionary setObject:@"(-202)授权失败" forKey:@"errorCode"];
                }else{
                    if(!eventInfo || ![eventInfo isKindOfClass:[NSDictionary class]]){
                        [resultDictionary setObject:@"(-203)参数错误" forKey:@"errorCode"];
                    }else{
                        NSString* title = eventInfo[@"title"];
                        NSString* desc = eventInfo[@"desc"];
                        NSString* location = eventInfo[@"location"];
                        long long start = [eventInfo[@"start"] doubleValue];
                        long long end = [eventInfo[@"end"] doubleValue];
                        Boolean hasAlarm = [eventInfo[@"hasAlarm"] boolValue];
                        int remindMinutes = [eventInfo[@"remindMinutes"] intValue];
                        
                        if([NSString emptyOrNil:title]) {
                            [resultDictionary setObject:@"(-203)参数错误" forKey:@"errorCode"];
                        }
                        if(start <= 0) {
                            [resultDictionary setObject:@"(-203)参数错误" forKey:@"errorCode"];
                        }
                        if(end <= 0) {
                            [resultDictionary setObject:@"(-203)参数错误" forKey:@"errorCode"];
                        }
                        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                        event.title = title;
                        event.notes = desc;
                        event.location = location;
                        
                        event.startDate = [NSDate dateWithTimeIntervalSince1970:start / 1000];
                        event.endDate = [NSDate dateWithTimeIntervalSince1970:end / 1000];
                        
                        if(hasAlarm){
                            [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * - remindMinutes]];
                        }
                        
                        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                        NSError *err = nil;
                        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                        if(err){
                            [resultDictionary setObject:@"(-204)系统接口返回失败" forKey:@"errorCode"];
                        }
                    }
                }
                resultBlock(resultDictionary);
            });
        }];
    }
}

@end
