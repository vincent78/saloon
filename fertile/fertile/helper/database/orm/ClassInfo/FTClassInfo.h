/*********************************************************************
 文件名称 : ClassInfo.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 类字段数据信息类（当是表的对应的时候，需要传入表主键）
 *********************************************************************/

#import <Foundation/Foundation.h>

@class FTFieldInfo;

@interface FTClassInfo : NSObject
{
    
}

@property (nonatomic,retain) NSString *mTableName; //表名
@property (nonatomic,retain) NSString *mPrimarykeyName;  //主键名称,没有主键此处为空
@property (nonatomic,assign) Class *mModelType; //数据模型
@property (nonatomic,retain) NSMutableArray *mFieldArray;//字段数组，仅获取需要持久化的字段,其中主键放到第一个位置，方便获取

/*********************************************************************
 函数名称 : initWithDBmodel:tableName
 函数描述 : 初始化
 参数 :
 objectClass: 表名
 返回值 : id
 作者 :
 *********************************************************************/
-(id)initWithObjClass:(Class)objectClass;


/*********************************************************************
 函数名称 : obtainPrimaryKeyFieldInfo
 函数描述 : 获取表信息中主键字段模型,获取失败返回Null
 参数 :
 dbmodel : 数据模型
 返回值 : 
 FieldInfo : 字段属性
 作者 :
 *********************************************************************/
-(FTFieldInfo *)obtainPrimaryKeyFieldInfo;

/*********************************************************************
 函数名称 : obtainFieldInfoForFieldName
 函数描述 : 根据字段名称获取表信息中字段模型,获取失败返回Null
 参数 :
 fieldName : 字段名称
 返回值 :
 FieldInfo : 字段属性
 作者 :
 *********************************************************************/
-(FTFieldInfo *)obtainFieldInfoForFieldName:(NSString *)fieldName;

@end
