//
//  UIImage+font.h
//  fertile
//
//  Created by vincent on 16/1/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (font)

-(instancetype) initWithText:(NSString *)text
                    withFontFamilyName:(NSString *)fontFamilyName
                    withSize:(CGSize) size
                   withColor:(UIColor *)color;

@end
