//
//  RemoteUtil.h
//  packageManager
//
//  Created by vincent on 2018/12/21.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTRemoteUtil : NSObject<NSURLSessionDelegate>

+ (instancetype)sharedInstance;

+(void)asyncGet:(NSString *)urlStr
         header:(NSDictionary *)header
   successBlock:(void(^)(id response))successBlock
   failureBlock:(void(^)(NSError *error))failureBlock;

+(void)asyncPost:(NSString *)urlStr
          header:(NSDictionary *)header
          params:(NSDictionary *)params
    successBlock:(void(^)(id response))successBlock
    failureBlock:(void(^)(NSError *error))failureBlock;

@end

NS_ASSUME_NONNULL_END
