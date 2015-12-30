//
//  FT3DLineWidget.m
//  fertile_oc
//
//  Created by vincent on 15/11/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FT3DLineWidget.h"

@interface FT3DLineWidget()
{
    int type ;
}

@end

@implementation FT3DLineWidget


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(instancetype)initWithWidth:(CGFloat)width withColor:(UIColor *)color withPoint:(CGPoint)point
{
    
    CGRect rect = CGRectZero;
    rect.origin = point;
    rect.size = CGSizeMake(width, [FTSystemHelper onePixeWidth] * 2);
    self = [self initWithFrame:rect];
    if (self)
    {
        type = 1;
        self.strokeColor = color;
    }
    return self;
}

-(instancetype)initWithHeight:(CGFloat)height withColor:(UIColor *)color withPoint:(CGPoint)point
{
    CGRect rect = CGRectZero;
    rect.origin = point;
    rect.size = CGSizeMake([FTSystemHelper onePixeWidth] * 2, height);
    self = [self initWithFrame:rect];
    if (self)
    {
        type = 2;
        self.strokeColor = color;
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (type == 1)
    {
        CGPoint newPoint = rect.origin;
        [self drawSinglePixesLine:rect.size.width atPoint:newPoint withColor:self.strokeColor];
        newPoint.y = rect.origin.y + [FTSystemHelper onePixeWidth];
        [self drawSinglePixesLine:rect.size.width atPoint:newPoint withColor:[UIColor whiteColor]];
        
    }
    else
    {
        CGPoint newPoint = rect.origin;
        [self drawSinglePixesLine:rect.size.height atPoint:newPoint withColor:self.strokeColor];
        newPoint.y = rect.origin.x + [FTSystemHelper onePixeWidth];
        [self drawSinglePixesLine:rect.size.height atPoint:newPoint withColor:[UIColor whiteColor]];
    }
    
}


/**
 *  @brief  画一条单像素的线
 
 *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
 * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整

 *
 *  @param beginPoint <#beginPoint description#>
 *  @param endPoint   <#endPoint description#>
 */
-(void)drawSinglePixesLine:(CGFloat)length  atPoint:(CGPoint)point withColor:(UIColor *)color
{
    CGFloat lineWidth = [FTSystemHelper onePixeWidth];
    CGFloat pixelAdjustOffset = 0;
    if (((int)( lineWidth* [UIScreen mainScreen].scale) + 1) % 2 == 0) {
        pixelAdjustOffset = [FTSystemHelper singleLineAdjustOffset];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGFloat xPos = point.x ;//+ pixelAdjustOffset;
    CGFloat yPos = point.y + pixelAdjustOffset;
    CGContextMoveToPoint(context, xPos, yPos);
    if (type == 1)  //横线
        CGContextAddLineToPoint(context, xPos + length, yPos);
    else            //竖线
        CGContextAddLineToPoint(context, xPos, yPos + length);
        
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextStrokePath(context);

}


/*
 UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:imageView.bounds];
 
 imageView.layer.masksToBounds = NO;
 
 imageView.layer.shadowColor = [UIColor blackColor].CGColor;
 
 imageView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
 
 imageView.layer.shadowOpacity = 0.5f;
 
 imageView.layer.shadowPath = shadowPath.CGPath;
 
 
 
 CALayer *layer = lineImageView.layer;
 layer.borderColor = [UIColor redColor].CGColor;
 layer.borderWidth = (1.0 / [UIScreen mainScreen].scale / 2);
 
 
 */


/*
 折线
 
 
 
 - (void)initData
 {
 self.lineWidth = CTOnePixelLineHeight;
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
 NSString *length = [self.lengths objectAtIndexForCtrip:i];
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
 self.strokeColor = CTColorHex(0xbbbbbb);
 [self setNeedsDisplay];
 }
 
 
 
 
 
 */

@end
