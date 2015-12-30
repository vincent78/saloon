//
//  FTNavigateControllerModel.h
//  fertile_oc
//
//  Created by vincent on 15/11/5.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseModel.h"

@interface FTNavigateControllerModel : FTBaseModel

/**
 *  @brief  当前nav的key
 */
@property(nonatomic,strong) NSString *key;
/**
 *  @brief  当前nav
 */
@property(nonatomic,strong) UINavigationController * nav;
/**
 *  @brief  父nav的key
 */
@property(nonatomic,strong) NSString *parentKey;

@end
