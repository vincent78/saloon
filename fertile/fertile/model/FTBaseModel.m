//
//  FTBaseModel.m
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseModel.h"
#import <objc/runtime.h>



@implementation FTBaseModel

- (id)copyWithZone:(NSZone *)zone
{
    return [FTObjectUtil cloneObj:self];
}

@end
