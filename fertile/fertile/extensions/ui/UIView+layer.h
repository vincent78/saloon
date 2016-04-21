//
//  UIView+layer.h
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (layer)


/**
 *  @brief 圆角View（可以指定哪个角（上下左右）为圆角）
 *
 *  self.ticketBGView.opaque = YES; 这样ticketBGView就不会透明
 *  @param raidus    弯度
 *  @param corners   哪个角
 *  @param borderWidth 线条宽度
 *  @param borderColor 线条颜色
 *  @param patterns  折线样式 (可以是虚线)
 */
- (void)viewCornerRaidusType:(CGFloat)raidus
             roundingCorners:(UIRectCorner)corners
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor
           borderDashPattern:(NSArray *)patterns;

/**
 *  @brief 四个角全部设置成圆角
 *
 *  @param raidus      <#raidus description#>
 *  @param borderColor <#borderColor description#>
 *  @param borderWidth <#borderWidth description#>
 */
-(void)viewCornerRaidusType:(CGFloat)raidus
                borderColor:(UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth;
/**
 *  @brief 当前VIEW中添加一个渐进色的layer
 *
 *  @param rect   <#rect description#>
 *  @param colors [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.2f] CGColor], (id)[[UIColor clearColor] CGColor], nil];
 */
-(void) appendGradientLayer:(CGRect)rect withColors:(NSArray *)colors;

@end
