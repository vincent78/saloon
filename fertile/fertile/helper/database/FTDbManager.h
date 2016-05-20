/*********************************************************************
 文件名称 : DbManager.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 表管理类
 *********************************************************************/


#import "FTDatabase.h"
#import "FTDBModel.h"



//数据库类型

@class FTDatabase;

@interface FTDbManager : NSObject

/**
 *  单例
 *
 *  @param dbtype type
 *
 *  @return DB
 */
+ (FTDatabase *)getInstance:(NSString *)dbName;

/**
 *  多个数据库用同一把锁
 *
 *  @return lock
 */
+ (NSRecursiveLock *)getLock;

@end
