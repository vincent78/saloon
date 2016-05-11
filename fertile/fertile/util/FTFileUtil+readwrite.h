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
 *  @brief 读取NSData
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
+ (NSData *)readDataFromFile:(NSString *)filePath;

/**
 *  @brief 从plist文件中读取数据
 *
 *  @param fileName plist的文件名，不带扩展名(.plist)
 *
 *  @return <#return value description#>
 */
+(NSMutableDictionary *) readPListFile:(NSString *)fileName;

#pragma mark 写文件

/**
 *  @brief 追加内容到已存在的文件中
 *
 *  @param fileFullName <#fileFullName description#>
 *  @param str          <#str description#>
 */
+(void) strAppendToFile:(NSString *)fileFullName with:(NSString *)str;



/**
 *  @brief 将NSData写入文件
 *
 *  @param data     <#data description#>
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)writeData:(NSData *)data filePath:(NSString *)filePath;

/**
 *  @brief 将字符串写入文件
 *
 *  @param content  <#content description#>
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)writeContent:(NSString *)content filePath:(NSString *)filePath;








@end
