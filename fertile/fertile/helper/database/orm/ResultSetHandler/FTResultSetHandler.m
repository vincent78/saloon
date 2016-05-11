/*********************************************************************
 文件名称 : ResultSetHandler.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 数据库查询结果模板类  
 *********************************************************************/

#import "FTResultSetHandler.h"

@implementation FTResultSetHandler

/*********************************************************************
 函数名称 : handleFromStatement
 函数描述 : 操作查询结果，获取结果集合
 参数 :
 stmt : sqlite3_stmt查询结果集
 classType : 查询结果model类型
 classInfo :字段信息
 返回值 :
 NSMutableArray : 存储查询的结果集合
 作者 :
 *********************************************************************/
- (NSMutableArray *)handleFromStatement:(sqlite3_stmt *)stmt
                              classType:(Class)classType
                              classInfo:(FTClassInfo *)classInfo
{
    NSMutableArray *resuleArray = [[NSMutableArray alloc]init];
    
    // 执行SQL文，并获取结果
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        //获取查询到的model
        id model = [self handleRow:stmt dbmodelClass:classType classInfo:classInfo];
        //将model存入数组
        if (model != NULL) {
            [resuleArray addObject:model];
        }
    }
    
//    CLog(@"查到数据count = %d calss:%@",resuleArray.count,NSStringFromClass(classType));
    return resuleArray;
}


#pragma mark - Details must be handled by subclasses

/*********************************************************************
 函数名称 : handleRow
 函数描述 : 操作查询的每一条结果，返回不同结果类型，子类必须继承该方法，覆盖该方法重写！
 参数 :
 stmt : sqlite3_stmt查询结果集
 dbmodelClass : 查询结果model类型
 classInfo :字段信息
 返回值 :
 id : 返回该条记录结果
 作者 :
 *********************************************************************/
- (id)handleRow:(sqlite3_stmt *)stmt
        dbmodelClass:(Class)dbmodelClass
        classInfo:(FTClassInfo *)classInfo
{
    //子类必须继承该方法，覆盖该方法！
    FTLog(@"ERROR -- 不应该执行该方法！");
    id detailResult = NULL;
    return detailResult;
}

@end
