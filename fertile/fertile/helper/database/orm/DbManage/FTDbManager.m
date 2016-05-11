/*********************************************************************
 文件名称 : DbManager.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 表管理类
 *********************************************************************/

#import "FTDbManager.h"

static NSMutableDictionary *dbInfoDict;
static NSMutableDictionary *dbHandlerDict;

@implementation FTDbManager

#define kDBFileNameKey(type) [NSString stringWithFormat:@"db_filename_%d", type]
#define kDBHandlerKey(type) [NSString stringWithFormat:@"db_handler_%d", type]

+ (void)configDBType:(DBType)type withDBFileName:(NSString *)dbFileName {
    if (dbFileName.length == 0) {
        return;
    }
    
    @synchronized([FTDbManager class]) {
        if (dbInfoDict == NULL) {
            dbInfoDict = [[NSMutableDictionary alloc] init];
        }
        [dbInfoDict setValue:dbFileName forKey:kDBFileNameKey(type)];
        
        if (dbHandlerDict == NULL) {
            dbHandlerDict = [[NSMutableDictionary alloc] init];
        }
    }
}

/**
 *  单例
 *
 *  @param dbtype type
 *
 *  @return DB
 */
+ (FTDB *)getInstance:(DBType)type {
    @synchronized([FTDbManager class]) {
        NSString *dbHandlerKey = kDBHandlerKey(type);
        FTDB *db = [dbHandlerDict valueForKey:dbHandlerKey];
        if (db == NULL) {
            db = [[FTDB alloc] initWithDbFileName:[dbInfoDict valueForKey:kDBFileNameKey(type)]];
            [dbHandlerDict setValue:db  forKey:dbHandlerKey];
        }
        return db;
    }
}

/**
 *  2个数据库用同一把锁
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
