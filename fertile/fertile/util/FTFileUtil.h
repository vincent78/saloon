//
//  FTFileUtil.h
//  fertile_oc
//
//  Created by vincent on 15/10/28.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTFileUtil : NSObject

#pragma mark - 路径相关

/**
 *  @brief  获取指定文件在系统中的路径
 *
 *  @param resName <#resName description#>
 *  @param type    <#type description#>
 *
 *  @return <#return value description#>
 */
+(NSString *) getResFullPath:(NSString *)resName ofType:(NSString *)type;


+(NSString *) getResFullPath:(NSString *)resName ofType:(NSString *)type withFramework:(NSString *)framework;

+(NSString *) getResFullPath:(NSString *)resName ofType:(NSString *)type in:(NSBundle *)bundle;

+(NSBundle *) getBundleByName:(NSString *)bundleName;

/**
 *  @brief  获取沙盒主目录路径
 *
 *  @return <#return value description#>
 */
+ (NSString *)getHomeDirectory;

/**
 *  @brief  获取Document的目录路径
 *
 *  @return <#return value description#>
 */
+ (NSString *)getDocDirectory;


/**
 *  @brief  获取caches的目录路径
 *
 *  @return <#return value description#>
 */
+ (NSString *)getCachesDirectory;


/**
 *  @brief  获取tmp的目录路径
 *
 *  @return <#return value description#>
 */
+ (NSString *)getTmpDirectory;

/**
 *  @brief  返回APP的目录
 *
 *  @return <#return value description#>
 */
+(NSString *)getAppDirectory;


/**
 *  @brief  返回内嵌Framework的路径(embed frameworks)
 *
 *  @return <#return value description#>
 */
+(NSString *)getEmbedFrameworkDirectory;

#pragma mark - 查找相关

/**
 *  @brief  文件或路径是否存在
 *
 *  @param fullName <#fullName description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) exist:(NSString *)fullName;

/**
 *  @brief  文件是否存在
 *
 *  @param fullName <#fullName description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) fileExist:(NSString *)fullName;



/**
 *  @brief  遍历指定目录，得到对应的文件列表
 *
 *  @param subDirPath <#subDirPath description#>
 *
 *  @return <#return value description#>
 */
+(NSMutableArray *)findFiles:(NSString *)subDirPath;


+ (NSMutableArray *)findFiles:(NSString *)targetPath HasPrefixPath:(BOOL)hasPrefixPath;


+(NSMutableArray *)findFilesOnLevel:(NSString *)targetPath;


+(NSMutableArray *)findDirectOnLevel:(NSString *)targetPath;



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




#pragma mark - 操作相关

/**
 *  @brief  拷贝文件或目录
 *
 *  @param fileName        <#fileName description#>
 *  @param shouldOverwrite <#shouldOverwrite description#>
 */
+ (void)copyItem:(NSString *)sourceFullName
              to:(NSString *)targetFullName
       overwrite:(BOOL)shouldOverwrite;

/**
 *  @brief  删除目录或文件
 *
 *  @param fullName <#fullName description#>
 */
+ (void)removeItem:(NSString *)fullName;


@end
