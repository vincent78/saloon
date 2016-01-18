//
//  FTBaseVectorView.h
//  fertile_oc
//
//  Created by vincent on 15/11/3.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"

#define MainFontFileNameForVectorLabel @"iconfont"

@interface FTVectorView : FTBaseWidget

/**
 @private 不建议直接使用
 图片类型（字体类型）
 */
@property (nonatomic, strong)NSString *fontFamily;
/**
 @private 不建议直接使用
 矢量图大小
 */
@property (readonly, assign)CGFloat fontContentSize;
/**
 @private 不建议直接使用
 矢量图颜色
 */
@property (nonatomic, strong)UIColor *fontColor;
/**
 矢量图内容(只能有一个图片，不然会出现...被压缩现象)
 */
@property (nonatomic, strong)NSString *fontName;


/**
 @private 不建议直接使用
 初始化矢量图
	@param frame 图像大小
	@param fontFamily 图片Family（字体类型）
	@param fontName 图片内容（字体内容）
	@return id 矢量图
 */
-(id)initWithFrame:(CGRect)frame
    fontFamilyName:(NSString *)fontFamily
          fontName:(NSString *)fontName;

/**
 *  @brief 初始化矢量图
 *
 *  @param frame       图像大小
 *  @param fontFamily1 图片Family（字体类型）
 *  @param fontName1   图片内容（字体内容）
 *  @param fontColor1  颜色
 *
 *  @return 矢量图
 */
- (id)initWithFrame:(CGRect)frame
     fontFamilyName:(NSString*)fontFamily1
           fontName:(NSString*)fontName1
          fontColor:(UIColor *)fontColor1;


/**
 *  @brief  转成UIImage
 *
 *  @return <#return value description#>
 */
-(UIImage *) toImage;



/**
 自动调整矢量图大小
 默认为YES
 */
@property (nonatomic, assign) BOOL autoSizable;

@end
