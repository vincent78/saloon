//
//  FTFileUtil+readwrite.h
//  fertile
//
//  Created by vincent on 16/4/14.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTFileUtil.h"

@interface FTFileUtil (readwrite)



#pragma mark - 读取相关

/**
 *  @brief  从文件中读取字符串
 *
 *  @param fileFullName <#fileFullName description#>
 *
 *  @return <#return value description#>
 */
+(NSString *) readStrFromFile:(NSString *)fileFullName;

/**
 *  @brief  从文件中读取字典
 *
 *  @param fileFullName <#fileFullName description#>
 *
 *  @return <#return value description#>
 */
+(NSDictionary *) readDicFromFile:(NSString *)fileFullName;


/**
 *  @brief  从文件中读取数组
 *
 *  @param fileFullName <#fileFullName description#>
 *
 *  @return <#return value description#>
 */
+(NSArray *) readArrayFromFile:(NSString *)fileFullName;



/**
 *  @brief 追加内容到已存在的文件中
 *
 *  @param fileFullName <#fileFullName description#>
 *  @param str          <#str description#>
 */
+(void) strAppendToFile:(NSString *)fileFullName with:(NSString *)str;

@end
