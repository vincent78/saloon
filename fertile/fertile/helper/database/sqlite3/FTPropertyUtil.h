/*********************************************************************
 文件名称 : PropertyUtil.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 类属性操作类
 *********************************************************************/

#import <Foundation/Foundation.h>

@interface FTPropertyUtil : NSObject

/*********************************************************************
 函数名称 : obtainObjClassFieldsToArray
 函数描述 : 获取objectClass类的所有属性保存到数组
 参数 :
 objectClass : 目标类
 noPersistFieldArray : 不需要持久化字段的数组，不存入到返回结果中,存放NSString
 返回值 :
 NSMutableArray : 返回属性数组，存放类型为FieldInfo
 作者 :
 *********************************************************************/
+(NSMutableArray *)obtainObjClassFieldsToArray:(Class)objectClass
                               excludeFieldArr:(NSMutableArray *)noPersistFieldArray;

/*********************************************************************
 函数名称 : obtainObjClassFieldsToArray
 函数描述 : 获取objectClass类的所有属性保存到数组,如果有主键，则主键放到数组第一个的位置
 参数 :
 objectClass : 目标类
 noPersistFieldArray : 不需要持久化字段的数组，不存入到返回结果中,存放NSString 
 primaryName : 主键名称
 返回值 :
 NSMutableArray : 返回属性数组，存放类型为FieldInfo
 作者 :
 *********************************************************************/
+(NSMutableArray *)obtainObjClassFieldsToArray:(Class)objectClass
                               excludeFieldArr:(NSMutableArray *)noPersistFieldArray
                                primarykeyName:(NSString *)primaryName;


@end
