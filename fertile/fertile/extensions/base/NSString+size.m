//
//  NSString+calSize.m
//  fertile
//
//  Created by vincent on 15/10/12.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+size.h"

@implementation NSString (size)

-(CGSize) ftSizeWithFont:(UIFont *)font
{
    return [self ftSizeWithFont:font
           withParagraphStyle:nil
                  withOptions:NSStringDrawingTruncatesLastVisibleLine
                     withSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

-(CGSize) ftSizeWithFont:(UIFont *)font
              withSize:(CGSize) containerSize
{
    return [self ftSizeWithFont:font
           withParagraphStyle:nil
                  withOptions:NSStringDrawingTruncatesLastVisibleLine
                     withSize:containerSize];
}


-(CGSize) ftSizeWithFont:(UIFont *)font
    withParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle
           withOptions:(int)options
              withSize:(CGSize) containerSize
{
    //判断是否为多行
    if (containerSize.height >= font.pointSize + 2  && !(options & NSStringDrawingUsesLineFragmentOrigin  ))
    {
        options = options + NSStringDrawingUsesLineFragmentOrigin ;
    }
    
    NSDictionary *attributes;
    if (paragraphStyle)
        attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    else
        attributes = @{NSFontAttributeName:font};
    
    NSDictionary *attribute = @{ NSFontAttributeName: font
                                 ,NSParagraphStyleAttributeName:attributes};
    
    CGSize size = [self boundingRectWithSize:containerSize
                                       options:options
                                    attributes:attribute
                                       context:nil].size;
    
    return CGSizeMake(ceilf(size.width)+ 1, ceilf(size.height) + 1);
}



-(NSInteger) byteLength
{
    if (self.length==0) return 0 ;
    char *problem_char = (char *)[self cStringUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)] ;
    return strlen(problem_char) ;
}


@end
