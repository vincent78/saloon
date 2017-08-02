//
//  NSNumber+box.m
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSNumber+FTBox.h"

@implementation NSNumber (FTBox)

#pragma mark - 时间


-(NSDate *) toDateSince1970
{
    return [[NSDate alloc] initWithTimeIntervalSince1970:[self longLongValue]];
}


-(NSString *) toTimeStr
{
    NSString *ret = @"";
    
    long lTime = [self longValue];
    NSInteger iSeconds = lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours = (lTime / 3600);
    NSInteger iDays = lTime/60/60/24;
    NSInteger iMonth = lTime/60/60/24/12;
    NSInteger iYears = lTime/60/60/24/384;
    

    
    ret = [NSString stringWithFormat:@"%04i-%02i-%02i %02i:%02i:%02i",(int)iYears,(int)iMonth,(int)iDays,(int)iHours,(int)iMinutes,(int)iSeconds];
    
    return ret;
}

@end
