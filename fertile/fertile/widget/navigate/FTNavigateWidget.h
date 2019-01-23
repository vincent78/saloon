//
//  FTNavigateWidget.h
//  fertile_oc
//
//  Created by vincent on 15/11/5.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"
#import "FTImgBtn.h"


typedef NS_ENUM(NSInteger, FTNavigateBtnType)
{
    FTNavigateBtnTypeBtn,
    FTNavigateBtnTypeMenu
};

@interface FTNavigateWidget : FTBaseWidget




/**
 *  @brief  左边距
 */
@property CGFloat leftPadding;

/**
 *  @brief  右边距
 */
@property CGFloat rightPadding;

/**
 *  @brief  右侧btn的数组（从右到左）
 */
@property (nonatomic,copy) NSMutableArray *rightBtns;

/**
 *  @brief  左侧btn的数组(从左到右)
 */
@property (nonatomic,copy) NSMutableArray *leftBtns;



/**
 *  @brief  设置标题文字
 *
 *  @param title <#title description#>
 */
-(void) setNavTitle:(NSString *)title;

/**
 *  @brief  设置标题的控件
 *  （可通过设置这个属性来定制特殊的字体，颜色，大小等内容）
 *  @param label <#label description#>
 */
-(void) setNavTitleLabel:(UILabel *)label;


/**
 *  @brief  重置界面
 */
-(void) reset;


/**
 *  @brief  重新设置当前被选中的Btn
 *
 *  @param key <#key description#>
 */
-(void) resetSelectedBtn:(NSString *)key,... NS_REQUIRES_NIL_TERMINATION;


/**
 *  @brief  返回指定KEY的BTN
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
-(FTImgBtn *) getBtnByKey:(NSString *)key;


/**
 *  @brief  是否显示回退的箭头
 *
 *  @param show <#show description#>
 */
-(void)showBackArrow:(BOOL)show;

@end
