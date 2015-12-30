//
//  FTLineWidget.h
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTLineWidget : FTBaseWidget

@property UIColor *strokeColor;

/**
 *  @brief  画一横线
 *
 *  @param width <#width description#>
 *  @param color <#color description#>
 *  @param point <#point description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithWidth:(CGFloat)width withColor:(UIColor *)color withPoint:(CGPoint)point;


/**
 *  @brief  画一坚线
 *
 *  @param height <#height description#>
 *  @param color  <#color description#>
 *  @param point  <#point description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithHeight:(CGFloat)height withColor:(UIColor *)color withPoint:(CGPoint)point;


/**
 *  @brief  画一矩形
 *
 *  @param frame <#frame description#>
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame withColor:(UIColor *)color;

@end
