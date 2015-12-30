//
//  FTNavigateControllerModel.m
//  fertile_oc
//
//  Created by vincent on 15/11/5.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTNavigateControllerModel.h"

@implementation FTNavigateControllerModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.key = @"";
        self.nav = [UINavigationController new];
        self.parentKey = @"";
    }
    return self;
}

@end
