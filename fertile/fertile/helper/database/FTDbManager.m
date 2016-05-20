/*********************************************************************
 文件名称 : DbManager.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 表管理类
 *********************************************************************/

#import "FTDbManager.h"


static NSMutableDictionary *dbHandlerDict;

@implementation FTDbManager

/**
 *  单例
 *
 *  @param dbtype type
 *
 *  @return DB
 */
+ (FTDatabase *)getInstance:(NSString *)dbName {
    @synchronized([FTDbManager class]) {
        FTDatabase *db = [dbHandlerDict objectForKey:dbName];
        if (db == NULL) {
            db = [[FTDatabase alloc] initWithDbFileName:dbName];
            [dbHandlerDict setObjectForFT:db forKey:dbName];
        }
        return db;
    }
}

/**
 *  多个数据库用同一把锁
 *
 *  @return lock
 */
+ (NSRecursiveLock *)getLock
{
    static NSRecursiveLock * dbLock = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        dbLock = [[NSRecursiveLock alloc] init];
    });
    
    return dbLock;
}
@end
