//
//  FTCustomAlertStyleUtil.m
//  fertile
//
//  Created by vincent on 2017/7/12.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import "FTCustomAlertStyleUtil.h"

@implementation FTCustomAlertStyleUtil


//纳税人识别号弹框-title样式
+ (NSMutableAttributedString *)taxStyle_attrTitleWithText:(NSString *)text
{
    UIFont *fontNormal  = [UIFont boldSystemFontOfSize:14];
    
    NSDictionary *normalBlackStyle = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x333333"], NSFontAttributeName:fontNormal};
    NSMutableAttributedString *attrTitleStr = [[NSMutableAttributedString alloc] initWithString:text attributes:normalBlackStyle];
    [self appentCenterParagraphToAttrStr:attrTitleStr];
    return attrTitleStr;
}

//纳税人识别号弹框-message样式
+ (NSMutableAttributedString *)taxStyle_attrMessageWithText:(NSString *)text
{
//    NSMutableAttributedString *attrMessageStr = [CTFlightStringUtil styleStringWith:text
//                                                                     fontNormalSize:12
//                                                                    fontSpecialSize:12
//                                                                        normalColor:[UIColor colorWithHexString:@"0x333333"]
//                                                                       specialColor:
//                                                 [UIColor colorWithHexString:@"0xE58F00"]];
//    [self appentCenterParagraphToAttrStr:attrMessageStr];
//    return attrMessageStr;
    return nil;
}

//纳税人识别号弹框-操作按钮样式
+ (NSMutableAttributedString *)taxStyle_buttonTitleWithText:(NSString *)text
{
//    NSMutableAttributedString *confirmAttrStr = [CTFlightStringUtil styleStringWith:text
//                                                                     fontNormalSize:14
//                                                                    fontSpecialSize:10
//                                                                        normalColor:
//                                                 [UIColor colorWithHexString:@"0x009EE1"]
//                                                                       specialColor:
//                                                 [UIColor colorWithHexString:@"0x888888"]];
//    [self appentCenterParagraphToAttrStr:confirmAttrStr];
//    return confirmAttrStr;
    return nil;
}

//居中的样式添加
+ (void)appentCenterParagraphToAttrStr:(NSMutableAttributedString *)attr
{
    NSMutableParagraphStyle*_paragraph = [[NSMutableParagraphStyle alloc]init] ;
    _paragraph.alignment=NSTextAlignmentCenter;
    _paragraph.lineSpacing=0.0;
    [attr addAttribute:NSParagraphStyleAttributeName value:_paragraph range:NSMakeRange(0, attr.string.length)];
}


@end
