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
 *  @brief  widget 已经加载过
 */
@property(nonatomic) BOOL hasDidLoad;

/**
 *  @brief  widget 已在界面上显示
 */
@property(nonatomic) BOOL hasAppeared;

/**
 *  As its name hints.
 */
@property(nonatomic, strong) NSMutableArray *subWidgets;

#pragma mark - widget circle

/**
 Widget的创建、显示与消失各个阶段的
 在用showInVC:方法或者dismissWidget方法，显示或者消失此Widget时，
 会在不同的时间里，模仿UIViewController里的viewWillAppear等一些方法，方便做一些逻辑的处理，
 */

- (void)widgetDidLoad;

- (void)widgetWillAppear;  //显示前会调用，显示方法参考 showInView:
- (void)widgetDidAppear;   //显示后会调用，显示方法参考 showInView:

- (void)widgetWillDisappear;  //显示前会调用，显示方法参考 showInView:
- (void)widgetDidDisappear;  //显示后会调用，显示方法参考 showInView:

#pragma mark - 通过XIB获取视图对象
+ (UIView *)getViewFromXib:(NSString *)xibName;
+ (UIView *)getViewFromXib:(NSString *)xibName atIndex:(NSInteger)index;

#pragma mark - 外部可用操作
/**
 *  @brief  在viewcontroller中显示widget

 这个方法的调用中应该在viewcontroller已显示完成，即最早也应该在viewDidAppear中调用。

 *  @param vc <#vc description#>
 */
- (void)showInVC:(FTBaseViewController *)vc;

- (void)showInView:(UIView *)pView;

/**
 *  @brief  widget的消失
 */
- (void)dismiss;

@end
