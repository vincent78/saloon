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
            withFont:(NSString *)font
           withFrame:(CGRect) frame
           withColor:(UIColor *)color;

@end
