//
//  FTPopupWidget.m
//  fertile
//
//  Created by vincent on 2017/3/3.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import "FTPopupWidget.h"

@implementation FTPopupSubWidget

- (CGFloat)contentHeight
{
    //返回高度
    return 0;
}

@end

@implementation FTPopupWidget



//
//@property (strong, nonatomic) IBOutlet UIView *bgView;
//@property (strong, nonatomic) IBOutlet UIView *pushView;
//
//
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pushViewBottomConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pushViewCons_Height;
//@property (assign, nonatomic) CGFloat  allViewHeight;
//
//@property (strong, nonatomic) CTFlightCommonUpPushSubView *contentView;
//
//@property (weak, nonatomic) CTRootViewController *toVC;
//@property (assign, nonatomic) BOOL needResetCanDragBack;
//@end
//
//
//@implementation CTFlightCommonUpPushView
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    [self addTapGesture];
//}
//
//
//-(void)updateView
//{
//    self.pushViewCons_Height.constant = self.allViewHeight;
//    self.pushViewBottomConstraint.constant = self.allViewHeight;
//    __weak typeof(self) weakSelf = self;
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.pushView.mas_left);
//        make.top.equalTo(weakSelf.pushView.mas_top);
//        make.right.equalTo(weakSelf.pushView.mas_right);
//        make.bottom.equalTo(weakSelf.pushView.mas_bottom);
//    }];
//    
//    [self.pushView updateConstraintsIfNeeded];
//    [self.pushView updateConstraints];
//    
//    
//}
//
- (void)presentWithView:(FTPopupSubWidget *)contentView
{
//    self.contentView =  contentView;
//    self.allViewHeight = [contentView contentHeight];
//    if (self.allViewHeight > CTScreenHeight*2/3.0) {
//        self.allViewHeight = CTScreenHeight*2/3.0;
//    }
//    [self.pushView addSubview:self.contentView];
//    
//    [self updateView];
//    self.frame = [UIScreen mainScreen].bounds;
//    self.bgView.alpha = 0;
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    [self layoutIfNeeded];
//    
//    [UIView animateWithDuration:0.35f animations:^(void){
//        self.pushViewBottomConstraint.constant = 0;
//        self.bgView.alpha = 0.8f;
//        [self layoutIfNeeded];
//    } completion:^(BOOL finished){
//    }];
//    
}
//
- (void)presentWithView:(FTPopupSubWidget *)contentView toVc:(FTBaseViewController *)toVc
{
//
//    if ([toVc isKindOfClass:[CTRootViewController class]]) {
//        self.toVC = toVc;
//        if (self.toVC.ctripNavigationController.canDragBack == YES) {
//            self.needResetCanDragBack = YES;
//            self.toVC.ctripNavigationController.canDragBack = NO;
//        }
//        
//        self.contentView =  contentView;
//        self.allViewHeight = [contentView contentHeight];
//        if (self.allViewHeight > CTScreenHeight*2/3.0) {
//            self.allViewHeight = CTScreenHeight*2/3.0;
//        }
//        [self.pushView addSubview:self.contentView];
//        [self updateView];
//        self.frame = [UIScreen mainScreen].bounds;
//        self.bgView.alpha = 0;
//        [toVc.containerView.superview addSubview:self];
//        [toVc.containerView bringSubviewToFront:self];
//        [self layoutIfNeeded];
//        
//        [UIView animateWithDuration:0.35f animations:^(void){
//            self.pushViewBottomConstraint.constant = 0;
//            self.bgView.alpha = 0.8f;
//            [self layoutIfNeeded];
//        } completion:^(BOOL finished){
//        }];
//    }else{
//        [self presentWithView:contentView];
//    }
}
//
//
//
- (void)dismissView
{
//    [UIView animateWithDuration:.35f animations:^{
//        self.pushViewBottomConstraint.constant = self.allViewHeight;
//        self.bgView.alpha = 0;
//        [self layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        if ([self.pushViewDelegate respondsToSelector:@selector(afterDismissViewWithView:)])
//        {
//            [self.pushViewDelegate afterDismissViewWithView:self];
//        }
//        if (self.toVC != nil && self.needResetCanDragBack) {
//            self.toVC.ctripNavigationController.canDragBack = YES;
//        }
//        [self removeFromSuperview];
//    }];
}
//
- (void)dismissViewNoAnimation
{
//    if (self.toVC != nil && self.needResetCanDragBack) {
//        self.toVC.ctripNavigationController.canDragBack = YES;
//    }
//    [self removeFromSuperview];
}
//
//
//
///**
// * 添加点击空白区域隐藏视图手势
// */
//-(void)addTapGesture
//{
//    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToBlankSpaceCancel:)];
//    [self.bgView addGestureRecognizer:tapGestureRecognize];
//}
//
//
//- (void)tapToBlankSpaceCancel:(UITapGestureRecognizer *)recognizer
//{
//    if (self.pushViewDelegate && [self.pushViewDelegate respondsToSelector:@selector(tapToBlankSpaceCancelActionWithView:)]) {
//        [self.pushViewDelegate tapToBlankSpaceCancelActionWithView:self];
//    }
//    [self dismissView];
//}


@end
