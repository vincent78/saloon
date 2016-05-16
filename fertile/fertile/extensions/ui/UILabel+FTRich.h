//
//  UILabel+rich.h
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FTRich)

/**
 *  @brief 按HTML的格式显示富文本
 *
 *  @param htmlStr <#htmlStr description#>
 */
-(void) setHtml:(NSString *)htmlStr;

@end
