//
//  KeyChainUtil.m
//  packageManager
//
//  Created by vincent on 2018/12/26.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "FTKeyChainUtil.h"

@implementation FTKeyChainUtil


+(NSString *) getClientId {
  id value = [self getKeychainDataForKey:@"clientID"];
  if (value) {
    return (NSString *)value;
  } else {
    return @"";
  }
}

+(void) setClientId:(NSString *)clientId {
  if (clientId && clientId.length > 0) {
    [self addKeychainData:clientId forKey:@"clientID"];
  }
}



+ (id)getKeychainDataForKey:(NSString *)key{
  id ret = nil;
  NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
  //Configure the search setting
  //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
  [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
  [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
  CFDataRef keyData = NULL;
  if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
    @try {
      ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
    } @catch (NSException *e) {
      NSLog(@"Unarchive of %@ failed: %@",key,e);
    } @finally {
    }
  }
  if (keyData)
    CFRelease(keyData);
  return ret;
}

+ (void)addKeychainData:(id)data forKey:(NSString *)key{
  //Get search dictionary
  NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
  //Delete old item before add new item
  SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
  //Add new object to search dictionary(Attention:the data format)
  [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
  //Add item to keychain with the search dictionary
  SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}


+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
  return [NSMutableDictionary dictionaryWithObjectsAndKeys:
          (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
          service, (__bridge id)kSecAttrService,
          service, (__bridge id)kSecAttrAccount,
          (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
          nil];
}

@end
