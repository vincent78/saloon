//
//  FTBaseWidget.m
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"

@interface FTBaseWidget () {
}

@end

@implementation FTBaseWidget

#pragma mark - circle

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [self removeAllSubView];
}

#pragma mark - 通过XIB获取视图对象

+ (UIView*)getViewFromXib:(NSString*)xibName
{
    return [self getViewFromXib:xibName atIndex:0];
}

+ (UIView*)getViewFromXib:(NSString*)xibName atIndex:(NSInteger)index
{
    NSArray* array =
        [[NSBundle mainBundle] loadNibNamed:xibName
                                      owner:nil
                                    options:nil];
    UIView* view = nil;
    if (array) {
        view = [array safeObjectAtIndex:index];
    }

    return view;
}

#pragma mark - 外部可用操作

@end
