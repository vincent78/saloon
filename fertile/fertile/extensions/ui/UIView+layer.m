//
//  UIView+layer.m
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "UIView+layer.h"

@implementation UIView (layer)


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
    
//    NSArray *subLayers = self.layer.sublayers;
//    if (subLayers && [subLayers count]) {
//        for (int i = 0; i< [subLayers count]; i++) {
//            CALayer *subLayer = [subLayers objectAtIndex:i];
//            if (subLayer && [subLayer.name length] && [subLayer.name isEqualToString:@"cornerborderlayer254"]) {
//                [subLayer removeFromSuperlayer];
//            }
//        }
//    }
    
    CAShapeLayer * cornerBorderLayer = [[CAShapeLayer alloc]init];
    //不透明
    cornerBorderLayer.opaque = YES;
    cornerBorderLayer.path = maskPath.CGPath;
    cornerBorderLayer.strokeColor = [borderColor CGColor];
    //    cornerBorderLayer.fillColor = [UIColor clearColor].CGColor;
    cornerBorderLayer.fillColor = [[UIColor whiteColor] CGColor];
    cornerBorderLayer.lineWidth = borderWidth;
    cornerBorderLayer.lineDashPattern =patterns;
//    cornerBorderLayer.name = @"cornerborderlayer254";
//    [self.layer insertSublayer:cornerBorderLayer atIndex:0];
    self.layer.mask = cornerBorderLayer;
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
