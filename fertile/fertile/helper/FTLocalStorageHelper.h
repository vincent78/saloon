//
//  FTLocalStorageHelper.h
//  fertile
//
//  Created by vincent on 16/8/11.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTLocalStorageHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)containsObjectForKey:(NSString *)key inDomain:(NSString *)domain;

- (NSString *)objectForKey:(NSString *)key inDomain:(NSString *)domain;
/*
 object: value值
 key: key
 domain: 数据存储的域，传入bu名，防止各个bu间存了相同key的数据时错乱，传空则默认存在 common 区域
 */
- (void)setObject:(NSString *)object forKey:(NSString *)key inDomain:(NSString *)domain;

/*
 timeInterval: 过期时间，单位为秒
 */
- (void)setObject:(NSString *)object forKey:(NSString *)key inDomain:(NSString *)domain withExpires:(double)timeInterval;

- (void)removeObjectForKey:(NSString *)key inDomain:(NSString *)domain;


@end
