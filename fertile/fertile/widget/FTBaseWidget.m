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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subWidgets = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - widget circle

- (void)widgetDidLoad
{
    for (int i = 0; i < self.subWidgets.count; i++) {
        FTBaseWidget* subWidget = [self.subWidgets safeObjectAtIndex:i];
        if (!subWidget.hasDidLoad)
            [subWidget widgetDidLoad];
    }
    self.hasDidLoad = YES;
}

- (void)widgetWillAppear
{
    for (int i = 0; i < self.subWidgets.count; i++) {
        FTBaseWidget* subWidget = [self.subWidgets safeObjectAtIndex:i];
        if (!subWidget.hasAppeared)
            [subWidget widgetWillAppear];
    }
}

- (void)widgetDidAppear
{
    for (int i = 0; i < self.subWidgets.count; i++) {
        FTBaseWidget* subWidget = [self.subWidgets safeObjectAtIndex:i];
        if (!subWidget.hasAppeared)
            [subWidget widgetDidAppear];
    }
    self.hasAppeared = YES;
}

- (void)widgetWillDisappear
{
    for (int i = (int)self.subWidgets.count - 1; i >= 0; i--) {
        FTBaseWidget* subWidget = [self.subWidgets safeObjectAtIndex:i];
        if (subWidget.hasAppeared)
            [subWidget widgetWillDisappear];
    }
}

- (void)widgetDidDisappear
{
    for (int i = (int)self.subWidgets.count - 1; i >= 0; i--) {
        FTBaseWidget* subWidget = [self.subWidgets safeObjectAtIndex:i];
        if (subWidget.hasAppeared)
            [subWidget widgetDidDisappear];
    }
    self.hasAppeared = NO;
}

- (void)dealloc
{
//    for (int i = (int)self.subWidgets.count - 1; i >= 0; i--) {
//        FTBaseWidget* widget = [self.subWidgets safeObjectAtIndex:i];
//        widget = nil;
//    }
    [self.subWidgets removeAllObjects];
    self.subWidgets = nil;
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

- (void)showInVC:(FTBaseViewController*)vc
{
    [self showInView:vc.view];
}

- (void)showInView:(UIView*)pView
{
    if (pView) {
        [self widgetDidLoad];

        [self widgetWillAppear];
        [pView addSubview:self];
        [self widgetDidAppear];
    }
}

- (void)dismiss
{
    if (self.hasAppeared) {
        [self widgetWillDisappear];
        [self removeFromSuperview];
        [self widgetDidDisappear];
    }
}
@end
