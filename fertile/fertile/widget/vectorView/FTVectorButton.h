//
//  FTVectorButton.h
//  fertile
//
//  Created by vincent on 2016/12/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTVectorBaseView.h"

@interface FTVectorButton : UIButton
/**
 新的iconfont设置方法，直接设置默认状态
 @param fontFamily 字符集
	@param imageName 图像名称
 */
-(void)setVectorFontFamliyName:(NSString*)fontFamily imageCode:(NSString *)imageCode;

/**
 新的iconfont设置方法
	@param iconFontFamliyName 在CTBaseVectorImage.h中定义的枚举
	@param imageCode  图像名称
 */
-(void)setVectorFontFamliyNameWith:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode;

/**
 新的iconfont设置方法
	@param fontFamily 字符集
 @param imageCode 图像名称
	@param state    状态
 */
-(void)setVectorFontFamliyName:(NSString*)fontFamily imageCode:(NSString *)imageCode forState:(UIControlState)state;

/**
 新的iconfont设置方法（
 @param iconFontFamliyName 在CTBaseVectorImage.h中定义的枚举
	@param imageCode 图像名称
	@param state    状态
 */
-(void)setVectorFontFamliyNameWith:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode forState:(UIControlState)state;

/**
 新的iconfont设置方法（支持图文混排）
 @param iconFontFamliyName 在CTBaseVectorImage.h中定义的枚举
	@param imageCode 图像名称
	@param text 文字内容
 @param textSize 文字大小
	@param state    状态
 */
-(void)setVectorFontFamliyNameWith:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode imageText:(NSString*)text textSize:(NSInteger)textSize forState:(UIControlState)state;

/**
 新的iconfont设置方法（支持图文混排）
 @param fontFamily 字符集
	@param imageCode 图像名称
 @param text 文字内容
 @param textSize 文字大小
	@param state    状态
 */
-(void)setVectorFontFamliyName:(NSString*)fontFamily imageCode:(NSString *)imageCode imageText:(NSString*)text textSize:(NSInteger)textSize forState:(UIControlState)state;

/**
 设置矢量图名字
	@param imageName 图像名称
	@param state    状态
 */
-(void)setVectorImageName:(NSString *)imageName forState:(UIControlState)state;

/**
 设置矢量图颜色
	@param imageName 图像颜色
	@param state    状态
 */
-(void)setVectorImageColor:(UIColor *)imageColor forState:(UIControlState)state;

/**
 获取图像颜色
	@param state 状态
	@return UIColor 矢量图颜色
 */
-(UIColor *)imageColorForState:(UIControlState)state;

/**
 获取图像名称
	@param state 状态
	@return NSString 矢量图名称
 */
-(NSString *)imageNameForState:(UIControlState)state;

/**
 iconfont 2 UIImage
 */
-(UIImage*)toUIImage;

/**
 矢量图大小
 只有在autoSizable == NO时才能手动，否则设置无效
 */
@property (nonatomic, assign) CGFloat imageSize;


/**
 自动调整矢量图大小
 默认为YES
 */
@property (nonatomic, assign) BOOL autoSizable;

/**
 供子类来使用，来判断当前子类是不是iconfont
 
 */
@property (nonatomic, readonly ,assign) BOOL isIconfont;


@end
