//
//  FTConfiguration.h
//  fertile
//
//  Created by vincent on 16/2/14.
//  Copyright © 2016年 fruit. All rights reserved.
//

#ifndef FTConfiguration_h
#define FTConfiguration_h


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf, weakSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;


//#define FLog(format, ...) NSLog((@"%s@%d: " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define FTDLog(format, ...) [FTLoggerHelper log4Debug:[NSString stringWithFormat:(@"" format),##__VA_ARGS__]];
#define FTELog(format, ...) [FTLoggerHelper log4Error:[NSString stringWithFormat:(@"" format),##__VA_ARGS__]];
#define FTILog(format, ...) [FTLoggerHelper log4Info:[NSString stringWithFormat:(@"" format),##__VA_ARGS__]];


/** 本地化语言 */
#define FTLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#define FT_STRING(__POINTER)    FTLocalizedString(__POINTER, nil)




/**
 * Make global functions usable in C++
 */
#if defined(__cplusplus)
#define FT_EXTERN extern "C" __attribute__((visibility("default")))
#else
#define FT_EXTERN extern __attribute__((visibility("default")))
#endif


/**
 * Throw an assertion for unimplemented methods.
 */
#define FT_NOT_IMPLEMENTED(method) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wmissing-method-return-type\"") \
_Pragma("clang diagnostic ignored \"-Wunused-parameter\"") \
FT_EXTERN NSException *_FTNotImplementedException(SEL, Class); \
method NS_UNAVAILABLE { @throw _FTNotImplementedException(_cmd, [self class]); } \
_Pragma("clang diagnostic pop")


#endif /* FTConfiguration_h */




#define FTScreenWidth [FTSystemHelper screenWidth]
#define FTScreenHeight [FTSystemHelper screenHeight]
#define FTOnePixeWidth [FTSystemHelper onePixeWidth]
#define FTColor(hexStr) [UIColor colorWithHexString:hexStr]

#define notEmptyStr(str) !emptyStr(str)
#define emptyStr(str) [NSString emptyOrNil:str]

