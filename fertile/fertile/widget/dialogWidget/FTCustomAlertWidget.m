//
//  FTCustomAlertWidget.m
//  fertile
//
//  Created by vincent on 2017/7/12.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import "FTCustomAlertWidget.h"

const static CGFloat kAlertViewCornerRadius              = 6;   // 圆角半径
CGFloat controlButtonHeight = 50;
#define D_H_Pading_Width  40//水平间隔

@interface FTCustomAlertWidget ()

@property (nonatomic, strong) UILabel *titleView; // 标题View
@property (nonatomic, copy)    NSAttributedString *title;    // 标题
@property (nonatomic, strong) UIView *dialogView;            // 外层dialog视图
@property (nonatomic, strong) UIView *containerView;         // 自定义的布局（子视图）
@property (nonatomic, copy) OnButtonClickHandle onButtonClickHandle; // 按钮点击事件
@property (nonatomic, assign) CGFloat contentViewMaxWidth;
@property (nonatomic, assign) CGFloat messageLabelMaxWidth;
@property (nonatomic, assign) CGFloat kAlertViewDefaultTitleWidth;
@property (nonatomic, assign) CGFloat kAlertViewDefaultTitleHeight;//标题View高度
@property (nonatomic, strong) NSMutableArray *buttonTitles;         // 按钮标题数组

@end

@implementation FTCustomAlertWidget

- (instancetype)initWithAttrTitle:(NSAttributedString *)title
                          message:(NSAttributedString *)attrMessage
                      cancelTitle:(NSAttributedString *)cancelTitle
                     confirmTitle:(NSAttributedString *)confirmTitle
{
    if(self = [super init])
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.buttonTitles = [NSMutableArray array];
        _title = title;
        _contentViewMaxWidth = [FTSystemHelper screenWidth] - D_H_Pading_Width*2;
        _messageLabelMaxWidth = _contentViewMaxWidth - D_H_Pading_Width;
        _kAlertViewDefaultTitleWidth = _messageLabelMaxWidth;
        [self addContentViewWithAttrMessage:attrMessage];
        [self.buttonTitles addObjectForFT:cancelTitle];
        [self.buttonTitles addObjectForFT:confirmTitle];
        
    }
    return self;
}

// 设置子布局
- (void)addContentViewWithAttrMessage:(NSAttributedString *)attrMessage
{
    CGSize messageSize = [attrMessage boundingRectWithSize:CGSizeMake(_messageLabelMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil].size;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentViewMaxWidth, messageSize.height+20)];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(D_H_Pading_Width/2.0, 0, _messageLabelMaxWidth, messageSize.height)];
    aLabel.attributedText = attrMessage;
    aLabel.numberOfLines = 0;
    aLabel.backgroundColor = [UIColor clearColor];
    [containerView addSubview:aLabel];
    _containerView = containerView;
}




// 创建并显示提示AlertView
- (void)show
{
    // 创建提示视图
    _dialogView = [self createContainerView];
    
    // layer光栅化，提高性能
    _dialogView.layer.shouldRasterize = YES;
    _dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:_dialogView];
    
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
    _dialogView.frame = CGRectMake(D_H_Pading_Width, (screenSize.height  - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    _dialogView.layer.opacity = 0.5f;
    _dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0); // 由大变小的动画
    
    [UIView animateWithDuration:0.15f delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
                         _dialogView.layer.opacity = 1.0f;
                         _dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:nil
     ];
    
}

// 创建提示视图
- (UIView *)createContainerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentViewMaxWidth, 150)];
    }
    
    CGFloat titleTop = 20;
    // 如果有标题则containerView的y坐标往下移
    if (_title.string.length > 0) {
        _kAlertViewDefaultTitleHeight = [_title boundingRectWithSize:CGSizeMake(_messageLabelMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height+titleTop;
    }else{
        _kAlertViewDefaultTitleHeight = 10;
    }
    
    
    CGRect containerViewFrame = _containerView.frame;
    containerViewFrame.origin.y += _kAlertViewDefaultTitleHeight+10;
    containerViewFrame.size.height += _kAlertViewDefaultTitleHeight+10;
    _containerView.frame = containerViewFrame;
    
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countDialogSize];
    
    [self setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    // 提示视图
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake(D_H_Pading_Width, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = dialogContainer.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithHexString:@"0xFFFFFF"].CGColor,
                       (id)[UIColor colorWithHexString:@"0xFFFFFF"].CGColor,
                       (id)[UIColor colorWithHexString:@"0xFFFFFF"].CGColor,
                       nil];
    
    CGFloat cornerRadius = kAlertViewCornerRadius;
    gradient.cornerRadius = cornerRadius;
    [dialogContainer.layer insertSublayer:gradient atIndex:0];
    
    dialogContainer.layer.cornerRadius = cornerRadius;
    dialogContainer.layer.shadowRadius = cornerRadius + 5;
    dialogContainer.layer.shadowOpacity = 0.1f;
    dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius + 5) / 2, 0 - (cornerRadius + 5) / 2);
    dialogContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
    // 分隔线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, dialogContainer.bounds.size.height - controlButtonHeight - [FTSystemHelper onePixeWidth], dialogContainer.bounds.size.width, [FTSystemHelper onePixeWidth])];
    lineView.backgroundColor = [UIColor colorWithHexString:@"0xDBDBDB"];
    [dialogContainer addSubview:lineView];
    
    // 添加标题View
    if (_title.string.length > 0) {
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(D_H_Pading_Width/2.0f, titleTop, _kAlertViewDefaultTitleWidth, _kAlertViewDefaultTitleHeight-titleTop)];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.attributedText = _title;
        [dialogContainer addSubview:_titleView];
    }
    
    // 添加子布局
    [dialogContainer addSubview:_containerView];
    // 添加按钮
    [self addButtonsToView:dialogContainer];
    
    return dialogContainer;
}

// 添加按钮
- (void)addButtonsToView: (UIView *)container
{
    if (!_buttonTitles) {
        return;
    }
    NSInteger buttonCount = [_buttonTitles count];
    CGFloat buttonWidth = container.bounds.size.width / buttonCount;
    
    for (int i = 0; i < buttonCount; i++) {
        
        UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tapButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - controlButtonHeight, buttonWidth, controlButtonHeight)];
        [tapButton addTarget:self action:@selector(buttonClickHandle:) forControlEvents:UIControlEventTouchUpInside];
        [tapButton setTag:i];
        
        tapButton.titleLabel.numberOfLines = 2;
        NSMutableAttributedString *aString = [_buttonTitles objectAtIndex:i];
        [tapButton setAttributedTitle:aString forState:UIControlStateNormal];
        [tapButton.layer setCornerRadius:kAlertViewCornerRadius];
        
        [container addSubview:tapButton];
        if (i > 0)
        {
            // 按钮分隔线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - controlButtonHeight, [FTSystemHelper onePixeWidth], controlButtonHeight)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"0xDBDBDB"];
            [container addSubview:lineView];
        }
    }
}

// 按钮点击
- (void)buttonClickHandle:(id)sender
{
    if (_onButtonClickHandle) {
        _onButtonClickHandle(self, [sender tag]);
    }
}

- (void)setOnClickListerner:(OnButtonClickHandle)onButtonClickHandle
{
    _onButtonClickHandle = onButtonClickHandle;
}

// 关闭AlertView并移除
- (void)dismiss
{
    CATransform3D currentTransform = _dialogView.layer.transform;
    _dialogView.layer.opacity = 1.0f;
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         _dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         _dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

// 得到提示视图的size
- (CGSize)countDialogSize
{
    CGFloat dialogWidth = _containerView.frame.size.width;
    CGFloat dialogHeight = _containerView.frame.size.height + controlButtonHeight + [FTSystemHelper onePixeWidth];
    return CGSizeMake(dialogWidth, dialogHeight);
}

// 得到屏幕的size
- (CGSize)countScreenSize
{
    if (_buttonTitles && [_buttonTitles count] > 0) {
        controlButtonHeight = 50;
    } else {
        controlButtonHeight = 0;
    }
    return [[UIScreen mainScreen] bounds].size;
}

@end
