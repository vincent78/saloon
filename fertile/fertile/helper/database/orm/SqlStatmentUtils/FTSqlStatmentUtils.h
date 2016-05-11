/*********************************************************************
 文件名称 : SqlStatmentUtils.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 数据库语句操作类，包括sql语句的获取，替换，拼接等操作。
 *********************************************************************/

#import <Foundation/Foundation.h>

@class FTClassInfo;

@interface FTSqlStatmentUtils : NSObject

/*********************************************************************
 函数名称 : getSqlByID
 函数描述 : 获取plist中的字段为key的值的sql语句
 函数说明 : sqlByID包含配置表名称信息和sqlID，用_隔开，eg； hotel_sqlID1 获取第一个_前面部分的String作为plist文件标识,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 参数 :
 key : 要读取的sql的名称
 plistName ：配置表名称
 返回值 :
 NSString: 返回string
 *********************************************************************/
+ (NSString *)getSqlByID:(NSString *)sqlByID
                   error:(NSError **)error;

/*********************************************************************
 函数名称 : getSqlInsertStr
 函数描述 : 根据dbmode获取insert sql语句
 参数 :
 model : insert数据
 classInfo：字段信息
 返回值 :
 NSString: Insert sql语句  eg: INSERT INTO table_name (列1, 列2,...) VALUES (值1, 值2,....)
 作者 :
 *********************************************************************/
+ (NSString *)getSqlInsertStr:(NSObject *)model
                    classInfo:(FTClassInfo *)classInfo
                        error:(NSError **)error;

/*********************************************************************
 函数名称 : getSqlUpdateStr
 函数描述 : 根据dbmode获取update sql语句
 参数 :
 model : insert数据
 classInfo：字段信息
 返回值 :
 NSString: Insert sql语句  eg: UPDATE Person SET Address = 'Zhongshan', City = 'Nanjing'
 作者 :
 *********************************************************************/
+ (NSString *)getSqlUpdateStr:(NSObject *)model
                    classInfo:(FTClassInfo *)classInfo
                        error:(NSError **)error;

/*********************************************************************
 函数名称 : getSqlDeleteStr
 函数描述 : 根据dbmode获取删除语句
 参数 :
 model : insert数据
 classInfo：字段信息
 返回值 :
 NSString: DELETE sql语句  eg: DELETE FROM 表名称 WHERE 列名称 = '值'
 作者 :
 *********************************************************************/
+ (NSString *)getSqlDeleteStr:(NSObject *)model
                    classInfo:(FTClassInfo *)classInfo
                        error:(NSError **)error;

/*********************************************************************
 函数名称 : getSqlConditionStr
 函数描述 : 根据dbmode数据，取里面有值的数据，组装成判断语句，用于where组装
 参数 :
 model : 条件数据
 classInfo：字段信息
 返回值 :
 NSString: where 后面判断的sql语句  eg:列名称 = '值' AND 列名称 = '值' AND 列名称 = '值'
 作者 :
 *********************************************************************/
+ (NSString *)getSqlConditionStr:(NSObject *)model
                       classInfo:(FTClassInfo *)classInfo
                           error:(NSError **)error;

/*********************************************************************
 函数名称 : getSqlFromPatternSql
 函数描述 : 将模板sql语句转换为可执行的sql语句
 函数说明 : 模板sql是从plist直接获取的sql语句，参数用#paraname#表示，此函数从绑定字典中获取paraname对应的参数值，替换掉。
 paraname为字典中的关键字   eg:  select * from ctripCity where cityId=#cityId#; 转换为 select * from ctripCity where cityId=#pana1#;
 参数 :
 paranameSqlStr : 从plist中获取的模板sql语句
 bindParamsDic：存放替换参数的字典，关键字为模板sql中参数名
 返回值 :
 NSString: 可用sql语句
 作者 :
 *********************************************************************/
+ (NSString *)getSqlFromPatternSql:(NSString *)paranameSqlStr
                     bindParamsDic:(NSMutableDictionary *)bindParamsDic
                             error:(NSError **)error;

@end
