//
//  UIColor+normal.m
//  fertile_oc
//
//  Created by vincent on 15/11/27.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "UIColor+FTNormal.h"

@implementation UIColor (FTNormal)

- (UIImage *)toImage
{
    return [self toImageWithRect:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f)];
}

- (UIImage *)toImageWithRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
//    透明度的设置
//    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    
    //删除字符串中的空格
    NSString *cString =
    [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([[cString uppercaseString] hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    // r
    NSString *rString = [cString substringWithRange:range];
    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:alpha];
}



//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}


+(UIColor *) change:(UIColor *)color withAlpha:(CGFloat)alpha
{
    return [color colorWithAlphaComponent:alpha];
}

@end