//
//  FTPopupWidget.h
//  fertile
//
//  Created by vincent on 2017/3/3.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPopupWidget;
@protocol FTPopupWidgetDelegate <NSObject>
@optional
/**
 *  消散之后的操作
 */
- (void)afterDismissViewWithView:(FTPopupWidget *)view;
/**
 *  点击空白处的取消弹框的操作
 */
- (void)tapToBlankSpaceCancelActionWithView:(FTPopupWidget *)view;

@end


@interface FTPopupSubWidget : UIView

- (CGFloat)contentHeight;

@end


@interface FTPopupWidget : UIView

/**本类代理*/
@property(nonatomic, weak) id<FTPopupWidgetDelegate> pushViewDelegate;

- (void)presentWithView:(FTPopupSubWidget *)contentView;
- (void)dismissView;
//用于弹框有后续跳转的
- (void)presentWithView:(FTPopupSubWidget *)contentView toVc:(FTBaseViewController *)toVc;
//无动画的返回到前一界面
- (void)dismissViewNoAnimation;


@end
