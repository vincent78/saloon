//
//  FTAlertWidget.h
//  fertile
//
//  Created by vincent on 16/4/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTAlertWidget : UIAlertView <UIAlertViewDelegate>
{
    
}
@property (copy, nonatomic) void	(^onCancelButtonClicked)(FTAlertWidget *alertView);
@property (copy, nonatomic) void	(^onOtherButtonClicked)(FTAlertWidget *alertView);

/** 显示提示信息，内容格式为：提示信息 + 内容 + 知道了
 *   @param message             内容体
 */
+ (void)showAlertWithMessage:(NSString *)message;

/***/
+ (void)showAlertWithMessage:(NSString *)message
                    delegate:(id)delegate
                 cancelTitle:(NSString *)cancelTitle
                confirmTitle:(NSString *)confirmTitle;

/** 显示提示信息，内容格式为：标题 + 内容 + 取消按钮
 *   @param title               标题
 *   @param message             内容体
 *   @param cancelButtonTitle   取消按钮
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (id)showStandardMessage:(NSString *)message
                 delegate:(id)delegate
        cancelButtonTitle:(NSString *)cancelButtonTitle
        otherButtonTitles:(NSString *)otherButtonTitles;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
     dismissAfterDelay:(NSTimeInterval)timeInterval;

/**
 *   网络未连接弹出框接口添加
 *   @return alertView对象
 */
+ (UIAlertView *)showAlertForNetworkNotAvailable;

/**
 *   网络未连接弹出框接口添加
 *
 *   @param delegate 代理
 *   @return alertView对象
 */
+ (UIAlertView *)showAlertForNetworkNotAvailableWithDelegate:(id)delegate;

/**
 *    使用block创建一个弹出框。如果某个按钮没有动作要求，请提供nil
 *    @param title 标题
 *    @param message	信息
 *    @param cancelButtonTitle 取消按钮标题
 *    @param cancalAction		取消按钮的动作
 *    @param otherButtonTitles 其他按钮标题
 *    @param otherAction 其他的按钮的动作
 *    @return 初始化好的弹出框
 */
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
		cancelButtonTitle:(NSString *)cancelButtonTitle
       cancelAction:(void (^)(FTAlertWidget *sender))cancalAction
		otherButtonTitles:(NSString *)otherButtonTitles
        otherAction:(void (^)(FTAlertWidget *sender))otherAction;


@end
