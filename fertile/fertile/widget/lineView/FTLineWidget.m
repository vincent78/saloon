//
//  FTLineWidget.m
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTLineWidget.h"

@implementation FTLineWidget

-(instancetype)initWithWidth:(CGFloat)width withColor:(UIColor *)color withPoint:(CGPoint)point
{
    CGRect rect = CGRectZero;
    rect.origin = point;
    rect.size = CGSizeMake(width, 1);
    self = [self initWithFrame:rect];
    if (self)
    {
        self.strokeColor = color;
    }
    return self;
}


-(instancetype)initWithHeight:(CGFloat)height withColor:(UIColor *)color withPoint:(CGPoint)point
{
    CGRect rect = CGRectZero;
    rect.origin = point;
    rect.size = CGSizeMake(1, height);
    self = [self initWithFrame:rect];
    if (self)
    {
        self.strokeColor = color;
    }
    return self;
}



-(instancetype)initWithFrame:(CGRect)frame withColor:(UIColor *)color
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.strokeColor = color;
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    CGContextMoveToPoint(context, 0, 0);
    if (rect.size.height >1)
    {
        CGContextSetLineWidth(context, rect.size.width == 0 ? 1 :rect.size.width);
        CGContextAddLineToPoint(context, 0, rect.size.height);
    }
    else
    {
        CGContextSetLineWidth(context, rect.size.height == 0 ? 1 :rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, 0);
    }
    CGContextStrokePath(context);
    
}

@end
