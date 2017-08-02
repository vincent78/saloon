//
//  FTCustomAlertWidget.h
//  fertile
//
//  Created by vincent on 2017/7/12.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTCustomAlertStyleUtil.h"

@class FTCustomAlertWidget;
typedef void (^OnButtonClickHandle)(FTCustomAlertWidget *alertView, NSInteger buttonIndex);


@interface FTCustomAlertWidget : UIView

- (instancetype)initWithAttrTitle:(NSAttributedString *)title
                          message:(NSAttributedString *)attrMessage
                      cancelTitle:(NSAttributedString *)cancelTitle
                     confirmTitle:(NSAttributedString *)confirmTitle;
- (void)setOnButtonClickHandle:(OnButtonClickHandle)onButtonClickHandle; // 设置按钮点击事件
- (void)show;    // 显示
- (void)dismiss; // 关闭

@end
