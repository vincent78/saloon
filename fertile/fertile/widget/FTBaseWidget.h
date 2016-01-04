//
//  FTBaseWidget.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseViewController.h"

@interface FTBaseWidget : UIView

/**
 *  @brief  widget 已在界面上显示
 */
@property(nonatomic) BOOL isAppear;


#pragma mark - 通过XIB获取视图对象
+ (UIView *)getViewFromXib:(NSString *)xibName;
+ (UIView *)getViewFromXib:(NSString *)xibName atIndex:(NSInteger)index;

#pragma mark - 外部可用操作


@end
