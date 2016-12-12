//
//  FTVectorBaseView.h
//  fertile
//
//  Created by vincent on 2016/12/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *各BU在下面按对应顺序加入ttf文件名和对应的枚举类型
 */
#define FT_FONT_FAMLIY_NAME_ARRAY @[@"ct_font_common",@"ct_font_flight",@"ct_font_home"]

#define VectorImageNameSeperator    @"*_|_*"


typedef NS_ENUM(NSInteger,eCTIConFontFamliyName){
    eCTIConFontFamliyName_common = 0, //公共
    eCTIConFontFamilyName_flight = 1, //机票
    eCTIConFontFamilyName_home   = 2  //首页
};

@interface FTVectorBaseView : UIView

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
 iconfont 2 UIImage
 */
-(UIImage*)toUIImage;

/**
 自动调整矢量图大小
 默认为YES
 */
@property (nonatomic, assign) BOOL autoSizable;

@end
