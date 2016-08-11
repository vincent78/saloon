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
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(raidus, raidus)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

    CAShapeLayer * cornerBorderLayer = [[CAShapeLayer alloc]init];
    //不透明
    cornerBorderLayer.opaque = YES;
    CGFloat onePixe = [FTSystemHelper onePixeWidth];
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(onePixe, onePixe, self.ftWidth-2*onePixe, self.ftHeight-2*onePixe)
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(raidus, raidus)];
    cornerBorderLayer.path = borderPath.CGPath;
    cornerBorderLayer.strokeColor = [borderColor CGColor];
    cornerBorderLayer.fillColor = [[UIColor clearColor] CGColor];
    cornerBorderLayer.lineWidth = borderWidth;
    cornerBorderLayer.lineDashPattern =patterns;
    [self.layer addSublayer:cornerBorderLayer];
    
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
