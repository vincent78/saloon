/*********************************************************************
 文件名称 : ResultSetHandler.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 数据库查询结果模板类
 *********************************************************************/

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class FTClassInfo;

@interface FTResultSetHandler : NSObject


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
                              classInfo:(FTClassInfo *)classInfo;


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
      classInfo:(FTClassInfo *)classInfo;

@end
