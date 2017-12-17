//
//  FTAppDelegate+debug.m
//  debug
//
//  Created by vincent on 2017/12/16.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import "FTAppDelegate+debug.h"


@implementation FTAppDelegate (debug)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FTDLog(@"%s",__FUNCTION__ );
    });
}

@end
