//
//  FTNumStepperWidget.h
//  fertile
//
//  Created by vincent on 2017/2/9.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTNumStepperWidget : UIView

@property (nonatomic,strong) UIButton *leftBtn;

@property (nonatomic,strong) UIButton *rightBtn;

@property (nonatomic,copy) void (^leftBtnClicked)(void);

@property (nonatomic,copy) void (^rightBtnClicked)(void);

@property (nonatomic,copy) void (^numChanged)(int);

-(id) initWithFrame:(CGRect)frame withMinNum:(int) min withMaxNum:(int) max
        withCurrNum:(int)curr numChanged:(void (^)(int))numChange;

@end
