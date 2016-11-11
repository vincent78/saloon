//
//  FTBaseHelper.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTHelperProtocol <NSObject>

@required
/**
 *  @brief  初始化
 */
- (void)helperInit;
/**
 *  @brief  重置
 */
- (void)helperRelease;

- (void)didReceiveMemoryWarning;



@end

@interface FTBaseHelper : NSObject <FTHelperProtocol>

@end
