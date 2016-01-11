//
//  FTNavigateWidget.m
//  fertile_oc
//
//  Created by vincent on 15/11/5.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTNavigateWidget.h"

@interface FTNavigateWidget () {
    NSString* _title;
    UILabel* _titleLabel;
    FTBaseVectorView *arrowView;
    
    
}

@end

@implementation FTNavigateWidget

#pragma widget circle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)widgetDidLoad
{
    //标题
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [FTAppHelper defaultBoldFont:18];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //背景
    self.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    //底部分隔线
    [self drawBottomLineView];
    //回退按钮
    [self genBackBtn];
    
}

- (void)widgetWillAppear
{
    _titleLabel.text = _title;
    
    if ([[FTRouteHelper sharedInstance] getCurrNav].viewControllers.count > 1 )
    {
        [self showBackArrow:YES];
    }
    else
    {
        [self showBackArrow:NO];
    }
    
    
}

- (void)widgetDidAppear
{
    [_titleLabel sizeToFit];
    [_titleLabel centerInParent];
}

-(void)widgetWillDisappear
{
    [self removeAllSubView];
}

-(void)dealloc
{
    arrowView = nil;
    _title = nil;
    _titleLabel = nil;
}

#pragma 外部可用的调用

- (void)setNavTitle:(NSString*)title
{
    _title = title;
    if (self.isAppear) {
        _titleLabel.text = _title;
        [_titleLabel sizeToFit];
        [_titleLabel centerInParent];
    }
}

- (void)setNavTitleLabel:(UILabel*)navTitleLabel
{
    _titleLabel = navTitleLabel;
    if (self.isAppear) {
        [_titleLabel centerInParent];
    }
}

- (void)reset
{
    [self removeAllSubView];
    //添加backArrow

    //添加leftBtns

    //添加rightBtns

    //添加title
}

- (FTImgBtn*)getBtnByKey:(NSString*)key
{

    for (int i = 0; i < self.rightBtns.count; i++) {
        FTImgBtn* btn = [self.rightBtns objectAtIndex:i];
        if ([btn.key isEqualToString:key]) {
            return btn;
        }
    }

    for (int i = 0; i < self.leftBtns.count; i++) {
        FTImgBtn* btn = [self.leftBtns objectAtIndex:i];
        if ([btn.key isEqualToString:key]) {
            return btn;
        }
    }

    return nil;
}

- (void)resetSelectedBtn:(NSString*)key, ...
{
    va_list arglist;
    va_start(arglist, key);
    id arg;
    while ((arg = va_arg(arglist, id))) {
        if (arg)
            NSLog(@"%@", arg);
    }
    va_end(arglist);
}

- (void)showBackArrow:(BOOL)show
{
    if (show && arrowView)
    {
        if (![self.subviews containsObject:arrowView])
            [self addSubview:arrowView];
    }
    else
    {
        [arrowView removeFromSuperview];
    }
}

#pragma mark - 内部私用

-(void) initView
{
    self.rightBtns = [NSMutableArray array];
    self.leftBtns = [NSMutableArray array];
    _title = @"";
    self.leftPadding = 20;
    self.rightPadding = 20;
}

-(void)drawBottomLineView
{
    [self addSubview:[[FT3DLineWidget alloc] initWithWidth:[FTSystemHelper screenWidth]
                                               withColor:[UIColor colorWithHexString:@"b2b2b2"]
                                               withPoint:CGPointMake(0, self.frame.size.height - [FTSystemHelper onePixeWidth])]];
}

-(void)genBackBtn
{
    if (!arrowView)
    {
        //生成回退的图片
        arrowView = [[FTBaseVectorView alloc] initWithFrame:CGRectMake(self.leftPadding, 0, 20, 20)
                                             fontFamilyName:@"common"
                                                   fontName:@"\U0000e616"];
        
        
    }
    [self addSubview:arrowView];
}

@end
