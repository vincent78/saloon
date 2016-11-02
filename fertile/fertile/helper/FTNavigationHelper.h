//
//  FTRouteHelper.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"
#import "FTBaseViewController.h"


@interface FTNavigationHelper : FTBaseHelper

+(FTNavigationHelper *) sharedInstance;


/**
 *  @brief  获取当前使用的NavigateController
 *
 *  @return <#return value description#>
 */
-(UINavigationController *) getCurrNav;

/**
 *  @brief  将指定KEY的nav设置为当前nav,如果未找到此key则新建
 *
 *  @param key <#key description#>
 */
-(void) setCurrNavByKey:(NSString *)key;


/**
 *  @brief  将vc入堆栈（根）
 *
 *  @param vcClass <#vcClass description#>
 */
-(void) pushWithClass:(Class)vcClass;

/**
 *  @brief  将VC以动画方式入堆栈(根)
 *
 *  @param vcClass     <#vcClass description#>
 *  @param animateType <#animateType description#>
 */
-(void) pushVC:(Class)vcClass
   withAnimate:(UIViewAnimateType) animateType;


/**
 *  @brief  将VC入堆栈(根)
 *
 *  @param vc <#vc description#>
 */
-(void) pushWithVC:(FTBaseViewController *)vc ;

/**
 *  @brief  将VC以动画方式入堆栈(根)
 *
 *  @param vc          <#vc description#>
 *  @param animateType <#animateType description#>
 */
-(void) pushWithVC:(FTBaseViewController *)vc
       withAnimate:(UIViewAnimateType) animateType;


/**
 *  @brief  出栈
 */
-(void) pop;

/**
 *  @brief  出栈，直至指定的VC
 *
 *  @param vc <#vc description#>
 */
-(void) popToVC:(FTBaseViewController *)vc;

/**
 *  @brief  出栈，直至指定的VC
 *
 *  @param vcClass <#vcClass description#>
 */
-(void) popToClass:(FTBaseViewController *) vcClass;

/**
 *  @brief  是否包含VC
 *
 *  @param vcClass <#vcClass description#>
 *
 *  @return <#return value description#>
 */
-(FTBaseViewController *) contain:(Class)vcClass;


/**
 *  @brief  得到前一个VC
 
 *
 *  @return <#return value description#>
 */
-(FTBaseViewController *) getPreVC;


@end
