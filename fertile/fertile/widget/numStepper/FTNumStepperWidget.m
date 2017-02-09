//
//  FTNumStepperWidget.m
//  fertile
//
//  Created by vincent on 2017/2/9.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import "FTNumStepperWidget.h"
#import "masonry.h"

@interface FTNumStepperWidget()
{
    int minNum;
    int maxNum;
    int currNum;
    UILabel *numLabel;
}

@end

@implementation FTNumStepperWidget

-(id) initWithFrame:(CGRect)frame withMinNum:(int) min withMaxNum:(int) max
        withCurrNum:(int)curr numChanged:(void (^)(int))numChange
{
    minNum = min;
    maxNum = max;
    currNum = curr;
    //数据进行校验
    currNum = MIN(currNum,maxNum);
    currNum = MAX(currNum, minNum);
    self.numChanged = numChange;
    return [self initWithFrame:frame];
}

-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self genLeftButton];
        [self genRightButton];
        [self genMidLabel];
        self.layer.borderWidth = [FTSystemHelper onePixeWidth];
        self.layer.borderColor = [UIColor colorWithHexString:@"0x565656"].CGColor;
        self.layer.cornerRadius = 4.0f;
        self.userInteractionEnabled = YES;
        [self numChange];
    }
    return self;
}



-(void) genLeftButton
{
    self.leftBtn = [[UIButton alloc] init];
    [self addSubview:self.leftBtn];
    WS(weakSelf)
    
    [self.leftBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.height.equalTo(weakSelf.mas_height);
        make.width.equalTo(weakSelf.mas_height).multipliedBy(1.2);
    }];
    [self.leftBtn setTitle:@"-" forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor colorWithHexString:@"0xE4E4E4"] forState:UIControlStateDisabled];
    [self.leftBtn addTarget:self action:@selector(numDown) forControlEvents:UIControlEventTouchUpInside];
    
    if (currNum <= minNum)
    {
        self.leftBtn.enabled = NO;
    }
    else
    {
        self.leftBtn.enabled = YES;
    }
}


-(void) genRightButton
{
    self.rightBtn = [[UIButton alloc] init];
    [self addSubview:self.rightBtn];
    WS(weakSelf)
    [self.rightBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.height.equalTo(weakSelf.mas_height);
        make.width.equalTo(weakSelf.mas_height).multipliedBy(1.2);
    }];
    [self.rightBtn setTitle:@"+" forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor colorWithHexString:@"0xE4E4E4"] forState:UIControlStateDisabled];
    [self.rightBtn addTarget:self action:@selector(numUp) forControlEvents:UIControlEventTouchUpInside];
    
    if (currNum >= maxNum)
    {
        self.rightBtn.enabled = NO;
    }
    else
    {
        self.rightBtn.enabled = YES;
    }
}

-(void) genMidLabel
{
    
    numLabel = [[UILabel alloc] init];
    numLabel.text = [NSString stringWithFormat:@"%i人",currNum];
    numLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:numLabel];
    WS(weakSelf)
    [numLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right);
        make.right.equalTo(self.rightBtn.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = [UIColor colorWithHexString:@"0x565656"];
    [self addSubview:leftLine];
    [leftLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabel.mas_left);
        make.top.equalTo(numLabel.mas_top);
        make.height.equalTo(numLabel.mas_height);
        make.width.equalTo(@([FTSystemHelper onePixeWidth]));
    }];
    
    
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = [UIColor colorWithHexString:@"0x565656"];
    [self addSubview:rightLine];
    [rightLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabel.mas_right);
        make.top.equalTo(numLabel.mas_top);
        make.height.equalTo(numLabel.mas_height);
        make.width.equalTo(@([FTSystemHelper onePixeWidth]));
    }];
}

-(void)numUp
{
    currNum++;
    currNum = MIN(currNum,maxNum);
    numLabel.text = [NSString stringWithFormat:@"%i人",currNum];
    
    if (currNum >= maxNum)
    {
        self.rightBtn.enabled = NO;
    }
    else if (maxNum > currNum)
    {
        self.rightBtn.enabled = YES;
    }
    
    if (currNum > minNum)
    {
        self.leftBtn.enabled = YES;
    }
    
    if (self.rightBtnClicked)
    {
        self.rightBtnClicked();
    }
    
    [self numChange];
}

-(void)numDown
{
    currNum--;
    currNum = MAX(currNum,minNum);
    numLabel.text = [NSString stringWithFormat:@"%i人",currNum];
    
    if (currNum <= minNum)
    {
        self.leftBtn.enabled = NO;
    }
    else
    {
        self.leftBtn.enabled = YES;
    }
    
    if (currNum < maxNum)
    {
        self.rightBtn.enabled = YES;
    }
    
    if (self.leftBtnClicked)
    {
        self.leftBtnClicked();
    }
    
    [self numChange];
}

-(void) numChange
{
    if (self.numChanged)
    {
        self.numChanged(currNum);
    }
}

@end
