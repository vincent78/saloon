//
//  RemoteUtil.m
//  packageManager
//
//  Created by vincent on 2018/12/21.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "FTRemoteUtil.h"
#import "NSDictionary+FTJson.h"

@interface FTRemoteUtil() <NSURLSessionDelegate> {
  
}

@end

@implementation FTRemoteUtil

static FTRemoteUtil *instance = nil;

+ (instancetype)sharedInstance
{
  return [[self alloc] init];
}
- (instancetype)init
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [super init];
    [instance initData];
  });
  return instance;
}

-(void) initData {
  
}

#pragma mark - https post

+(void)asyncPost:(NSString *)urlStr
          params:(NSDictionary *)params
    successBlock:(void(^)(id response))successBlock
    failureBlock:(void(^)(NSError *error))failureBlock {
  [self asyncPost:urlStr header:nil params:params timeout:5 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData successBlock:successBlock failureBlock:failureBlock];
}

+(void)asyncPost:(NSString *)urlStr
          header:(NSDictionary *)header
          params:(NSDictionary *)params
    successBlock:(void(^)(id response))successBlock
    failureBlock:(void(^)(NSError *error))failureBlock {
  [self asyncPost:urlStr header:header params:params timeout:5 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData successBlock:successBlock failureBlock:failureBlock];
}

+(void)asyncPost:(NSString *)urlStr
          header:(NSDictionary *)header
          params:(NSDictionary *)params
         timeout:(NSTimeInterval)timeout
     cachePolicy:(NSURLRequestCachePolicy)cachePolicy
    successBlock:(void(^)(id response))successBlock
    failureBlock:(void(^)(NSError *error))failureBlock {
  //  NSLog(@"接收到的参数：%@",params);
  //1.构造URL,对特殊字符进行编码
  NSString *urlString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
  NSURL *url = [NSURL URLWithString:urlString];
  // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
  //  NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
  //  NSURLRequestReloadIgnoringLocalCacheData
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:cachePolicy timeoutInterval:timeout];
  if (header) {
    for (NSString *key in header.allKeys) {
      NSString *value = [header objectForKey:key];
      if (key && key.length > 0 && value && value.length > 0) {
        [request addValue:value forHTTPHeaderField:key];
      }
    }
  }
  [request setHTTPMethod:@"POST"];
  if (params) {
    NSString *query = nil;
    for (NSString *key in params.allKeys) {
      id value = [params objectForKey:key];
      NSString *str;
      if (value && [value isKindOfClass:NSString.class]) {
        str = (NSString *)value;
      } else if (value && [value isKindOfClass:NSDictionary.class]){
        str = [(NSDictionary *)value jsonString];
      } else {
        str = @"";
      }
      if (query.length > 0) {
        query = [query stringByAppendingString:@"&"];
      }
      query = [NSString stringWithFormat:@"%@%@=%@",query?:@"",key,str];
    }
    query = [query stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    query = [query stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSLog(@"[********query]:%@",query);
    if (query && query.length) {
      if (![request valueForHTTPHeaderField:@"Content-Type"]) {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
      }
      [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
    }
  }
  
  
  
  // 3.session
  NSURLSession *sharedSession = [[FTRemoteUtil sharedInstance] genURLSession:url];
  
  // 4.由系统直接返回一个dataTask任务
  NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    // 网络请求完成之后就会执行，NSURLSession自动实现多线程
    //    NSLog(@"%@",[NSThread currentThread]);
    if (data && (error == nil)) {
      // 网络访问成功
      NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"[-----data]:%@",retStr);
      if (successBlock) {
        successBlock(retStr);
      }
    } else {
      // 网络访问失败
      //      NSLog(@"error=%@",error);
      if (failureBlock) {
        failureBlock(error);
      }
    }
  }];
  
  // 5.每一个任务默认都是挂起的，需要调用 resume 方法
  [dataTask resume];
}


-(NSURLSession *) genURLSession:(NSURL *)url {
  if ([[url.absoluteString lowercaseString] hasPrefix:@"https://"]) {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    return  [NSURLSession sessionWithConfiguration:config
                                          delegate:self
                                     delegateQueue:[NSOperationQueue mainQueue]];
  } else {
    return [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                         delegate:self
                                    delegateQueue:[NSOperationQueue mainQueue]];
  }
}
#pragma mark - https get

+(void)asyncGet:(NSString *)urlStr
         header:(NSDictionary *)header
   successBlock:(void(^)(id response))successBlock
   failureBlock:(void(^)(NSError *error))failureBlock {
  [self asyncGet:urlStr header:header params:nil timeout:5 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData successBlock:successBlock failureBlock:failureBlock];
}

+(void)asyncGet:(NSString *)urlStr
         header:(NSDictionary *)header
         params:(NSDictionary *)params
        timeout:(NSTimeInterval)timeout
    cachePolicy:(NSURLRequestCachePolicy)cachePolicy
   successBlock:(void(^)(id response))successBlock
   failureBlock:(void(^)(NSError *error))failureBlock {
  //1.构造URL,对特殊字符进行编码
  NSString *urlString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
  NSURL *url = [NSURL URLWithString:urlString];
  // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
  //  NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:cachePolicy timeoutInterval:timeout];
  if (header) {
    for (NSString *key in header.allKeys) {
      NSString *value = [header objectForKey:key];
      if (key && key.length > 0 && value && value.length > 0) {
        [request addValue:value forHTTPHeaderField:key];
      }
    }
  }
  
  // 3.session
  NSURLSession *sharedSession = [[self sharedInstance] genURLSession:url];
  
  // 4.由系统直接返回一个dataTask任务
  NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    // 网络请求完成之后就会执行，NSURLSession自动实现多线程
    NSLog(@"%@",[NSThread currentThread]);
    if (data && (error == nil)) {
      // 网络访问成功
      NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"data=%@",retStr);
      if (successBlock) {
        successBlock(retStr);
      }
      
    } else {
      // 网络访问失败
      //      NSLog(@"error=%@",error);
      if (failureBlock) {
        failureBlock(error);
      }
    }
  }];
  
  // 5.每一个任务默认都是挂起的，需要调用 resume 方法
  [dataTask resume];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
  //    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
  //        if([challenge.protectionSpace.host isEqualToString:@"yourdomain.com"]){
  //            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
  //            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
  //        }
  //    }
  
  if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
  }
  
  //    NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
  //  completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
}


@end
