//
//  UIView+normal.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (normal)

//以下属性setter可用
@property(nonatomic) CGFloat ftWidth;
@property(nonatomic) CGFloat ftHeight;

@property(nonatomic) CGFloat ftTop;
@property(nonatomic) CGFloat ftLeft;
@property(nonatomic) CGFloat ftRight;
@property(nonatomic) CGFloat ftBottom;

@property(nonatomic) CGSize ftSize;
@property(nonatomic) CGPoint ftOrigin;

/**
 *  show the border around the view
 *
 *  @param color border color
 */
- (void)showBorderWithColor:(UIColor *)color;

/**
 *  @brief  从同名的xib中返回UIView
 *
 *  @return <#return value description#>
 */
+ (instancetype)extractFromXib;

/**
 *  @brief  As its name hints.
 */
- (void)removeAllSubView;
/**
 *  @brief As its name hints.
 */
- (void)printPosition;

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
-(void)fillInParent:(UIEdgeInsets)edgeInsets;

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

@end
