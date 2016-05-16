//
//  UIView+normal.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FTNormal)

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
 *
 *  @param tag <#tag description#>
 */
-(void) removeSubViewByTag:(int)tag;



/**
 *  @brief As its name hints.
 */
- (void)printPosition;


/**
 *  @brief 从xib文件中取得第一个view
 *
 *  @param owner <#owner description#>
 *
 *  @return <#return value description#>
 */
- (instancetype) viewFromClassXibWithOwner:(id)owner;

- (instancetype) viewWithXibNamed:(NSString*) xibName owner:(id)owner;

/**
 *  @brief 将UIView转成UIImage 截屏
 *
 *  @return <#return value description#>
 */
- (UIImage *) getImage;



@end
