//
//  UIView+layer.m
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "UIView+FTLayer.h"

@implementation UIView (FTLayer)


- (void)viewCornerRaidusType:(CGFloat)raidus
             roundingCorners:(UIRectCorner)corners
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor
           borderDashPattern:(NSArray *)patterns
{
    //    NSLog(@"the layer bound %f  %f",self.layer.bounds.size.width,self.layer.bounds.size.height);
    //    NSLog(@"the view frame %f  %f | %f  %f",self.frame.origin.x,self.frame.origin.y, self.frame.size.width,self.frame.size.height);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(raidus, raidus)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, self.ftWidth, self.ftHeight);
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    CAShapeLayer * cornerBorderLayer = [[CAShapeLayer alloc]init];
    //不透明
    cornerBorderLayer.opaque = YES;
    cornerBorderLayer.path = maskPath.CGPath;
    cornerBorderLayer.strokeColor = [borderColor CGColor];
    cornerBorderLayer.fillColor = [[UIColor whiteColor] CGColor];
    cornerBorderLayer.lineWidth = borderWidth;
    cornerBorderLayer.lineDashPattern =patterns;
    self.layer.mask = cornerBorderLayer;
    
    
//    //添加圆角
//    CGRect coverFrame = CGRectMake(0, 0, CTScreenWidth - 16, 39);
//    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:coverFrame
//                                                     byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
//                                                           cornerRadii:CGSizeMake(5.0f, 5.0f)];
//    CAShapeLayer * topSingleLayer = [[CAShapeLayer alloc]init];
//    topSingleLayer.frame = coverFrame;
//    topSingleLayer.path = cornerPath.CGPath;
//    backgroudView.layer.mask = topSingleLayer;
}

-(void)viewCornerRaidusType:(CGFloat)raidus
                borderColor:(UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth
{
    [self.layer setCornerRadius:raidus];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setBorderColor:borderColor.CGColor];
}


-(void) appendGradientLayer:(CGRect)rect withColors:(NSArray *)colors
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = rect.origin;
    layer.endPoint = CGPointMake(CGRectGetMaxX(rect),CGRectGetMaxY(rect));
    layer.colors = colors;
    [self.layer addSublayer:layer];
}

@end
