/*********************************************************************
 文件名称 : DB.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 数据库表操作类
 *********************************************************************/

#import "FTDatabase.h"

#import "FTFieldInfo.h"
#import "FTDBModelUtil.h"
#import "FTPropertyUtil.h"
#import "FTResultSetHandler.h"
#import "FTListBeanHandler.h"
#import "FTListMapHandler.h"
#import "FTClassInfo.h"
#import "FTSqlStatmentUtils.h"
#import "FTOrmErrorUtil.h"
#import "FTDbManager.h"

///** 数据库名称 ctrip.db */
//NSString *const CTRIP_BUINESS_NAME = @"ctrip.db";
//NSString *const CTRIP_USERINFO_NAME = @"ctrip_userinfo.db";
//// add 5.7 火车
//NSString *const CTRIP_TRAININFO_NAME = @"ctrip_traininfo.db";
//// add 6.13 酒店
//NSString *const CTRIP_HOTELINFO_NAME = @"ctrip_hotelinfo.db";

@implementation FTDatabase
@synthesize mapModelTable;

-(id)initWithDbFileName:(NSString *)dbFileName {
    if (self = [super init]) {
        self.mapModelTable = [[NSMutableDictionary alloc] init];
        _databaseName = dbFileName;
        [self initDB];
    }
    return self;
}

#pragma mark ------------------------数据库初始化操作 -------------------------------------------------
- (void)initDB
{
    int retValue = -1;
    NSString *path = [FTFileUtil getDocDirectory];
    path = [path stringByAppendingPathComponent:@"db"];
    if (![FTFileUtil exist:path])
    {
        [FTFileUtil createDirectory:path];
    }
    
    path = [path stringByAppendingPathComponent:_databaseName];
    
    if (![FTFileUtil fileExist:path])
    {
        FTDLog(@"将会创建数据库：%@",_databaseName);
    }
    
    sqlite3_shutdown();
    retValue = sqlite3_config(SQLITE_CONFIG_MULTITHREAD);
    if (retValue != SQLITE_OK) {
    }
    sqlite3_initialize();
    sqlite3_open([path UTF8String], &_database);

}

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
           error:(NSError **)error
{
    BOOL result = [self doInOneTx:^{
        
        BOOL saveresult = [self saveNoTx:model error:error];
        
        if (!saveresult)
        {
            FTELog(@"error -- 记录更新失败！");
        }
        return saveresult;
    }];
    
    return result;
}

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
           error:(NSError **)error
{
    int success = -1;
    
    if (model)
    {
        //获取mapModelTable字典中dbmodelClass的ClassInfo表信息
        FTClassInfo *classInfo = [self obtainClassInfoFromDic:model.class];
        
        if (!classInfo || [NSString emptyOrNil:classInfo.mTableName] || [NSString emptyOrNil:classInfo.mPrimarykeyName])
        {
            FTELog(@"Error--- the classInfo or tableName is null");
            [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
            return NO;
        }
        
        [[FTDbManager getLock] lock];
        
        @try
        {
            //获取插入sql语句
            NSString *sqlMsg = [FTSqlStatmentUtils getSqlInsertStr:model classInfo:classInfo error:error];
            
            success = sqlite3_exec(_database, [sqlMsg UTF8String], NULL, NULL, NULL);
            
            if (success != SQLITE_OK)
            {
                NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sqlMsg];
                FTELog(@"%@",errorMsg);
                [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqliteExeFailed];
            }
        }
        @finally
        {
            [[FTDbManager getLock] unlock];
        }
    }
    
    return success == SQLITE_OK;
}

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
             error:(NSError **)error
{
    BOOL result = [self doInOneTx:^{
        
        BOOL updateresult = [self updateNoTx:model error:error];
        
        if (!updateresult)
        {
            FTELog(@"error -- 记录更新失败！");
        }
        return updateresult;
    }];
    
    return result;
}

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
             error:(NSError **)error
{
    int success = -1;
    
    if (model)
    {
        //获取mapModelTable字典中dbmodelClass的ClassInfo表信息
        FTClassInfo *classInfo = [self obtainClassInfoFromDic:model.class];
        
        if (!classInfo || [NSString emptyOrNil:classInfo.mTableName] || [NSString emptyOrNil:classInfo.mPrimarykeyName])
        {
            FTELog(@"Error--- the classInfo or mTableName or mPrimarykeyName is null");
            [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:SqliteExeFailed];
            return NO;
        }
        
        [[FTDbManager getLock] lock];
        
        @try
        {
            //获取更新语句
            NSString *sqlMsg = [FTSqlStatmentUtils getSqlUpdateStr:model classInfo:classInfo error:error];
            
            success = sqlite3_exec(_database, [sqlMsg UTF8String], NULL, NULL, NULL);
            
            if (success != SQLITE_OK)
            {
                NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sqlMsg];
                FTELog(@"%@",errorMsg);
                [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqliteExeFailed];
            }
        }
        @finally
        {
            [[FTDbManager getLock] unlock];
        }
    }
    
    return success == SQLITE_OK;
}

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
             error:(NSError **)error
{
    BOOL result = [self doInOneTx:^{
        
        BOOL deleresult = [self deleteNoTx:model error:error];
        
        if (!deleresult)
        {
            FTELog(@"error -- 记录删除失败！");
        }
        return deleresult;
    }];
    
    return result;
}

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
             error:(NSError **)error
{
    int success = -1;
    
    if (model)
    {
        //获取model的ClassInfo表信息
        FTClassInfo *classInfo = [self obtainClassInfoFromDic:model.class];
        
        if (!classInfo || [NSString emptyOrNil:classInfo.mTableName] || [NSString emptyOrNil:classInfo.mPrimarykeyName])
        {
            FTELog(@"the classInfo or mTableName or mPrimarykeyName is null");
            [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
            return NO;
        }
        
        [[FTDbManager getLock] lock];
        
        @try
        {
            //获取删除sql语句
            NSString *sqlMsg = [FTSqlStatmentUtils getSqlDeleteStr:model classInfo:classInfo error:error];
            
            success = sqlite3_exec(_database, [sqlMsg UTF8String], NULL, NULL, NULL);
            
            if (success != SQLITE_OK)
            {
                NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sqlMsg];
                FTELog(@"%@",errorMsg);
                [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqliteExeFailed];
            }
        }
        @finally
        {
            [[FTDbManager getLock] unlock];
        }
    }
    
    return success == SQLITE_OK;
}


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
                        error:(NSError **)error
{
    //获取mapModelTable字典中dbmodelClass的ClassInfo表信息
    FTClassInfo *classInfo = [self obtainClassInfoFromDic:modelClass];
    
    if (!classInfo || [NSString emptyOrNil:classInfo.mTableName])
    {
        FTELog(@"the classInfo or mTableName is null");
        [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
        return nil;
    }
    
    NSMutableArray *modelArray = nil;
    
    [[FTDbManager getLock] lock];
    
    @try
    {
        NSString * sql = [[NSString alloc]initWithFormat:@"select * from %@",classInfo.mTableName];
        
        sqlite3_stmt *stmt;
        
        int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL);
        
        if (success != SQLITE_OK)
        {
            FTELog(@"出错了。。。。。");
            NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sql];
            [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqliteExeFailed];
        }
        
        //初始化一个以数据库结果集合，集合存放数据为model类型
        FTListBeanHandler *listBeanHandler = [[FTListBeanHandler alloc]init];
        
        //获取查询结果
        modelArray = [listBeanHandler handleFromStatement:stmt classType:modelClass classInfo:classInfo];
        
        // 释放资源
        sqlite3_finalize(stmt);
    }
    @finally
    {
        [[FTDbManager getLock] unlock];
    }
    
    return modelArray;
}


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
                               error:(NSError **)error
{
    Class dbModelClass = model.class;
    
    //获取mapModelTable字典中dbmodelClass的ClassInfo表信息
    FTClassInfo *classInfo = [self obtainClassInfoFromDic:model.class];
    
    if (!classInfo || [NSString emptyOrNil:classInfo.mTableName])
    {
        FTELog(@"the classInfo or mTableName is null");
        [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
        return nil;
    }
    
    NSMutableArray *modelArray = nil;
    
    [[FTDbManager getLock] lock];
    
    @try
    {
        //根据传入的dbmodel获取查询条件
        NSString *conditionStr = [FTSqlStatmentUtils getSqlConditionStr:model classInfo:classInfo error:error];
        
        NSString * sql = [[NSString alloc]initWithFormat:@"select * from %@ where %@",classInfo.mTableName,conditionStr];
        
        sqlite3_stmt *stmt;
        
        int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL);
        
        if (success != SQLITE_OK)
        {
            NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sql];
            FTELog(@"%@",errorMsg);
            [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqliteExeFailed];
        }
        
        //初始化一个以数据库结果集合，集合存放数据为model类型
        FTListBeanHandler *listBeanHandler = [[FTListBeanHandler alloc]init];
        
        //获取查询结果
        modelArray = [listBeanHandler handleFromStatement:stmt classType:dbModelClass classInfo:classInfo];
        
        // 释放资源
        sqlite3_finalize(stmt);
    }
    @finally
    {
        [[FTDbManager getLock] unlock];
    }
    
    return modelArray;
}

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
                                      error:(NSError **)error
{
    if (sqlIDStr)
    {
        //判定是否是字典类型，如果是字典类型，返回的是字典数组
        BOOL isDicClass = ([[NSDictionary class] isSubclassOfClass:modelClass] || [[NSMutableDictionary class] isSubclassOfClass:modelClass]);
        
        FTClassInfo *classInfo = nil;
        
        //不是字典，获取表信息
        if (!isDicClass)
        {
            //获取字典中dbmodelClass的ClassInfo表信息
            classInfo = [self obtainClassInfoFromDic:modelClass];
            
            if (!classInfo)
            {
                FTELog(@"the classInfo is null");
                [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
                return nil;
            }
        }
        
        [[FTDbManager getLock] lock];
        
        @try
        {
            NSMutableArray *modelArray = nil;
            
            //获取模板sql
            NSString *paranameSqlStr = [FTSqlStatmentUtils getSqlByID:sqlIDStr error:error];
            
            //转化为可执行的sql语句
            NSString *sql = [FTSqlStatmentUtils getSqlFromPatternSql:paranameSqlStr bindParamsDic:bindParamsDic error:error];
            
            sqlite3_stmt *stmt;
            
            int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL);
            
            if (success != SQLITE_OK)
            {
                NSString *errmsg =[[NSString alloc]initWithFormat:@"执行出错了，sqlIDStr = %@ \n sql = %@",sqlIDStr,sql];
                FTELog(@"%@",errmsg);
            }
            
            //返回的是字典数组
            if (isDicClass)
            {
                //初始化一个以数据库结果集合，集合存放数据为model类型
                FTListMapHandler *listMapHandler = [[FTListMapHandler alloc]init];
                
                //获取查询结果
                modelArray = [listMapHandler handleFromStatement:stmt classType:modelClass classInfo:classInfo];
            }
            //返回model数组
            else if ([modelClass isSubclassOfClass:[NSObject class]])
            {
                //初始化一个以数据库结果集合，集合存放数据为model类型
                FTListBeanHandler *listBeanHandler = [[FTListBeanHandler alloc]init];
                
                //获取查询结果
                modelArray = [listBeanHandler handleFromStatement:stmt classType:modelClass classInfo:classInfo];
            }
            
            // 释放资源
            sqlite3_finalize(stmt);
            
            return modelArray;
        }
        @finally
        {
            [[FTDbManager getLock] unlock];
        }
    }
    return NULL;
}


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
                                     error:(NSError **)error
{
    if (!paramsObject || ! modelClass || !sqlIDStr)
    {
        FTELog(@"the paramsObject or modelClass or sqlIDStr is null");
        [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
        return nil;
    }

    //判定是否是字典类型，如果是字典类型，返回的是字典数组
    BOOL isDicClass = ([[NSDictionary class] isSubclassOfClass:modelClass] || [[NSMutableDictionary class] isSubclassOfClass:modelClass]);
    
    FTClassInfo *classInfo = nil;
    
    NSMutableDictionary *validFieldDic = nil;
    
    if (!isDicClass)
    {
        //获取mapModelTable字典中paramsObject的ClassInfo表信息
        classInfo = [self obtainClassInfoFromDic:[paramsObject class]];
        
        if (!classInfo)
        {
            FTELog(@"the classInfo is null");
            [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
            return nil;
        }
        
        validFieldDic = [FTDBModelUtil obtainObjectValidValue:paramsObject fieldInfoArray:classInfo.mFieldArray isFilterDefalut:NO];
    }
    
    //获取结果数组
    NSMutableArray *modelArray = [self selectListByBindsParams:sqlIDStr modelClass:modelClass bindParamsDic:validFieldDic error:error];
    
    return modelArray;
}


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
                        error:(NSError **)error
{
    BOOL result = [self doInOneTx:^{
        
        BOOL updateResult = [self excuteBySqlAndMapNoTx:sqlIDStr bindParamsDic:bindParamsDic error:error];
        
        if (!updateResult)
        {
            FTELog(@"error -- sql 执行失败！");
        }
        return updateResult;
    }];
    
    return result;
}


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
                        error:(NSError **)error
{
    BOOL result = NO;
    
    if (sqlIDStr)
    {
        [[FTDbManager getLock] lock];
        
        @try
        {
            //获取模板sql
            NSString *paranameSqlStr = [FTSqlStatmentUtils getSqlByID:sqlIDStr error:error];
            
            //转化为可执行的sql语句
            NSString *sql = [FTSqlStatmentUtils getSqlFromPatternSql:paranameSqlStr bindParamsDic:bindParamsDic error:error];
            
            int success = sqlite3_exec(_database, [sql UTF8String], NULL, NULL, NULL);
            
            if (success != SQLITE_OK)
            {
                NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sql];
                FTELog(@"%@",errorMsg);
                [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqliteExeFailed];
            }
            else
            {
                result = YES;
            }
        }
        @finally
        {
            [[FTDbManager getLock] unlock];
        }
    }
    else
    {
        FTELog(@"传入参数有误！");
        [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
    }
    
    return result;
}

/**
 *执行sql语句，进行查询，结果map放到list里面
 */
- (NSArray *)queryBySql:(NSString *)sql {
    NSArray *modelArray = nil;

    if (sql.length > 0) {
        
        [[FTDbManager getLock] lock];

        @try {
            sqlite3_stmt *stmt;
            
            int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL);
            
            if (success != SQLITE_OK) {
                NSString *errmsg =[[NSString alloc]initWithFormat:@"执行出错了:sql = %@",sql];
                FTELog(@"%@",errmsg);
            } else {
                //初始化一个以数据库结果集合，集合存放数据为model类型
                FTListMapHandler *listMapHandler = [[FTListMapHandler alloc]init];
                //获取查询结果
                modelArray = [listMapHandler handleFromStatement:stmt classType:[NSDictionary class] classInfo:nil];
            }

            sqlite3_finalize(stmt);
        }
        @finally {
            [[FTDbManager getLock] unlock];
        }
    }
    
    return modelArray;
}

/**
 *执行sql语句，update操作，返回成功或者失败
 */
- (BOOL)excuteBySql:(NSString *)sql {
    BOOL result = NO;
    
    if (sql.length > 0) {
        [[FTDbManager getLock] lock];

        @try {
            int success = sqlite3_exec(_database, [sql UTF8String], NULL, NULL, NULL);
            if (success != SQLITE_OK) {
                NSError *error = [NSError errorWithDomain:@"sql执行出错" code:-1001 userInfo:@{@"sql":sql}];
                NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sql];
                FTELog(@"%@",errorMsg);
                [FTOrmErrorUtil addOneErrorDescrip:&error descrip:errorMsg errorCode:SqliteExeFailed];
            } else {
                result = YES;
            }
        }
        @finally {
            [[FTDbManager getLock] unlock];
        }
    }
    
    return result;
}

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
                         error:(NSError **)error
{
    BOOL result = [self doInOneTx:^{
        
        BOOL updateResult = [self excuteBySqlAndBeanNoTx:sqlIDStr objectBean:objectBean error:error];
        
        if (!updateResult)
        {
            FTELog(@"error -- sql 执行失败！");
        }
        return updateResult;
    }];
    
    return result;
}


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
                         error:(NSError **)error
{
    BOOL result = NO;
    
    if (objectBean && sqlIDStr)
    {
        [[FTDbManager getLock] lock];
        
        @try
        {
            //获取模板sql
            NSString *paranameSqlStr = [FTSqlStatmentUtils getSqlByID:sqlIDStr error:error];
            
            //获取绑定参数objectBean的字段信息
            FTClassInfo *classInfo = [self obtainClassInfoFromDic:objectBean.class];
            
            //获取对象的有效值，存入字典
            NSMutableDictionary *validValueDic = [FTDBModelUtil obtainObjectValidValue:objectBean fieldInfoArray:classInfo.mFieldArray isFilterDefalut:NO];
            
            //转化为可执行的sql语句
            NSString *sql = [FTSqlStatmentUtils getSqlFromPatternSql:paranameSqlStr bindParamsDic:validValueDic error:error];
            
            int success = sqlite3_exec(_database, [sql UTF8String], NULL, NULL, NULL);
            
            if (success != SQLITE_OK)
            {
                NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sql];
                FTELog(@"%@",errorMsg);
                [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqliteExeFailed];
            }
            else
            {
                result = YES;
            }
        }
        @finally
        {
            [[FTDbManager getLock] unlock];
        }
    }
    
    return result;
}

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
                    error:(NSError **)error
{
    NSObject *resultObj = nil;
    
    NSObject *bean = [[modelClass alloc]init];
    
    //获取表信息结构
    FTClassInfo *classInfo = [self obtainClassInfoFromDic:modelClass];
    
    if (!classInfo || [NSString emptyOrNil:classInfo.mPrimarykeyName])
    {
        FTELog(@"the classInfo or mPrimarykeyName is null");
        [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"传入参数有误！" errorCode:InputParamError];
        return nil;
    }
    
    //在字典中查询到表信息
    if (classInfo)
    {
        //给对象添上主键值
        [bean setValue:[NSNumber numberWithInteger:primarykeyValue] forKey:classInfo.mPrimarykeyName];
        
        //根据这个bean去获取查询结果
        NSMutableArray *resultArray = [self selectListByBean:bean error:error];
        
        //如果结果有记录
        if (resultArray.count > 0)
        {
            //取第一个数据（应该只有一个数据，因为一个主键获取到的值只应该是一个）
            resultObj = [resultArray objectAtIndex:0];
        }
    }
    
    return resultObj;
}

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
                     error:(NSError **)error
{
    NSMutableArray *modelArray = [self selectListByBindsParams:sqlIDStr modelClass:modelClass bindParamsDic:bindParamsDic error:error];
    
    if (modelArray.count > 0)
    {
        return [modelArray objectAtIndex:0];
    }
    return nil;
}

/*********************************************************************
 函数名称 : countByBindsParams
 函数描述 : 传入表信息和主键Id,获取对应的mode
 函数说明 : 传入sqlIDStr获取到的模板sql格式： select count() from tableName where param1 = #param1# ...。获取第0个字段数据int，作为count
 参数 :
 sqlIDStr : sql语句标识，根据这个获取sql语句 sqlByID包含配置表名称信息和sqlID，用_隔开，eg:hotel_sqlID1 plist文件标识为hotel,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 bindParamsDic ：条件判断字典，根据这个字典参数去替换sql语句中的参数
 error : 错误信息
 返回值 :
 NSInteger: 查询到的记录条数
 作者 :
 *********************************************************************/
- (NSInteger)countByBindsParams:(NSString *)sqlIDStr
                  bindParamsDic:(NSMutableDictionary *)bindParamsDic
                          error:(NSError **)error
{
    int result = 0;
    
    if (sqlIDStr)
    {
        [[FTDbManager getLock] lock];
        
        @try
        {
            //获取模板sql
            NSString *paranameSqlStr = [FTSqlStatmentUtils getSqlByID:sqlIDStr error:error];
            
            //转化为可执行的sql语句
            NSString *sql = [FTSqlStatmentUtils getSqlFromPatternSql:paranameSqlStr bindParamsDic:bindParamsDic error:error];
            
            sqlite3_stmt *stmt;
            
            int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL);
            
            if (success != SQLITE_OK)
            {
                NSString *errorMsg = [[NSString alloc]initWithFormat:@"SQL执行失败:%@",sql];
                FTELog(@"%@",errorMsg);
                [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqliteExeFailed];
            }
            
            if (sqlite3_step(stmt) == SQLITE_ROW)
            {
                //获取第一列的数据
                result = sqlite3_column_int(stmt,0);
            }
        }
        @finally
        {
            [[FTDbManager getLock] unlock];
        }
    }
    
    return result;
}


/*********************************************************************
 函数名称 : doInOneTx
 函数描述 : 执行一组事务操作
 参数 :
 doInOneBlock : block 实现数据库操作
 返回值 :
 BOOL : 是否执行成功
 作者 :
 *********************************************************************/
- (BOOL)doInOneTx:(DoInOneTxBlock)doInOneBlock
{
    [[FTDbManager getLock] lock];
    BOOL result = NO;
    // 开启事物
    int resultBegin = sqlite3_exec(_database, "BEGIN;", 0, 0, NULL);
    if (resultBegin==SQLITE_OK) {
        //执行操作
        BOOL isSuccess = doInOneBlock();
        if (isSuccess) {
            // 提交事物
            int resultCommit = sqlite3_exec(_database, "COMMIT;", 0, 0, NULL);
            result = (resultCommit==SQLITE_OK);
        }else{
            // huigou事物
            sqlite3_exec(_database, "ROLLBACK;", 0, 0, NULL);
            result = NO;; 
        }
    }
    
    [[FTDbManager getLock] unlock];
    return result;
}




/*********************************************************************
 函数名称 : obtainClassInfoFromDic
 函数描述 : 根据传入的class获取字典中对应的classInfo，如果没有，则新建该classInfo存入
 参数 :
 objClass : 对象类
 返回值 :
 ClassInfo : 类信息
 作者 :
 *********************************************************************/
- (FTClassInfo *)obtainClassInfoFromDic:(Class)objClass
{
    @synchronized(self) {
        FTClassInfo *classInfo = nil;
        
        if (objClass)
        {
            NSString *classStr = NSStringFromClass(objClass);
            
            if ([self.mapModelTable.allKeys indexOfObject:classStr] != NSNotFound)
            {
                //存在该类型属性
                classInfo = [self.mapModelTable objectForKey:classStr];
            }
            else
            {
                //不存在该类型的属性，则新建该class的ClassInfo
                classInfo = [[FTClassInfo alloc]initWithObjClass:objClass];
                //存入该类属性数组
                if (classStr.length > 0 && classInfo != NULL) {
                    [self.mapModelTable setObject:classInfo forKey:classStr];
                }
            }
        }
        
        return classInfo;
    }
}


- (sqlite3 *)handleForDatabase
{
    return _database;
}


@end
