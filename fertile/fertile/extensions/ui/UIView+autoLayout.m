//
//  UIView+autoLayout.m
//  fertile
//
//  Created by vincent on 16/4/27.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "UIView+autoLayout.h"

@implementation UIView (autoLayout)


- (void)centerVertically {
    if (self.superview == nil) {
        return;
    }
    
    CGRect myFrame = self.frame;
    myFrame.origin.y =
    (self.superview.frame.size.height - myFrame.size.height) / 2;
    self.frame = myFrame;
}

- (void)centerHorizontally {
    if (self.superview == nil) {
        return;
    }
    
    CGRect myFrame = self.frame;
    myFrame.origin.x = (self.superview.frame.size.width - myFrame.size.width) / 2;
    self.frame = myFrame;
}

- (void)centerInParent {
    if (self.superview == nil) {
        return;
    }
    CGRect myFrame = self.frame;
    myFrame.origin.y =
    (self.superview.frame.size.height - myFrame.size.height) / 2;
    myFrame.origin.x = (self.superview.frame.size.width - myFrame.size.width) / 2;
    self.frame = myFrame;
}

-(void)fillInParent
{
    [self fillInParent:UIEdgeInsetsZero];
}

-(void)fillInParent:(UIEdgeInsets)paddingConfig
{
    if (!self.superview)
        return;
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self,@"selfView", nil];
    NSDictionary *metrics1 = @{ @"leftPadding": [NSNumber numberWithFloat:paddingConfig.left]
                                , @"rightPadding": [NSNumber numberWithFloat:paddingConfig.right] };
    NSString *vfl1 = @"H:|-leftPadding-[selfView]-rightPadding-|";
    NSDictionary *metrics2 = @{ @"topPadding": [NSNumber numberWithFloat:paddingConfig.top]
                                , @"bottomPadding": [NSNumber numberWithFloat:paddingConfig.bottom] };
    NSString *vfl2 = @"V:|-topPadding-[selfView]-bottomPadding-|";
    [self.superview
     addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:vfl1 options:0 metrics:metrics1 views:dict]];
    [self.superview
     addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:vfl2 options:0 metrics:metrics2 views:dict]];
}

-(void) fillInView:(UIView *)pView
{
    [self fillInView:pView withEdgeInsets:UIEdgeInsetsZero];
}

-(void) fillInView:(UIView *)pView withEdgeInsets:(UIEdgeInsets)edgeInsets
{
    if (!pView)
        return;
    [pView addSubview:self];
    [self fillInParent:edgeInsets];
}


-(void)makeSubSameWidthWithPadding:(CGFloat)LRpadding viewPadding:(CGFloat)viewPadding
{
    UIView *lastView;
    WS(weakSelf)
    for (UIView *view in self.subviews) {
//        [self addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(LRpadding);
                make.top.bottom.equalTo(weakSelf);
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-LRpadding);
    }];
}


-(void)makeSubSameHeightWithPadding:(CGFloat)TBpadding viewPadding:(CGFloat)viewPadding
{
    UIView *lastView;
    WS(weakSelf)
    for (UIView *view in self.subviews) {
        //        [self addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(weakSelf);
                make.top.equalTo(lastView.mas_bottom).offset(viewPadding);
                make.height.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset(TBpadding);
                make.left.right.equalTo(weakSelf);
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-TBpadding);
    }];
}




@end
