//
//  NSURL+FTNormal.m
//  fertile
//
//  Created by vincent on 2016/12/26.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSURL+FTNormal.h"

#define kAppendingURLFlag           @"from_native_page=1"
#define kDisableWebviewCacheKey     @"disable_webview_cache_key=1"


@implementation NSURL (FTNormal)


+ (NSDictionary *)parameterDictionary:(NSString *)urlString {
    if (urlString.length == 0) {
        return nil;
    }
    NSMutableDictionary *resultDictionary = [NSMutableDictionary dictionary];
    
    NSRange range = [urlString rangeOfString:@"?"];
    if (range.length > 0)
    {
        //        NSString *hostString = [urlString substringToIndex:range.location];
        //        [resultDictionary setValue:hostString forKey:@"host"];
        
        NSString *firstLevelInfo = [urlString substringFromIndex:range.location+1];
        if (firstLevelInfo.length > 0)
        {
            NSArray *secondLevelArray = [firstLevelInfo componentsSeparatedByString:@"&"];
            for (int j = 0; j < secondLevelArray.count; j++)
            {
                NSString *secondLevelInfo = [secondLevelArray objectAtIndexForFT:j];
                NSRange secondRange = [secondLevelInfo rangeOfString:@"="];
                if (secondRange.location != NSNotFound)
                {
                    NSString *key = [secondLevelInfo substringToIndex:secondRange.location];
                    key = [key URLDecode];
                    key = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    NSString *value = [secondLevelInfo substringFromIndex:secondRange.location + 1];
                    value = [value URLDecode];
                    [resultDictionary setValue:value forKey:key];
                }
            }
        }
    }
    
    return resultDictionary;
}

- (NSURL *)addQueryItemName:(NSString *)name value:(NSString *)value
{
    NSString *queryItemString = [NSString stringWithFormat:@"%@=%@", name, value];
    NSMutableString *urlString = [self.absoluteString mutableCopy];
    
    //    if ([NSURL isSuportHTTPS:self]) {
    //        if (!isProductionEnv()) {
    //            if ([[urlString lowercaseString] hasPrefix:@"http://"]) {
    //                [urlString replaceOccurrencesOfString:@"http://" withString:@"https://" options:NSCaseInsensitiveSearch range:NSMakeRange(0, urlString.length)];
    //            }
    //        }
    //    }
    
    NSString *fragmentString = self.fragment;
    NSString *queryString = self.query;
    if (queryString.length == 0) {
        queryItemString = [@"?" stringByAppendingString:queryItemString];
    } else {
        queryItemString = [@"&" stringByAppendingString:queryItemString];
    }
    
    if (fragmentString.length == 0) {
        [urlString appendString:queryItemString];
    } else {
        NSRange range = [urlString rangeOfString:[@"#" stringByAppendingString:fragmentString]];
        if (range.location != NSNotFound && range.length > 0) {
            [urlString insertString:queryItemString atIndex:range.location];
        }
    }
    
    return [NSURL URLWithString:urlString];
}

#pragma mark - --- addFromFlagForURL

+ (BOOL)isBlankURL:(NSURL *)url {
    return [[[url absoluteString] lowercaseString] isEqualToString:@"about:blank"];
}


- (NSURL *)addFromFlagForURL
{
    NSURL *returnURL = [self copy];
    NSString *urlString = [returnURL absoluteString];
    
    NSString *host = [returnURL.host lowercaseString];
    BOOL isShortURL = NO;
    if ([host isEqualToString:@"t.cn"] || [host containsString:@"t.ctrip.cn"]) {
        isShortURL = YES;
    }
    
    if (!isShortURL) {
        if ([urlString rangeOfString:kAppendingURLFlag].location == NSNotFound) {
            if ([urlString hasPrefix:@"http"] || [urlString hasPrefix:@"ctrip://"]) {
                returnURL = [returnURL addQueryItemName:@"from_native_page" value:@"1"];
                urlString = [returnURL.absoluteString copy];
            } else {
                if ([urlString rangeOfString:@"?"].location != NSNotFound) {
                    urlString = [urlString stringByAppendingFormat:@"&%@", kAppendingURLFlag];
                } else {
                    urlString = [urlString stringByAppendingFormat:@"?%@", kAppendingURLFlag];
                }
                returnURL = [NSURL URLWithString:urlString];
                urlString = [returnURL.absoluteString copy];
            }
        }
        
        if ([urlString hasPrefix:@"http"] && [urlString rangeOfString:kDisableWebviewCacheKey].location != NSNotFound) {
            int timestamp = (int)[[NSDate date] timeIntervalSince1970];
            NSString *respKey = [kDisableWebviewCacheKey stringByAppendingFormat:@"%d",timestamp];
            urlString = [urlString stringByReplacingOccurrencesOfString:kDisableWebviewCacheKey withString:respKey];
            returnURL = [NSURL URLWithString:urlString];
        }
    }
    
    return returnURL;
}


@end
