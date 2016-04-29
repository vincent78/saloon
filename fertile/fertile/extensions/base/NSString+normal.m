//
//  NSString+normal.m
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+normal.h"

@implementation NSString (normal)

- (BOOL)isEmpty
{
    return self.length == 0 ? YES : NO;
}

+ (BOOL)emptyOrNil:(id)obj
{
    if (obj == nil || [obj isEqual:[NSNull null]])
        return YES;
    else {
        if ([obj isKindOfClass:[NSString class]]) {
//            NSString* tmpStr = obj;
//            return tmpStr.isEmpty;
            return [obj isEqualToString:@""];
        }
        else if ([obj isKindOfClass:[NSNumber class]])
        {
            return [obj isEqualToNumber:@0];
        }
    }
    return NO;
}

- (BOOL)isContainer:(NSString*)subStr
{
    if (subStr.length == 0) {
        return NO;
    }
    return !NSEqualRanges([self rangeOfString:subStr],
               NSMakeRange(NSNotFound, 0));
}

- (BOOL)isContainerIgnoreCase:(NSString*)subStr
{
    return [[self uppercaseString] containsString:[subStr uppercaseString]];
}

- (NSString*)trimLeft
{
    NSString* result = nil;

    NSInteger i = 0;
    NSInteger length = [self length];

    while (i < length) {
        char ch = [self characterAtIndex:i];
        if (ch == ' ' || ch == '\r' || ch == '\n' || ch == '\t') {
            ++i;
        }
        else {
            break;
        }
    }

    if (i < length) {
        result = [self substringFromIndex:i];
    }

    return result;
}

- (NSString*)trimRight
{
    NSString* result = NULL;

    NSInteger i = [self length];

    while (i >= 0) {
        char ch = [self characterAtIndex:i - 1];
        if (ch == ' ' || ch == '\r' || ch == '\n' || ch == '\t') {
            --i;
        }
        else {
            break;
        }
    }

    i = MAX(0, i);

    result = [self substringToIndex:i];

    return result;
}

- (NSString*)trim
{
    return [self stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)replaceBlankString
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}



- (NSString*)join:(NSString*)separateStr withLength:(NSNumber*)lengthes, ... NS_REQUIRES_NIL_TERMINATION
{
    NSString* retStr = @"";
    int currPosition = 0;
    va_list arglist;
    va_start(arglist, lengthes);
    int first = [lengthes intValue];

    if (first >= self.length) {
        return self;
    }

    NSNumber* val;
    retStr = [self substringWithRange:NSMakeRange(currPosition, first)];
    currPosition += first;

    while ((val = va_arg(arglist, id))) {
        if (val) {
            int length = [val intValue];
            if (length + currPosition >= self.length) {
                retStr = [NSString stringWithFormat:@"%@%@%@", retStr, separateStr, [self substringFromIndex:currPosition]];
                currPosition = (int)self.length;
                break;
            }
            else {
                retStr = [NSString stringWithFormat:@"%@%@%@", retStr, separateStr, [self substringWithRange:NSMakeRange(currPosition, length)]];
                currPosition += length;
            }
        }
    }
    if (currPosition < self.length) {
        retStr = [NSString stringWithFormat:@"%@%@%@", retStr, separateStr, [self substringFromIndex:currPosition]];
    }
    va_end(arglist);
    return retStr;
}

#pragma mark - static function

+ (NSString*)UUID
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString*)string;
}




@end
