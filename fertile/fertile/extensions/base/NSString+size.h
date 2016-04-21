//
//  NSString+calSize.h
//  fertile
//
//  计算字符串的SIZE
//  Created by vincent on 15/10/12.
//  Copyright © 2015年 fruit. All rights reserved.
//



@interface NSString (size)


/**
 *  @brief  计算字符串的长和宽
 *
 *  @param font 指定的字体
 *
 *  @return 字符串的长和宽
 */
-(CGSize) ftSizeWithFont:(UIFont *)font;

/**
 *  @brief  计算字符串的长和宽
 *
 *  @param font          指定的字体
 *  @param containerSize 长和宽的约束
 *
 *  @return <#return value description#>
 */
-(CGSize) ftSizeWithFont:(UIFont *)font
              withSize:(CGSize) containerSize;

/**
 *  @brief 计算字符串的长和宽
 *
 *  @param font          <#font description#>
 *  @param containerSize <#containerSize description#>
 *  @param lineSpace     <#lineSpace description#>
 *
 *  @return <#return value description#>
 */
-(CGSize) ftSizeWithFont:(UIFont *)font
                wihtSize:(CGSize)containerSize
           withLineSpace:(CGFloat)lineSpace;

/**
 *  @brief  计算字符串的长和宽
 *
 *  @param font           指定的字体
 *  @param paragraphStyle 指定的段落信息
 *  @param options        指定的模式 （NSStringDrawingOptions）
 *  @param containerSize  长和宽的约束
 *
 *  @return 字符串的长和宽
 */
-(CGSize) ftSizeWithFont:(UIFont *)font
    withParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle
           withOptions:(int)options
              withSize:(CGSize) containerSize;

/**
 *  @brief  字符串的长度
 *
 *  @return 字节数（汉字为双字节）
 */
-(NSInteger) byteLength;

@end
