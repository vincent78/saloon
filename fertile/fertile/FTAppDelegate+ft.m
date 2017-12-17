//
//  FTAppDelegate+ft.m
//  fertile
//
//  Created by vincent on 2017/12/16.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import "FTAppDelegate+ft.h"

@implementation FTAppDelegate (ft)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FTDLog(@"category load");
    });
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        FTDLog(@"%s",__FUNCTION__ );
    }
    return self;
}

@end
