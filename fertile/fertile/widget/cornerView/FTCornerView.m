//
//  FTCornerView.m
//  fertile_oc
//
//  Created by vincent on 15/12/8.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTCornerView.h"

@implementation FTCornerView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initData];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                    fillColor:(UIColor *)fillColor
                   cornerType:(FTCornerType)cornerType
                       radius:(CGFloat)radius
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.cornerType = cornerType;
        self.fillColor = fillColor;
        self.radius = radius;
    }
    return self ;
}

- (void)initData
{
//    self.cornerType = FTCornerTypeTopLeft | FTCornerTypeTopRight | FTCornerTypeDownLeft | FTCornerTypeDownRight ;
    self.cornerType = FTCornerTypeAll;
    self.radius = 4;
    self.fillColor = [UIColor whiteColor];
}


- (void)drawRect:(CGRect)rect
{
//    if (!self.needHideLine)
//    {
//        self.topLineColor = self.fillColor;
//        self.bottomLineColor = self.fillColor;
//    }
//    
//    CGFloat width = rect.size.width;
//    CGFloat height = rect.size.height;
//    if(self.needBottomArrow)
//    {
//        height -= 7;
//    }
//    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
//    CGFloat arrowWidth = 5;
//    //    self.radius = 4;
//    
//    // 获取CGContext，注意UIKit里用的是一个专门的函数
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    if(self.circleAngleType == CTFlightCircleAngleViewTopType)
//    {
//        CGContextBeginPath(context);
//        CGContextMoveToPoint(context,0, self.radius);
//        CGContextAddArc(context,self.radius, self.radius, self.radius, M_PI, 1.5 * M_PI, 0);
//        
//        CGContextAddLineToPoint(context, width - self.radius, 0);
//        
//        CGContextAddArc(context,width - self.radius, self.radius, self.radius, -0.5 * M_PI, 0.0, 0);
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.topLineColor.CGColor);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//        CGContextMoveToPoint(context,width, self.radius);
//        CGFloat lengths[] = {10.0,10.0};
//        CGContextSetLineDash(context, 0,lengths ,2);
//        CGContextAddLineToPoint(context, width, height);
//        
//        if(self.needBottomArrow)
//        {
//            CGContextAddLineToPoint(context,(width + arrowWidth)/2.0,height);
//            CGContextAddLineToPoint(context,(width)/2.0,rect.size.height -2);
//            CGContextAddLineToPoint(context,(width - arrowWidth)/2.0,height);
//            
//        }
//        CGContextAddLineToPoint(context, 0, height);
//        CGContextAddLineToPoint(context, 0, self.radius);
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//        // 闭合路径
//        CGContextClosePath(context);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//    }
//    else if (self.circleAngleType == CTFlightCircleAngleViewBottomType)
//    {
//        CGContextBeginPath(context);
//        CGContextMoveToPoint(context,width, height - self.radius);
//        CGContextAddArc(context,width - self.radius,height - self.radius, self.radius, 0, 0.5 * M_PI, 0);
//        
//        if(self.needBottomArrow)
//        {
//            CGContextAddLineToPoint(context,(width + arrowWidth)/2.0,height);
//            CGContextAddLineToPoint(context,(width)/2.0,rect.size.height -2);
//            CGContextAddLineToPoint(context,(width - arrowWidth)/2.0,height);
//            
//        }
//        CGContextAddLineToPoint(context,self.radius, height);
//        
//        CGContextAddArc(context, self.radius, height - self.radius, self.radius, 0.5 * M_PI, M_PI, 0);
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//        
//        CGContextMoveToPoint(context,0,height - self.radius);
//        CGContextAddLineToPoint(context, 0, 0);
//        CGContextAddLineToPoint(context, width, 0);
//        CGContextAddLineToPoint(context, width, height - self.radius);
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//        
//        // 闭合路径
//        CGContextClosePath(context);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//    }
//    else if (self.circleAngleType == CTFlightCircleAngleViewLeftType)
//    {
//        CGContextBeginPath(context);
//        CGContextAddLineToPoint(context,self.radius, height);
//        
//        CGContextAddArc(context, self.radius, height - self.radius, self.radius, 0.5 * M_PI, M_PI, 0);
//        
//        
//        CGContextAddLineToPoint(context,0, self.radius);
//        CGContextAddArc(context,self.radius, self.radius, self.radius, M_PI, 1.5 * M_PI, 0);
//        
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//        CGContextMoveToPoint(context,self.radius,0);
//        CGContextAddLineToPoint(context, width, 0);
//        CGContextAddLineToPoint(context, width, height);
//        if(self.needBottomArrow)
//        {
//            CGContextAddLineToPoint(context,(width + arrowWidth)/2.0,height);
//            CGContextAddLineToPoint(context,(width)/2.0,rect.size.height - 2);
//            CGContextAddLineToPoint(context,(width - arrowWidth)/2.0,height);
//            
//        }
//        CGContextAddLineToPoint(context, self.radius, height);
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//        
//        // 闭合路径
//        CGContextClosePath(context);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//    }
//    else if (self.circleAngleType == CTFlightCircleAngleViewRightType)
//    {
//        CGContextBeginPath(context);
//        CGContextAddLineToPoint(context, width - self.radius, 0);
//        
//        CGContextAddArc(context,width - self.radius, self.radius, self.radius, -0.5 * M_PI, 0.0, 0);
//        
//        CGContextAddLineToPoint(context,width, height - self.radius);
//        CGContextAddArc(context,width - self.radius,height - self.radius, self.radius, 0, 0.5 * M_PI, 0);
//        
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//        CGContextMoveToPoint(context,width - self.radius,height);
//        if(self.needBottomArrow)
//        {
//            CGContextAddLineToPoint(context,(width + arrowWidth)/2.0,height);
//            CGContextAddLineToPoint(context,(width)/2.0,rect.size.height -2);
//            CGContextAddLineToPoint(context,(width - arrowWidth)/2.0,height);
//            
//        }
//        
//        CGContextAddLineToPoint(context, 0, height);
//        CGContextAddLineToPoint(context, 0, 0);
//        CGContextAddLineToPoint(context, width - self.radius, 0);
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//        
//        // 闭合路径
//        CGContextClosePath(context);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//    }
//    else if (self.circleAngleType == CTFlightCircleAngleViewAllType)
//    {
//    CGContextBeginPath(context);
//    CGContextSetLineWidth(context, CTOnePixelLineHeight);
//    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//    CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//    if (self.isDashLine)
//    {
//        CGFloat lengths[] = {1.0,1.0};
//        CGContextSetLineDash(context, 0,lengths ,2);
//    }
//    CGContextMoveToPoint(context,0, self.radious);
//    CGContextAddArc(context,self.radious, self.radious, self.radious, M_PI, 1.5 * M_PI, 0);
//    
//    CGContextAddLineToPoint(context, width - self.radious, 0);
//    
//    CGContextAddArc(context,width - self.radious, self.radious, self.radious, -0.5 * M_PI, 0.0, 0);
//    
//    CGContextAddLineToPoint(context, width, height - self.radious);
//    CGContextAddArc(context, width - self.radious, height - self.radious, self.radious, 0, 0.5 * M_PI, 0);
//    
//    CGContextAddLineToPoint(context, self.radious, height);
//    CGContextAddArc(context, self.radious, height - self.radious, self.radious, 0.5 * M_PI,1* M_PI, 0);
//    
//    CGContextAddLineToPoint(context, 0, self.radious);
//    
//    // 闭合路径
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
//    }
//    else if (self.circleAngleType == CTFlightCircleAngleViewNoneType)
//    {
//        CGContextBeginPath(context);
//        CGContextMoveToPoint(context,0, 0);
//        
//        
//        CGContextAddLineToPoint(context,width, 0);
//        
//        CGContextAddLineToPoint(context, width, height);
//        if(self.needBottomArrow)
//        {
//            CGContextAddLineToPoint(context,(width + arrowWidth)/2.0,height);
//            CGContextAddLineToPoint(context,(width)/2.0,rect.size.height -2);
//            CGContextAddLineToPoint(context,(width - arrowWidth)/2.0,height);
//            
//        }
//        
//        CGContextAddLineToPoint(context, 0, height);
//        CGContextAddLineToPoint(context, 0, 0);
//        CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
//        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
//        // 闭合路径
//        CGContextClosePath(context);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        
//    }
    
}

@end
