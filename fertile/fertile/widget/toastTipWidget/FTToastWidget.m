//
//  FTToastWidget.m
//  fertile
//
//  Created by vincent on 16/3/24.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTToastWidget.h"

@interface FTToastWidget()

@property (nonatomic, strong) FTMaskWidget *maskView;

@property (nonatomic, copy) NSString *tipText;
@property (nonatomic, strong) UILabel *tipLabelView;

- (void)forceHide;

@end

@implementation FTToastWidget

#pragma mark - --------------------退出清空--------------------

- (void)dealloc
{
    [_maskView removeFromSuperview], _maskView = nil;
}
#pragma mark - --------------------初始化--------------------

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initBaseView];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (_tipLabelView) {
        int edge = 10;
        [_tipLabelView setFrame:UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(edge, edge, edge, edge))];
    }
}

- (void)initBaseView
{
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    
    if (!_tipLabelView) {
        _tipLabelView = [[UILabel alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(2, 10, 2, 10))];
        [_tipLabelView setBackgroundColor:[UIColor clearColor]];
        [_tipLabelView setTextAlignment:NSTextAlignmentCenter];
        [_tipLabelView setTextColor:[UIColor whiteColor]];
        [_tipLabelView setFont:kCTToastTipViewTextFont];
        _tipLabelView.numberOfLines = INT_MAX;
    }
    
    [self addSubview:_tipLabelView];
    
    [self setClipsToBounds:YES];
    [self.layer setCornerRadius:5];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    if (newWindow) {
        if (_tipLabelView) {
            [_tipLabelView setText:self.tipText];
        }
    }
}
#pragma mark - --------------------功能函数--------------------

- (void)showInView:(UIView *)view
{
    if (!_maskView) {
        _maskView = [[FTMaskWidget alloc] initWithFrame:view.bounds];
    }
    
    [_maskView addSubview:self];
    
    [self setCenter:CGPointMake(_maskView.bounds.size.width/2.0, _maskView.bounds.size.height/2.0)];
    self.layer.opacity = 0.0;
    [view addSubview:_maskView];
    
    [self fadeInAnimationAfterDelay:kCTToastTipViewDisplayDuration];
}

- (void)showInView:(UIView *)view WithDisplayTime:(NSTimeInterval)iSecond
{
    if (!_maskView) {
        _maskView = [[FTMaskWidget alloc] initWithFrame:view.bounds];
    }
    
    [_maskView addSubview:self];
    
    [self setCenter:CGPointMake(view.bounds.size.width/2.0, view.bounds.size.height/2.0)];
    self.layer.opacity = 0.0;
    [view addSubview:_maskView];
    
    [self fadeInAnimationAfterDelay:iSecond];
}

- (void)fadeInAnimationAfterDelay:(NSTimeInterval)delay
{
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        [self performSelector:@selector(fadeOutAnimation) withObject:nil afterDelay:delay];
    }];
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [fadeInAnimation setDuration:kCTToastTipViewFadeinDuration];
    [fadeInAnimation setFromValue:[NSNumber numberWithFloat:0.0]];
    [fadeInAnimation setToValue:[NSNumber numberWithFloat:1.0]];
    [fadeInAnimation setRemovedOnCompletion:NO];
    [fadeInAnimation setFillMode:kCAFillModeForwards];
    [fadeInAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    [self.layer addAnimation:fadeInAnimation forKey:@"fadeIn"];
    
    [CATransaction commit];
}

- (void)fadeOutAnimation
{
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        [self forceHide];
    }];
    
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [fadeOutAnimation setDuration:kCTToastTipViewFadeoutDuration];
    [fadeOutAnimation setFromValue:[NSNumber numberWithFloat:1.0]];
    [fadeOutAnimation setToValue:[NSNumber numberWithFloat:0.0]];
    [fadeOutAnimation setRemovedOnCompletion:NO];
    [fadeOutAnimation setFillMode:kCAFillModeForwards];
    [fadeOutAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    [self.layer addAnimation:fadeOutAnimation forKey:@"fadeOut"];
    
    [CATransaction commit];
}

#pragma mark - --------------------接口API--------------------
#pragma mark 强制消失
- (void)forceHide
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOutAnimation) object:nil];
    
    [self removeFromSuperview];
    [_maskView removeFromSuperview], _maskView = nil;
}
#pragma mark Toast样式提示自定义内容
+ (void)showTipText:(NSString *)text inView:(UIView *)view
{
    //    CTToastTipView *toastTipView = [[CTToastTipView alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    //    CGSize textSize =  [text boundingRectWithSize:CGSizeMake(250-30, 320) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kCTToastTipViewTextFont} context:nil].size;
    //
    //    if (textSize.height > 20) {
    //        int viewHeight = 15 + textSize.height + 15;
    //        CGRect toastFrame = toastTipView.frame;
    //        toastFrame.size.height = viewHeight;
    //        toastTipView.frame = toastFrame;
    //    }
    //
    //    toastTipView.tipText = text;
    //    [toastTipView showInView:view];
    [FTToastWidget showTipText:text inView:view withWidth:250];
}

+ (void)showTipText:(NSString *)text inView:(UIView *)view withWidth:(CGFloat)width
{
    FTToastWidget *toastTipView = [[FTToastWidget alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    CGSize textSize =  [text boundingRectWithSize:CGSizeMake(250-30, 320) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kCTToastTipViewTextFont} context:nil].size;
    
    if (textSize.height > 20) {
        int viewHeight = 15 + textSize.height + 15;
        CGRect toastFrame = toastTipView.frame;
        toastFrame.size.height = viewHeight;
        toastTipView.frame = toastFrame;
    }
    
    toastTipView.tipText = text;
    [toastTipView showInView:view];
    
}

#pragma mark Toast样式提示自定义内容
+ (void)showTipText:(NSString *)text inView:(UIView *)view WithDisplayTime:(NSTimeInterval)iSecond
{
    FTToastWidget *toastTipView = [[FTToastWidget alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    CGSize textSize =  [text boundingRectWithSize:CGSizeMake(250-30, 320) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kCTToastTipViewTextFont} context:nil].size;
    
    if (textSize.height > 20) {
        int viewHeight = 15 + textSize.height + 15;
        CGRect toastFrame = toastTipView.frame;
        toastFrame.size.height = viewHeight;
        toastTipView.frame = toastFrame;
    }
    
    toastTipView.tipText = text;
    [toastTipView showInView:view WithDisplayTime:iSecond];
    
}

#pragma mark Toast样式在Window上提示自定义内容
+ (void)showTipText:(NSString *)text
{
    [FTToastWidget showTipText:text inView:[[[UIApplication sharedApplication] delegate] window]];
}

+ (void)showTipText:(NSString *)text withWidth:(CGFloat)width
{
    [FTToastWidget showTipText:text inView:[[[UIApplication sharedApplication] delegate] window] withWidth:width];
}

+ (void)showTipText:(NSString *)text WithDisplayTime:(NSTimeInterval)iSecond{
    [FTToastWidget showTipText:text inView:[[[UIApplication sharedApplication] delegate] window] WithDisplayTime:iSecond];
}

+ (void)showTipTextInRandomLocation:(NSString *)text
{
    FTToastWidget *toastTipView = [[FTToastWidget alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(250-30, 320) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kCTToastTipViewTextFont} context:nil].size;
    
    if (textSize.height > 20) {
        int viewHeight = 15 + textSize.height + 15;
        CGRect toastFrame = toastTipView.frame;
        toastFrame.size.height = viewHeight;
        toastTipView.frame = toastFrame;
    }
    
    toastTipView.tipText = text;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    static NSUInteger lastIndex = 0;
    ++lastIndex;
    lastIndex = (lastIndex) % 8;
    [toastTipView setCenter:CGPointMake(window.bounds.size.width/2.0, 100+lastIndex*50)];
    toastTipView.layer.opacity = 0.0;
    [window addSubview:toastTipView];
    
    [toastTipView fadeInAnimationAfterDelay:4];
}


+ (void)showTipText:(NSString *)text height:(CGFloat)height cornerRadius:(CGFloat)cornerRadius color:(UIColor*)color inView:(UIView*)view{
    UIFont *font = [UIFont systemFontOfSize:11];
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(250-30, 320) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    FTToastWidget *toastTipView = [[FTToastWidget alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 30,textSize.height+8)];
    toastTipView.tipText = text;
    
    toastTipView.tipLabelView.font = font;
    
    [toastTipView setCenter:CGPointMake(view.bounds.size.width/2.0, height)];
    toastTipView.layer.opacity = 0.0;
    [view addSubview:toastTipView];
    toastTipView.layer.cornerRadius = cornerRadius;
    toastTipView.layer.masksToBounds = YES;
    [toastTipView setBackgroundColor:color];
    
    [toastTipView fadeInAnimationAfterDelay:1];
}

@end
