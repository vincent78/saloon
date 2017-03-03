//
//  FTAlertWidget.m
//  fertile
//
//  Created by vincent on 16/4/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTAlertWidget.h"

@implementation FTAlertWidget

- (void)dealloc
{
    self.onOtherButtonClicked = nil;
    self.onCancelButtonClicked = nil;
    
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
		cancelButtonTitle:(NSString *)cancelButtonTitle
       cancelAction:(void (^)(FTAlertWidget *sender))cancalAction
		otherButtonTitles:(NSString *)otherButtonTitles
        otherAction:(void (^)(FTAlertWidget *sender))otherAction
{
    self = [self initWithTitle:@"" message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    if (self) {
        self.onCancelButtonClicked	= cancalAction;
        self.onOtherButtonClicked	= otherAction;
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super initWithTitle:@"" message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    if (message) {
//        [CTUserOperationCollector logTrace:@"o_alertview" withParams:@{@"content": message}];
    }
    return self;
}
/** 显示提示信息，内容格式为：提示信息 + 内容 + 知道了 */
+ (void)showAlertWithMessage:(NSString *)message
{
    [self showAlertWithTitle:@"" message:message cancelButtonTitle:@"知道了"];
}

+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle
{
    FTAlertWidget *alert = [[FTAlertWidget alloc] initWithTitle:@"" message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:confirmTitle, nil];
    
    [alert show];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    FTAlertWidget *alert = [[FTAlertWidget alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    [alert show];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    FTAlertWidget *alert = [[FTAlertWidget alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    [alert show];
}

+ (id)showStandardMessage:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    FTAlertWidget *alert = [[FTAlertWidget alloc] initWithTitle:@"" message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    [alert show];
    return alert;
}

+ (UIAlertView *)showAlertForNetworkNotAvailable
{
    return [self showAlertForNetworkNotAvailableWithDelegate:nil];
}

+ (UIAlertView *)showAlertForNetworkNotAvailableWithDelegate:(id)delegate
{
    FTAlertWidget *alertView = [[FTAlertWidget alloc] initWithTitle:@"网络连接已关闭" message:@"启用蜂窝移动数据或Wi-Fi来访问数据" delegate:delegate cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    alertView.tag = 400;
    [alertView show];
    return alertView;
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message dismissAfterDelay:(NSTimeInterval)timeInterval
{
    FTAlertWidget *alert = [[FTAlertWidget alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    FTAlertWidget *object = [[FTAlertWidget alloc] init];
    
    [object performSelector:@selector(dismissAlert:) withObject:alert afterDelay:timeInterval];
    
    [alert show];
    
    // 此处不能释放object对象。必须在dismissAlert：函数里释放的。
}

- (void)dismissAlert:(FTAlertWidget *)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

#pragma mark - 内建的alert回调
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            if (self.onCancelButtonClicked) {
                self.onCancelButtonClicked(self);
            }
            
            break;
            
        case 1:
            
            if (self.onOtherButtonClicked) {
                self.onOtherButtonClicked(self);
            }
            
            break;
            
        default:
            break;
    }
}

@end
