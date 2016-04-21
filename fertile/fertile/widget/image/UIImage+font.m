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
                    withFontFamilyName:(NSString *)fontFamilyName
                   withSize:(CGSize) size
                   withColor:(UIColor *)color
{
    return [[FTVectorView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)
                                                         fontFamilyName:fontFamilyName
                                                               fontName:text
                                                              fontColor:color].getImage;
}

@end
