//
//  FTVectorImageView.h
//  fertile
//
//  Created by vincent on 2016/12/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTVectorBaseView.h"

@interface FTVectorImageView : FTVectorBaseView

@property(strong, nonatomic) UIColor *imageColor;

@property(readonly, nonatomic, assign) CGFloat imageSize;

/**
 *新的iconfont机制的用imageCode来替换图片
 *
 */

@property(copy, nonatomic) NSString *imageCode;


/**
 *这个属性在使用新的iconfont机制的时候会出错，请换用 imageCode
 *
 */
@property(copy, nonatomic) NSString *imageName;

/**
 *新的iconfont,对于控件是XIB中outlet关联的，调用此方法直接设置iconfont相关信息
 *@fontFamilyName 写在plist中的ttf文件名(不带.ttf后缀,比如ct_font_common)
 *@imageCode 需要加载的图片中ttf中的unicode编码
 */
-(void)fontFamilyName:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode;

/**
 *新的iconfont初始函数
 *@frame frame
 *@fontFamilyName 写在plist中的ttf文件名(不带.ttf后缀,比如ct_font_common)
 *@imageCode 需要加载的图片中ttf中的unicode编码
 */
-(id)initWithFrame:(CGRect)frame fontFamilyName:(NSString*)fontFamily imageCode:(NSString *)imageCode;


/**
 *新的iconfont初始函数(建议使用这个方法)
 *@frame frame
 *@fontFamilyName 各BU的fontFamliy枚举
 *@imageCode 需要加载的图片中ttf中的unicode编码
 */
-(id)initWithFrame:(CGRect)frame iconFontFamliyName:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode;

/**
 初始化专用矢量图(这个方法是给以前的iconfont使用,\n新的从网站上下载的iconfont请使用-(id)initWithFrame:fontFamilyName:imageCode:)
	@param frame 图像大小
	@param imageName 图片内容（字体内容）
	@return id 矢量图
 */
-(id)initWithFrame:(CGRect)frame
         imageName:(NSString *)imageName;

@end
