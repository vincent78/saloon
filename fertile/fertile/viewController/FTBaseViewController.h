//
//  FTBaseViewController.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FTNavigateWidget;

@interface FTBaseViewController : UIViewController

#pragma mark - 初始化对象
@property (nonatomic,strong) FTNavigateWidget *ftNavWidget;

/**
 *  @brief  内容容器
 */
@property (nonatomic,strong) UIView *contentView;

#pragma mark - 导航栏相关

/**
 *  @brief  是否显示导航栏
 */
@property (nonatomic) BOOL showNav;

/**
 *  @brief  是否显示状态栏
 */
@property (nonatomic) BOOL showStatusBar;

/**
 *  @brief  导航栏与状态栏是否重叠
 */
@property (nonatomic) BOOL overlapNavAndStatusBar;








@end
