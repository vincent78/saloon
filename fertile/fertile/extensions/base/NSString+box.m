//
//  NSString+box.m
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+box.h"

@implementation NSString (box)

-(NSDate *)toDate:(NSString *)formatStr
{
    return [[NSDate getFormatterByStr:formatStr] dateFromString:self];
}

-(int) toInt
{
    return [self intValue];
}

-(NSInteger) toInteger
{
    return [self integerValue];
}

-(float) toFloat
{
    return [self floatValue];
}

-(int) toAscii
{
    return [self toAscii:0];
}

-(int) toAscii:(int)position
{
    if (self.length <= position + 1)
    {
        return [self characterAtIndex:position];
    }
    else
    {
        return 0;
    }
}

-(NSString *)fromAscii:(int)num
{
    return [NSString stringWithFormat:@"%C",(unichar)num];
}


-(NSString *)fromUnicode
{
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData
                                                                    options:NSPropertyListImmutable
                                                                     format:NULL error:NULL];
    
//    NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

-(NSString *) toUnicode
{
        NSUInteger length = [self length];
        NSMutableString *s = [NSMutableString stringWithCapacity:0];
        for (int i = 0;i < length; i++)
        {
            unichar _char = [self characterAtIndex:i];
            //判断是否为英文和数字
            if (_char <= '9' && _char >='0')
            {
                [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
            }
            else if(_char >='a' && _char <= 'z')
            {
                [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
            }
            else if(_char >='A' && _char <= 'Z')
            {
                [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
            }
            else
            {
                [s appendFormat:@"\\u%x",[self characterAtIndex:i]];
            }
        }
        return s;
}

@end
