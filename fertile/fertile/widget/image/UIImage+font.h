//
//  UIImage+font.h
//  fertile
//
//  Created by vincent on 16/1/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (font)

/**
 *  @brief 加载字体文件
 *
 *  @param fontFilePath <#fontFilePath description#>
 */
+(void) registFont:(NSString *)fontFilePath;



-(void) initWithText:(NSString *)text;

-(void) initWithText:(NSString *)text withFont:(NSString *)font;

@end
