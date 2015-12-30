//
//  UIColor+normal.h
//  fertile_oc
//
//  Created by vincent on 15/11/27.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (normal)

/**
 *  @brief  生成纯色的图片
 *
 *  @return <#return value description#>
 */
-(UIImage *)toImage;

/**
 *  @brief  按#FFFFFF生成UIColor
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
