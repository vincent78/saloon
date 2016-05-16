//
//  UIColor+normal.h
//  fertile_oc
//
//  Created by vincent on 15/11/27.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FTNormal)

/**
 *  @brief  生成纯色的图片
 *
 *  @return <#return value description#>
 */
-(UIImage *)toImage;

-(UIImage *)toImageWithRect:(CGRect)rect;

/**
 *  @brief  按#FFFFFF生成UIColor
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  @brief 更改Color的alpha值
 *
 *  @param color <#color description#>
 *  @param alpha <#alpha description#>
 *
 *  @return <#return value description#>
 */
+(UIColor *) change:(UIColor *)color withAlpha:(CGFloat)alpha;

@end
