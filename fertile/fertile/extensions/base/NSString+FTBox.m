//
//  NSString+box.m
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+FTBox.h"

@implementation NSString (FTBox)

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


- (NSString *)toHexString
{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];//16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


- (NSString *)fromHexString
{
    char *myBuffer = (char *)malloc((int)[self length] / 2 + 1);
    bzero(myBuffer, [self length] / 2 + 1);
    for(int i = 0; i < [self length] - 1; i += 2){
        unsigned int anInt;
        NSString * hexCharStr = [self substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
//    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}


-(NSData *) toNSData
{
    return [self dataUsingEncoding: NSUTF8StringEncoding];
//    unsigned long len = [self length] / 2;    // Target length
//    unsigned char *buf = malloc(len);
//    unsigned char *whole_byte = buf;
//    char byte_chars[3] = {'\0','\0','\0'};
//    
//    int i;
//    for (i=0; i < [self length] / 2; i++) {
//        byte_chars[0] = [self characterAtIndex:i*2];
//        byte_chars[1] = [self characterAtIndex:i*2+1];
//        *whole_byte = strtol(byte_chars, NULL, 16);
//        whole_byte++;
//    }
//    NSData *data = [NSData dataWithBytes:buf length:len];
//    free( buf );  
//    return data;
}



@end
