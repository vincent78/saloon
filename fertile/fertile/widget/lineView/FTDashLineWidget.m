//
//  FTDashLineWidget.m
//  fertile_oc
//
//  Created by vincent on 15/12/17.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTDashLineWidget.h"

@implementation FTDashLineWidget

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initData];
    [self initView];
}



- (void)initData
{
    self.lineWidth = [FTSystemHelper onePixeWidth];
    self.lengths = @[@"5",@"5"];
    
}

- (void)initView
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    NSInteger count = self.lengths.count;
    CGFloat lengthsTmp[count];
    for(NSInteger i = 0; i < count; i++)
    {
        NSString *length = [self.lengths objectAtIndex:i];
        lengthsTmp[i] = length.intValue;
    }
    CGContextSetLineDash(context, 0, lengthsTmp,count);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.frame.size.width,0);
    CGContextStrokePath(context);
}

//使用默认的颜色和lenghts显示
- (void)setDefaultDisply
{
    self.lengths = @[@"2",@"2"];
    self.strokeColor = [UIColor colorWithHexString:@"BBBBBB"];
    [self setNeedsDisplay];
}


@end
