//
//  FTAppHelper.h
//  fertile_oc
//
//  App级别的Helper
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"
#import "FTNavigateWidget.h"

#import "FTAppDelegate.h"


@protocol FTAppHelperDelegate

@required

/**
 *  @brief  准备APP的导航栏
 *
 *  @return 为空则显示系统的导航栏
 */
-(FTNavigateWidget *) prepareNavigateBar;


@end





@interface FTAppHelper : FTBaseHelper

+(FTAppHelper *) sharedInstance;

@property (nonatomic,strong) id<FTAppHelperDelegate> delegate;

@property (nonatomic,strong) NSMutableDictionary *appDic;

@property (nonatomic,strong) UIColor *vcBackGroundColor;


@property (nonatomic,strong) RACSubject *printAppInfoSingal;



#pragma mark - navigate

/**
 *  @brief  获取当前APP的通用导航栏
 *
 *  @return <#return value description#>
 */
-(FTNavigateWidget *)getNavWidget;



#pragma mark - 字体相关
/**
 *  @brief  APP默认使用的Font
 *
 *  @param size <#size description#>
 *
 *  @return <#return value description#>
 */
+(UIFont *) defaultFont:(CGFloat)size;


/**
 *  @brief  APP默认使用的粗体Font
 *
 *  @param size <#size description#>
 *
 *  @return <#return value description#>
 */
+(UIFont *) defaultBoldFont:(CGFloat)size;

#pragma mark - APP的信息
/**
 *  @brief 获取bundle的系统内容
 *
 *  @return <#return value description#>
 */
+(NSDictionary *) bundleInfo;

/**
 *  @brief 获取APP的版本号
 *
 *  @return <#return value description#>
 */
+(NSString *) getVersion;

/**
 *  @brief 是否为debug环境
 *
 *  @return <#return value description#>
 */
+(BOOL) isDebug;




@end
