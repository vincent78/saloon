//
//  FT3DLineWidget.h
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"

@interface FT3DLineWidget : FTBaseWidget

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






@end
