//
//  NSDictionary+json.h
//  fertile_oc
//
//  Created by vincent on 15/10/28.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (json)

/**
 *  @brief  转成json字符串
 *
 *  @return <#return value description#>
 */
-(NSString *) jsonString;


/**
 *  @brief  写入文件
 *
 *  @param fileFullName 保存的文件名
 *  @param flag         是否追加
 */
-(void) write2File:(NSString *)fileFullName append:(BOOL)flag;

@end
