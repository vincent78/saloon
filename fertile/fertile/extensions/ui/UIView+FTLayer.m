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

    [self clearLayerWithName:@"cornerBorderLayer333"];
    CAShapeLayer * cornerBorderLayer = [[CAShapeLayer alloc]init];
    //不透明
    cornerBorderLayer.opaque = YES;
    cornerBorderLayer.name = @"cornerBorderLayer333";
//    CGFloat onePixe = [FTSystemHelper onePixeWidth];
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderWidth, borderWidth, self.ftWidth-2*borderWidth, self.ftHeight-2*borderWidth)
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

-(void) clearLayerWithName:(NSString *)name
{
    NSArray *subLayers = self.layer.sublayers;
    if (subLayers && [subLayers count]) {
        for (int i = 0; i< [subLayers count]; i++) {
            CALayer *subLayer = [subLayers objectAtIndexForFT:i];
            if (subLayer && [subLayer.name length] && [subLayer.name isEqualToString:name]) {
                [subLayer removeFromSuperlayer];
            }
        }
    }
}

@end
