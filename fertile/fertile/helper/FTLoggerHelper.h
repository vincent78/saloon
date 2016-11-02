//
//  FTLoggerHelper.h
//  fertile_oc
//
//  Created by vincent on 15/11/18.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"




typedef NS_ENUM(NSUInteger, LOGLEVEL) {
    LOGLEVEL_FATAT   = 0,
    LOGLEVEL_ERROR,
    LOGLEVEL_WARN,
    LOGLEVEL_INFO,
    LOGLEVEL_DEBUG,
};

@interface FTLoggerHelper : FTBaseHelper

+(FTLoggerHelper *) sharedInstance;

+(void) log4Fatal:(NSString *)msg;

+(void) log4Error:(NSString *)msg;

+(void) log4Warn:(NSString *)msg;

+(void) log4Info:(NSString *)msg;

+(void) log4Debug:(NSString *)msg;

+(void) log:(NSString *)msg type:(LOGLEVEL)level;

@end
