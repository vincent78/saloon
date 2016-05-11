/*********************************************************************
 文件名称 : DB.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 数据库表操作类
 *********************************************************************/

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class FTClassInfo;

//数据库类型
typedef enum {
    DBType_CtripBusiness    = 0x001,  //增量表
    DBType_CtripUserInfo,       //用户信息表
    DBType_CtripTrainInfo,      // add 5.7 火车
    DBType_Common,
    DBType_Hotel,
    DBType_Fligh,
    DBType_Train,
    DBType_Payment,
    DBType_Destination,
    DBType_Schedule
}DBType;

typedef BOOL (^DoInOneTxBlock)();  //执行一个事务时候使用该block，调入执行操作

@interface FTDB : NSObject
{
    sqlite3 *_database;  //数据库句柄
    NSString *_databaseName;//数据库名称
}
@property (nonatomic,retain) NSMutableDictionary *mapModelTable; //存放ClassInfo的字典，映射对象名称和对应的ClassInfo  key：模型类型String  Value:ClassInfo

-(id)initWithDbFileName:(NSString *)dbFileName;

/*********************************************************************
 函数名称 : saveInTx
 函数描述 : 根据传入数据模型dbmodel保存数据,加事务
 函数说明 : model里面主键需要赋值，主键没有值insert,主键有值update
 参数 :
 model : 需要保存的数据
 error : 错误信息
 返回值 :
 BOOL: 是否保存成功  YES:成功   NO:失败
 作者 :
 *********************************************************************/
- (BOOL)saveInTx:(NSObject *)model
           error:(NSError **)error;

/*********************************************************************
 函数名称 : saveNoTx
 函数描述 : 根据传入数据模型dbmodel保存数据,不加事务
 函数说明 : model里面主键不要赋值，没有值判断是insert，自增长主键,否则update
 参数 :
 model : 需要保存的数据
 error : 错误信息
 返回值 :
 BOOL: 是否保存成功  YES:成功   NO:失败
 作者 :
 *********************************************************************/
- (BOOL)saveNoTx:(NSObject *)model
           error:(NSError **)error;

/*********************************************************************
 函数名称 : updateInTx
 函数描述 :  根据传入数据模型dbmodel保存数据，用事务
 函数说明 : model里面主键需要赋值，主键没有值insert,主键有值update
 参数 :
 model : 需要更新的数据
 error : 错误信息
 返回值 :
 BOOL: 是否更新成功  YES:成功   NO:失败
 作者 :
 *********************************************************************/
- (BOOL)updateInTx:(NSObject *)model
             error:(NSError **)error;

/*********************************************************************
 函数名称 : updateNoTx
 函数描述 : 根据传入数据模型dbmodel更新数据，不用事务
 函数说明 : model里面主键需要赋值，主键没有值insert,主键有值update
 参数 :
 model : 需要更新的数据
 error : 错误信息
 返回值 :
 BOOL: 是否更新成功  YES:成功   NO:失败
 作者 :
 *********************************************************************/
- (BOOL)updateNoTx:(NSObject *)model
             error:(NSError **)error;

/*********************************************************************
 函数名称 : deleteInTx
 函数描述 :  根据传入数据模型dbmodel删除数据，用事务
 参数 :
 model : 需要更新的数据
 error : 错误信息
 返回值 :
 BOOL: 是否删除成功  YES:成功   NO:失败
 作者 :
 *********************************************************************/
- (BOOL)deleteInTx:(NSObject *)model
             error:(NSError **)error;

/*********************************************************************
 函数名称 : deleteNoTx
 函数描述 :  根据传入数据模型dbmodel删除数据，不用事务
 参数 :
 model : 需要删除的数据
 error : 错误信息
 返回值 :
 BOOL: 是否删除成功  YES:成功   NO:失败
 作者 :
 *********************************************************************/
- (BOOL)deleteNoTx:(NSObject *)model
             error:(NSError **)error;

/*********************************************************************
 函数名称 : selectAll
 函数描述 :  查询该modelClass对应表的全部数据
 参数 :
 modelClass : moedle类型，查询这个class对应的表
 error : 错误信息
 返回值 :
 NSMutableArray : 存放DbModel类型
 作者 :
 *********************************************************************/
- (NSMutableArray *)selectAll:(Class)modelClass
                        error:(NSError **)error;

/*********************************************************************
 函数名称 : selectListByBean
 函数描述 : 根据model里面的参数值作为查询条件，查询数据库中相应数据,返回List<DbModel>
 参数 :
 model : 查询参数（where里面作为查询条件）
 error : 错误信息
 返回值 :
 NSMutableArray : 存放DbModel类型
 作者 :
 *********************************************************************/
- (NSMutableArray *)selectListByBean:(NSObject *)model
                               error:(NSError **)error;

/*********************************************************************
 函数名称 : selectListByBindsParams
 函数描述 : 根据bindParamsDic里面绑定的传入参数作为查询条件，查询数据库中相应数据,返回List<DbModel>
 函数说明 : modelClass可以为字典类型，当是字典类型的时候，返回字典数组
 参数 :
 sqlIDStr : sql语句标识，根据这个获取sql语句  sqlByID包含配置表名称信息和sqlID，用_隔开，eg:hotel_sqlID1 plist文件标识为hotel,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 modelClass : 返回数组中model类型，对应具体classInfo，modelClass可以为字典类型，当是字典类型的时候，返回字典数组
 bindParamsDic ：查询参数（where里面作为查询条件）,可以为空
 error : 错误信息
 返回值 :
 NSMutableArray : 存放mode类型
 作者 :
 *********************************************************************/
- (NSMutableArray *)selectListByBindsParams:(NSString *)sqlIDStr
                                 modelClass:(Class)modelClass
                              bindParamsDic:(NSMutableDictionary *)bindParamsDic
                                      error:(NSError **)error;

/*********************************************************************
 函数名称 : selectListBySqlAndBean
 函数描述 : 根据dbmodel里面参数作为查询条件，查询数据库中相应数据,返回List<DbModel>
 函数说明 : modelClass可以为字典类型，当是字典类型的时候，返回字典数组 
 参数 :
 sqlIDStr : sql语句标识，根据这个获取sql语句 sqlByID包含配置表名称信息和sqlID，用_隔开，eg:hotel_sqlID1 plist文件标识为hotel,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 modelClass :返回数组中model类型，对应具体classInfo
 paramObject ：查询参数（where里面作为查询条件），可以是任意NSObject
 error : 错误信息
 返回值 :
 NSMutableArray : 存放DbModel类型
 作者 :
 *********************************************************************/
- (NSMutableArray *)selectListBySqlAndBean:(NSString *)sqlIDStr
                                modelClass:(Class)modelClass
                               paramObject:(NSObject *)paramsObject
                                     error:(NSError **)error;

/*********************************************************************
 函数名称 : excuteBySqlAndMapInTx
 函数描述 : 根据参数（bindParamsDic）去更新sql模板语句数据,使用事务
 函数说明 : 获取到的sql语句格式如：" a = #key1# and b= #key2#  " ,用字典中的key去替换sql中的可以对应的value
 参数 :
 sqlIDStr : sql语句标识，根据这个获取sql语句 sqlByID包含配置表名称信息和sqlID，用_隔开，eg:hotel_sqlID1 plist文件标识为hotel,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 bindParamsDic ：绑定参数
 error : 错误信息
 返回值 :
 BOOL : 是否执行成功  YES：执行成功  NO：执行失败
 作者 :
 *********************************************************************/
- (BOOL)excuteBySqlAndMapInTx:(NSString *)sqlIDStr
                bindParamsDic:(NSMutableDictionary *)bindParamsDic
                        error:(NSError **)error;

/*********************************************************************
 函数名称 : excuteBySqlAndMapNoTx
 函数描述 : 根据参数（bindParamsDic）去更新sql模板语句数据,不使用事务
 函数说明 : 获取到的sql语句格式如：" a = #key1# and b= #key2#  " ,用字典中的key去替换sql中的可以对应的value
 参数 :
 sqlIDStr : sql语句标识，根据这个获取sql语句 sqlByID包含配置表名称信息和sqlID，用_隔开，eg:hotel_sqlID1 plist文件标识为hotel,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 bindParamsDic ：绑定参数
 error : 错误信息
 返回值 :
 BOOL : 是否执行成功  YES：执行成功  NO：执行失败
 作者 :
 *********************************************************************/
- (BOOL)excuteBySqlAndMapNoTx:(NSString *)sqlIDStr
                bindParamsDic:(NSMutableDictionary *)bindParamsDic
                        error:(NSError **)error;

/*********************************************************************
 函数名称 : excuteBySqlAndBeanInTx
 函数描述 : 根据传入参数（objectBean）去更新sql模板语句数据,使用事务
 参数 :
 sqlIDStr : sql语句标识，根据这个获取sql语句 sqlByID包含配置表名称信息和sqlID，用_隔开，eg:hotel_sqlID1 plist文件标识为hotel,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 objectBean ：NSObject 对应sql中的绑定数据，用属性名对应的的属性值替换掉sql中对应的参数名
 error : 错误信息
 返回值 :
 BOOL : 是否执行成功  YES：执行成功  NO：执行失败
 作者 :
 *********************************************************************/
- (BOOL)excuteBySqlAndBeanInTx:(NSString *)sqlIDStr
                    objectBean:(NSObject *)objectBean
                         error:(NSError **)error;

/*********************************************************************
 函数名称 : excuteBySqlAndBeanNoTx
 函数描述 : 根据查询条件（bindParamsDic）去更新sql模板语句数据,不使用事务
 参数 :
 sqlIDStr : sql语句标识，根据这个获取sql语句 sqlByID包含配置表名称信息和sqlID，用_隔开，eg:hotel_sqlID1 plist文件标识为hotel,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 bindParamsDic ：绑定参数，用字典中的key去替换sql中的可以对应的value
 error : 错误信息
 返回值 :
 BOOL : 是否执行成功  YES：执行成功  NO：执行失败
 作者 :
 *********************************************************************/
- (BOOL)excuteBySqlAndBeanNoTx:(NSString *)sqlIDStr
                    objectBean:(NSObject *)objectBean
                         error:(NSError **)error;

/*********************************************************************
 函数名称 : getBeanById
 函数描述 : 传入表信息和主键Id,获取对应的mode
 参数 :
 modelClass ：class类
 primaryKeyId ： 主键对应的value
 error : 错误信息
 返回值 :
 NSObject : objClass创建的一个类，存放查询到的数据记录
 作者 :
 *********************************************************************/
- (NSObject *)getBeanById:(Class)modelClass
          primarykeyValue:(NSInteger)primarykeyValue
                    error:(NSError **)error;

/*********************************************************************
 函数名称 : getBeanByIds
 函数描述 : 根据bindParamsDic字典里面参数作为查询条件替换，查询数据库中相应数据,返回model
 函数说明 : sql语句只应该查询对应一条记录！因为返回的是对应的model，用于查询多主键，否则不应该调用这个接口
 参数 :
 sqlIDStr : sql语句标识，根据这个获取sql语句 sqlByID包含配置表名称信息和sqlID，用_隔开，eg:hotel_sqlID1 plist文件标识为hotel,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 modelClass :返回数组中model类型，对应具体classInfo
 bindParamsDic ：查询参数（where里面作为查询条件）
 error : 错误信息
 返回值 :
 NSObject : 查询到的该条就
 作者 :
 *********************************************************************/
- (NSObject *)getBeanByIds:(NSString *)sqlIDStr
                modelClass:(Class)modelClass
             bindParamsDic:(NSMutableDictionary *)bindParamsDic
                     error:(NSError **)error;

/*********************************************************************
 函数名称 : countByBindsParams
 函数描述 : 传入表信息和主键Id,获取对应的mode
 函数说明 : 传入sqlIDStr获取到的模板sql格式： select count() from tableName where param1 = #param1# ...。获取第0个字段数据int，作为count
 参数 :
 sqlIDStr : sql语句标识，根据这个去获取sql语句，获取到的sql语句格式如：" a = #key1# and b= #key2#  "
 bindParamsDic ：条件判断字典，根据这个字典参数去替换sql语句中的参数
 error : 错误信息
 返回值 :
 NSInteger: 查询到的记录条数
 作者 :
 *********************************************************************/
- (NSInteger)countByBindsParams:(NSString *)sqlIDStr
                  bindParamsDic:(NSMutableDictionary *)bindParamsDic
                          error:(NSError **)error;

/*********************************************************************
 函数名称 : doInOneTx
 函数描述 : 执行一组事务操作
 参数 :
 doInOneBlock : block 实现数据库操作
 返回值 :
 BOOL : 是否执行成功
 作者 :
 *********************************************************************/
- (BOOL)doInOneTx:(DoInOneTxBlock)doInOneBlock;


/*********************************************************************
 函数名称 : obtainClassInfoFromDic
 函数描述 : 根据传入的class获取字典中对应的classInfo，如果没有，则新建该classInfo存入
 参数 :
 objClass : 对象类
 返回值 :
 ClassInfo : 类信息
 作者 :
 *********************************************************************/
- (FTClassInfo *)obtainClassInfoFromDic:(Class)objClass;


- (NSArray *)queryBySql:(NSString *)sql;

- (BOOL)excuteBySql:(NSString *)sql;

- (sqlite3 *)handelForDatabase;
@end
