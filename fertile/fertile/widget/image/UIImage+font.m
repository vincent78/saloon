//
//  UIImage+font.m
//  fertile
//
//  Created by vincent on 16/1/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "UIImage+font.h"

@implementation UIImage (font)

-(instancetype) initWithText:(NSString *)text
            withFont:(NSString *)font
           withFrame:(CGRect) frame
           withColor:(UIColor *)color
{
    FTBaseVectorView *tmpView = [[FTBaseVectorView alloc] initWithFrame:frame
                                                         fontFamilyName:font
                                                               fontName:text
                                                              fontColor:color];
    self = tmpView.toImage;
//    tmpView = nil;
    return self;
}


@end
