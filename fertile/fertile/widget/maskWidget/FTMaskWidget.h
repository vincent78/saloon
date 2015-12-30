//
//  FTMaskWidget.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"

@class FTMaskView;
@protocol FTMaskWidgetDelegate <NSObject>
@optional

-(void) willRemovedFromSuperView:(FTMaskView *)maskView;

-(void) willRemovedFromSuperView:(FTMaskView *)maskView
               gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer;

@end

@interface FTMaskWidget : FTBaseWidget

/**
 *  @brief  遮罩的代理
 */
@property (nonatomic,assign) id<FTMaskWidgetDelegate> delegate;

/**
 *  @brief  遮罩的父容器  nil则添加到主窗口
 */
@property (nonatomic,weak) UIView *containerView;

/**
 *  @brief 遮罩中显示的内容
 */
@property (nonatomic,weak) UIView *contentWidget;



-(void) hide;

-(void) show;


@end
