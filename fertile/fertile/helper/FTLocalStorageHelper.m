//
//  FTLocalStorageHelper.m
//  fertile
//
//  Created by vincent on 16/8/11.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTLocalStorageHelper.h"

#define kExpiresDateSuffix @"__crn__expiresdate"


@interface FTLocalStorageHelper()
{
    NSMutableArray *_cacheArray;
}

@end

@implementation FTLocalStorageHelper

+ (instancetype)sharedInstance
{
    static FTLocalStorageHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FTLocalStorageHelper alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _cacheArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(YYCache *)cacheForDomain:(NSString *)domain
{
    if (domain.length == 0) {
        domain = @"common";
    }
    __block YYCache *cache = nil;
    [_cacheArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YYCache *tmpCache = (YYCache *)obj;
        if ([tmpCache.name isEqualToString:domain]) {
            cache = tmpCache;
            *stop = YES;
        }
    }];
    NSString *path = [self cachePathWithDomain:domain];
    if (cache== nil || ![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"%@",path);
        if (cache != nil) {  //用户手动在设置里清除缓存
            [_cacheArray removeObject:cache];
            cache = nil;
        }
        cache = [[YYCache alloc] initWithPath:path];
        [_cacheArray addObject:cache];
    }
    return cache;
}

-(NSString *)cachePathWithDomain:(NSString *)domain
{
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [[[cacheFolder stringByAppendingPathComponent:[NSBundle mainBundle].bundleIdentifier] stringByAppendingPathComponent:@"UniversalStorage"] stringByAppendingPathComponent:domain];
    return path;
    
}

- (BOOL)containsObjectForKey:(NSString *)key inDomain:(NSString *)domain
{
    YYCache *cache = [self cacheForDomain:domain];
    NSString *expiresDateKey =[key stringByAppendingString:kExpiresDateSuffix];
    NSDate *expiresDate = (NSDate *)[cache objectForKey:expiresDateKey];
    if (expiresDate != nil && [expiresDate timeIntervalSinceReferenceDate] < [[NSDate date] timeIntervalSinceReferenceDate]){
        [cache removeObjectForKey:expiresDateKey];
        [cache removeObjectForKey:key];
        return NO;
    }
    return [cache containsObjectForKey:key];
}

- (nullable id<NSCoding>)objectForKey:(NSString *)key inDomain:(NSString *)domain
{
    YYCache *cache = [self cacheForDomain:domain];
    if ([self containsObjectForKey:key inDomain:domain]) {
        return [cache objectForKey:key];
    }
    else
    {
        return nil;
    }
}

- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key inDomain:(NSString *)domain
{
    if (!key || ![key isKindOfClass:[NSString class]]) {
        return;
    }
    YYCache *cache = [self cacheForDomain:domain];
    [cache setObject:object forKey:key];
}

- (void)setObject:(NSString *)object forKey:(NSString *)key inDomain:(NSString *)domain withExpires:(double)timeInterval;
{
    if (!key || ![key isKindOfClass:[NSString class]]) {
        return;
    }
    YYCache *cache = [self cacheForDomain:domain];
    NSDate* expiresDate = timeInterval > 0 ? [NSDate dateWithTimeIntervalSinceNow:timeInterval] : nil;
    NSString *expiresDateKey =[key stringByAppendingString:kExpiresDateSuffix];
    [cache setObject:object forKey:key];
    [cache setObject:expiresDate forKey:expiresDateKey];
}


- (void)removeObjectForKey:(NSString *)key inDomain:(NSString *)domain
{
    YYCache *cache = [self cacheForDomain:domain];
    NSString *expiresDateKey =[key stringByAppendingString:kExpiresDateSuffix];
    NSDate *expiresDate = (NSDate *)[cache objectForKey:expiresDateKey];
    if (expiresDate != nil){
        [cache removeObjectForKey:expiresDateKey];
    }
    [cache removeObjectForKey:key];
}


- (void)removeAllObjectsInDomain:(NSString *)domain
{
    YYCache *cache = [self cacheForDomain:domain];
    [cache removeAllObjects];
}


@end
