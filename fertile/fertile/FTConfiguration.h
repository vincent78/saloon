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
#define FTLog(format, ...) [FTLoggerHelper log4Debug:[NSString stringWithFormat:(@"" format),##__VA_ARGS__]];


#endif /* FTConfiguration_h */
