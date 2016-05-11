/*********************************************************************
 文件名称 : DBModelUtil.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 表操作类组件
 *********************************************************************/

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FTFieldInfo.h"
#import "FTDB.h"
@class FTDB;
@class FTClassInfo;
@class FTFieldInfo;

@interface FTDBModelUtil : NSObject

/*********************************************************************
 函数名称 : getOneDbModelFromDBase
 函数描述 : 从查询的dabase获取一个dbmodel
 参数 :
 dbase : sql查询结果
 modelClass：创建的modelClass类型
 classInfo：字段信息
 返回值 :
 DbModel: 查询的数据的dbModel
 作者 :
 *********************************************************************/
+ (id)getOneDbModelFromDBase:(sqlite3_stmt *)stmt
                  modelClass:(Class)modelClass
                   classInfo:(FTClassInfo *)classInfo;

/*********************************************************************
 函数名称 : getOneDicFromDBase
 函数描述 : 从查询的dabase获取一个字典集合
 参数 :
 dbase : sql查询结果
 返回值 :
 NSMutableDictionary: 查询的数据的字典  数据全部是NSString  key：filedName value:(NSString *)fieldValue
 作者 :
 *********************************************************************/
+ (NSMutableDictionary *)getOneDicFromDBase:(sqlite3_stmt *)stmt;

/*********************************************************************
 函数名称 : obtainObjectValidValue
 函数描述 : 获取目标类的有效字段，存入字典
 参数 :
 object : 有效NSObject对象
 fieldInfoArray：对应的字段信息数组
 isFilterDefalut :是否过滤掉无效值，YES：过滤掉无效值，NO，不过滤无效值
 返回值 :
 NSMutableDictionary: 有用的字段字典 key：字段名称  value： 字段值
 作者 :
 *********************************************************************/
+ (NSMutableDictionary *)obtainObjectValidValue:(NSObject *)object
                                 fieldInfoArray:(NSMutableArray *)fieldInfoArray
                                isFilterDefalut:(BOOL)isFilterDefalut;

/**
 *  获取目标对象的属性和值的对应字典，以键值对保存到字典返回,不过滤无效值
 *
 *  @param object NSObject目标对象
 *
 *  @return 存放有效字段的字典
 */
+ (NSMutableDictionary *)obtainPropMap:(NSObject *)object dbType:(DBType)dbType;



/*********************************************************************
 函数名称 : obtainModelClassStr
 函数描述 : 获取传入model的类型字符串
 参数 :
 model : 数据模型
 返回值 :
 NSString: 返回模型类型字符串 eg: Ctripcity
 作者 :
 *********************************************************************/
+ (NSString *)obtainModelClassStr:(NSObject *)model;

/*********************************************************************
 函数名称 : isValidForFieldValue
 函数描述 : 判断字段值是否有效
 函数说明 : 判断标准，如果是基础类型，则判断是否为其默认值0，如果是对象，则判断对象是否为空
 参数 :
 fieldValue : 字段值 id类类型，基础类型用NSNumber
 type : 字段类型
 返回值 : BOOL  YES:字段有效   NO:字段无效
 作者 :
 *********************************************************************/
+(BOOL)isValidForFieldValue:(id)fieldValue
                  fieldType:(eTypeOfProperty)type;

/*********************************************************************
 函数名称 : obtainFieldValueStrForModel
 函数描述 : 根据传入的字段属性获取该字段值,转化为String输出
 参数 :
 model : 有效数据模型
 fieldInfo : 字段属性
 返回值 :
 NSString :字段值
 作者 :
 *********************************************************************/
+(NSString *)obtainFieldValueStrForModel:(NSObject *)model
                               fieldInfo:(FTFieldInfo *)fieldInfo;

@end
