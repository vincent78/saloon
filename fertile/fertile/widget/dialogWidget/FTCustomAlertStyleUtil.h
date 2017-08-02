//
//  FTCustomAlertStyleUtil.h
//  fertile
//
//  Created by vincent on 2017/7/12.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTCustomAlertStyleUtil : NSObject

//纳税人识别号弹框-title样式
+ (NSMutableAttributedString *)taxStyle_attrTitleWithText:(NSString *)text;
//纳税人识别号弹框-message样式
+ (NSMutableAttributedString *)taxStyle_attrMessageWithText:(NSString *)text;
//纳税人识别号弹框-操作按钮样式
+ (NSMutableAttributedString *)taxStyle_buttonTitleWithText:(NSString *)text;


@end
