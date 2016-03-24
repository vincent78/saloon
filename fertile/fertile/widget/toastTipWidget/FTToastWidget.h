//
//  FTToastWidget.h
//  fertile
//
//  Created by vincent on 16/3/24.
//  Copyright © 2016年 fruit. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FTBaseWidget.h"

//渐入动画时间
#define kCTToastTipViewFadeinDuration 0.2
//停留显示时间
#define kCTToastTipViewDisplayDuration 2.5
//渐出动画时间
#define kCTToastTipViewFadeoutDuration 0.3
//提示文本字体
#define kCTToastTipViewTextFont [UIFont systemFontOfSize:15]

@interface FTToastWidget : FTBaseWidget


/**
	Toast样式提示自定义内容
 
	@param text 自定义文本
	@param view 要显示的父视图
 */
+ (void)showTipText:(NSString *)text inView:(UIView *)view;

/**
	Toast样式提示自定义内容
 
	@param text 自定义文本
	@param view 要显示的父视图
 @param width Toast框宽度
 */

+ (void)showTipText:(NSString *)text inView:(UIView *)view withWidth:(CGFloat)width;
/**
	Toast样式在Window上提示自定义内容
 
	@param text 自定义文本
 */
+ (void)showTipText:(NSString *)text;
/**
	Toast样式在Window上提示自定义内容
 
	@param text 自定义文本
 @param width Toast框宽度
 */
+ (void)showTipText:(NSString *)text withWidth:(CGFloat)width;

/**
 Toast样式在Window上提示自定义内容
 
 @param text 自定义文本 second 停留多少秒（单位是秒）
 */
+ (void)showTipText:(NSString *)text WithDisplayTime:(NSTimeInterval)iSecond;

/**
 Toast样式在Window上提示自定义内容，位置随机
 
 @param text 自定义文本
 */
+ (void)showTipTextInRandomLocation:(NSString *)text;

/**
 *  Toast样式在Window上提示自定义内容
 *
 *  @param text         自定义文本
 *  @param height       需要显示的高度
 *  @param cornerRadius 圆角弧度
 *  @param color        背景色
 *  @param view         在哪个view显示
 */
+ (void)showTipText:(NSString *)text height:(CGFloat)height cornerRadius:(CGFloat)cornerRadius color:(UIColor*)color inView:(UIView*)view;

@end
