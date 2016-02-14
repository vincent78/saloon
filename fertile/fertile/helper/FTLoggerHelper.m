//
//  FTLoggerHelper.m
//  fertile_oc
//
//  Created by vincent on 15/11/18.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTLoggerHelper.h"

@implementation FTLoggerHelper

static FTLoggerHelper *sharedInstance = nil;

+(FTLoggerHelper *) sharedInstance
{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTLoggerHelper new];
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

#pragma mark - func

static LOGLEVEL currLevel = LOGLEVEL_DEBUG;

+(void) log4Fatal:(NSString *)msg
{
    if (currLevel >= LOGLEVEL_FATAT)
    {
        msg = [@"[FATAL]" stringByAppendingString:msg];
        [[FTLoggerHelper sharedInstance] writeLog:msg];
    }
}

+(void) log4Error:(NSString *)msg
{
    if (currLevel >= LOGLEVEL_ERROR)
    {
        msg = [@"[ERROR]" stringByAppendingString:msg];
        [[FTLoggerHelper sharedInstance] writeLog:msg];
    }
}

+(void) log4Warn:(NSString *)msg
{
    if (currLevel >= LOGLEVEL_WARN)
    {
        msg = [@"[WARN]" stringByAppendingString:msg];
        [[FTLoggerHelper sharedInstance] writeLog:msg];
    }
}

+(void) log4Info:(NSString *)msg
{
    if (currLevel >= LOGLEVEL_INFO)
    {
        msg = [@"[INFO]" stringByAppendingString:msg];
        [[FTLoggerHelper sharedInstance] writeLog:msg];
    }
}

+(void) log4Debug:(NSString *)msg
{
    if (currLevel >= LOGLEVEL_DEBUG)
    {
        msg = [@"[DEBUG]" stringByAppendingString:msg];
        [[FTLoggerHelper sharedInstance] writeLog:msg];
    }
}



+(void) log:(NSString *)msg type:(LOGLEVEL)level
{
    switch (level) {
        case LOGLEVEL_FATAT:
            [self log4Fatal:msg];
            break;
        case LOGLEVEL_ERROR:
            [self log4Error:msg];
            break;
        case LOGLEVEL_WARN:
            [self log4Warn:msg];
            break;
        case LOGLEVEL_INFO:
            [self log4Info:msg];
            break;
        case LOGLEVEL_DEBUG:
            [self log4Debug:msg];
            break;
        default:
            break;
    }
}


-(void) writeLog:(NSString *)msg
{
    msg = [NSString stringWithFormat:@"[%@]%@",[NSDate timeStr],msg];
#ifdef DEBUG
//        NSLog(@"\n%@",msg);
    fprintf(stderr, "%s\n",[msg UTF8String]);
#endif
}




@end
