//
//  KeyChainUtil.h
//  packageManager
//
//  Created by vincent on 2018/12/26.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTKeyChainUtil : NSObject

+(NSString *) getClientId;

+(void) setClientId:(NSString *)clientId;

+ (id)getKeychainDataForKey:(NSString *)key;

+ (void)addKeychainData:(id)data forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
