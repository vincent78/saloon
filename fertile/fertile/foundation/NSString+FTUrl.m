//
//  NSString+FTUrl.m
//  fertile
//
//  Created by vincent on 16/5/19.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSString+FTUrl.h"

@implementation NSString (FTUrl)

- (NSURL *)toURL {
    if (self.length == 0) {
        return NULL;
    }
    
    NSString *tmpUrl = self;
    
    tmpUrl = [tmpUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSRange sRange = [tmpUrl rangeOfString:@"#"] ;
    
    NSString *retUrlStr = tmpUrl;
    
    if (sRange.location != NSNotFound) {
        NSString *prefix = [[tmpUrl substringToIndex:sRange.location] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url  = [NSURL URLWithString:prefix];
        
        NSString *sufix = [[tmpUrl substringFromIndex:sRange.location+1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        retUrlStr= [[url absoluteString] stringByAppendingFormat:@"#%@",sufix];
    }
    else {
        retUrlStr = [retUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    return [NSURL URLWithString:retUrlStr];
    
}


- (NSString *)URLEncode {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)URLDecode {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)stringURLEncoded {
    NSString *result=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                           (CFStringRef)self,
                                                                                           NULL,
                                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                           kCFStringEncodingUTF8));
    return result;
}

-(NSString *)stringURLDecode {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
    
}


-(NSString*)encodeAsURIComponent {
    const char *p=[self UTF8String];
    NSMutableString *result=[NSMutableString string];
    for (; *p!=0; p++) {
        unsigned char c=*p;
        if (('0' <= c && c <= '9') || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || c == '-' || c == '_')
        {
            [result appendFormat:@"%c",c];
        }else {
            [result appendFormat:@"%%%02X",c];
        }
        
    }
    return result;
}

- (NSString *)getURLScheme
{
    NSString *scheme = nil;
    if ([self containsString:@"://"]) {
        NSArray *array = [self componentsSeparatedByString:@"://"];
        scheme = array.firstObject;
    }
    
    return scheme;
}

- (NSString *)getURLResourceSpecifier
{
    NSString *resourceSpecifier = nil;
    NSString *scheme = [self getURLScheme];
    if (scheme && [self containsString:scheme]) {
        resourceSpecifier = [self substringFromIndex:scheme.length + 1];
    } else if ([self hasPrefix:@"/"] || [self hasPrefix:@"file:///"]) {
        resourceSpecifier = nil;
    }
    
    return resourceSpecifier;
}

- (NSNumber *)getURLPort
{
    NSNumber *port = nil;
    NSString *resourceSpecifier = [self getURLResourceSpecifier];
    if (resourceSpecifier && [resourceSpecifier hasPrefix:@"//"]) {
        NSString *tempString = [resourceSpecifier substringFromIndex:2];
        NSArray *array = [tempString componentsSeparatedByString:@"/"];
        tempString = array.firstObject;
        
        //if specific the port.
        array = [tempString componentsSeparatedByString:@":"];
        if (array.count > 1) {
            port = [NSNumber numberWithInteger:((NSString *)array.lastObject).integerValue];
        }
    }
    
    return port;
}


- (NSString *)getURLQueryString
{
    NSString *queryString = nil;
    NSString *resourceSpecifier = [self getURLResourceSpecifier];
    NSString *tempString = [resourceSpecifier substringFromIndex:2];
    tempString = [[tempString componentsSeparatedByString:@"#"] firstObject];
    NSArray *array = [tempString componentsSeparatedByString:@"?"];
    if (array.count > 1) {
        tempString = array.lastObject;
        queryString = tempString;
    }
    
    return queryString;
}

- (NSArray *)getURLQueryArray
{
    NSMutableArray *queryArray = nil;
    NSString *queryString = [self getURLQueryString];
    NSArray *array = [queryString componentsSeparatedByString:@"&"];
    for (NSString *item in array) {
        NSRange range = [item rangeOfString:@"="];// 这里不用数组处理是因为 value 中如可能带有'=',比如 base64 编码的字符串。
        if (range.location != NSNotFound && range.length > 0) {
            NSString *key = [item substringToIndex:range.location];
            NSString *value = [item substringFromIndex:range.location + range.length];
            key = [key URLDecode];
            value = [value URLDecode];
            if (key && value) {
                if (!queryArray) {
                    queryArray = [NSMutableArray array];
                }
                [queryArray addObjectForFT:@{[key URLDecode] : [value URLDecode] }];
            }
        }
    }
    
    return [NSArray arrayWithArray:queryArray];
}

- (NSString *)getURLParameterString
{
    NSString *parameterString = nil;
    NSString *resourceSpecifier = [self getURLResourceSpecifier];
    NSString *tempString = [resourceSpecifier substringFromIndex:2];
    tempString = [[tempString componentsSeparatedByString:@"#"] firstObject];
    tempString = [[tempString componentsSeparatedByString:@"?"] firstObject];
    NSArray *array = [tempString componentsSeparatedByString:@";"];
    if (array.count > 1) {
        parameterString = [[array subarrayWithRangeForFT:NSMakeRange(1, array.count - 1)]
                           componentsJoinedByString:@";"];
    }
    
    return parameterString;
}

@end
