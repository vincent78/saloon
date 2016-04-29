//
//  UIView+autoLayout.h
//  fertile
//
//  Created by vincent on 16/4/27.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (autoLayout)


/**
 *  As its name hints.
 **/
- (void)centerHorizontally;

/**
 *  As its name hints.
 **/
- (void)centerVertically;

/**
 *  @brief  As its name hints.
 */
- (void)centerInParent;

/**
 *  @brief  As its name hints.
 充满容器大小，随容器的变化而变化
 */
-(void)fillInParent;

/**
 *  @brief <#Description#>
 *
 *  @param fillInView <#fillInView description#>
 *  @param pView      <#pView description#>
 */
-(void)fillInParent:(UIEdgeInsets)paddingConfig;

/**
 *  @brief As its name hints
 *
 *  @param pView <#pView description#>
 */
-(void) fillInView:(UIView *)pView;

/**
 *  @brief <#Description#>
 *
 *  @param pView      <#pView description#>
 *  @param edgeInsets <#edgeInsets description#>
 */
-(void) fillInView:(UIView *)pView withEdgeInsets:(UIEdgeInsets)edgeInsets;


/**
 *  @brief 将子视图等宽排列，
 *
 *  @param LRpadding   与parentView的边距
 *  @param viewPadding 子视图之间的边距
 */
-(void)makeSubSameWidthWithPadding:(CGFloat)LRpadding viewPadding:(CGFloat)viewPadding;

/**
 *  @brief 将子视图等高排列
 *
 *  @param TBpadding   与parentView的连距
 *  @param viewPadding 子视图之前的边距
 */
-(void)makeSubSameHeightWithPadding:(CGFloat)TBpadding viewPadding:(CGFloat)viewPadding;



@end
