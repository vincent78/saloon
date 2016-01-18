//
//  FTSystemHelper.h
//  fertile_oc
//
//  系统级别的Helper
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"

@interface FTSystemHelper : FTBaseHelper

+ (FTSystemHelper*)sharedInstance;

/**
 *  @brief  状态栏的高度
 *
 *  @return <#return value description#>
 */
+ (CGFloat)statusBarHeight;

/**
 *  @brief  导航栏的高度
 *
 *  @return <#return value description#>
 */
+ (CGFloat)navBarHeight;

/**
 *  @brief  返回屏幕的高度
 *
 *  @return <#return value description#>
 */
+ (CGFloat)screenHeight;

/**
 *  @brief  返回屏幕的宽度
 *
 *  @return <#return value description#>
 */
+ (CGFloat)screenWidth;

/**
 *  @brief  获取当前系统的scale
 *
 *  @return <#return value description#>
 */
+ (CGFloat) scale;

/**
 *  @brief  单像素线的宽度
 *
 *  @return <#return value description#>
 */
+(CGFloat)onePixeWidth;


/**
 *  @brief  单像素线的偏移
 
  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
 
 *
 *  @return <#return value description#>
 */
+(CGFloat) singleLineAdjustOffset;


#pragma mark - 字体相关


/**
 *  @brief  打印出系统所有的字体信息
 */
+(void)printSysAllFontInfo;

/**
 *  @brief  动态加载字体文件
 *
 *  @param fontFile <#fontFile description#>
 */
+(void)registFont:(NSString *)fontFile;
/**
 *  @brief 动态卸载字体
 *
 *  @param fontName <#fontName description#>
 */
+(void)unregistFont:(NSString *)fontFile;

#pragma mark - 内存相关

/**
 *  @brief  获取当前设备可用内存(单位：MB）
 *
 *  @return <#return value description#>
 */
- (double)availableMemory;

/**
 *  @brief  获取当前任务所占用的内存（单位：MB）
 *
 *  @return <#return value description#>
 */
- (double)usedMemory;

@end
