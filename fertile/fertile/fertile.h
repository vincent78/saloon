//
//  fertile_oc.h
//  fertile_oc
//
//  Created by vincent on 15/10/19.
//  Copyright © 2015年 fruit. All rights reserved.
//



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


#ifdef __OBJC__

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "masonry.h"

#import "FTConfiguration.h"
#import "FTExtensions.h"
#import "FTModel.h"
#import "FTUtil.h"
#import "FTHelper.h"
#import "FTWidget.h"
#import "FTViewController.h"




//! Project version number for fertile_oc.
FOUNDATION_EXPORT double fertile_ocVersionNumber;

//! Project version string for fertile_oc.
FOUNDATION_EXPORT const unsigned char fertile_ocVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <fertile_oc/PublicHeader.h>

#endif


