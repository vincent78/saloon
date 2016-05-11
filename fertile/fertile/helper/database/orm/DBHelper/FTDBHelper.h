/*********************************************************************
 文件名称 : DBHelper.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : sqlite操作类
 *********************************************************************/

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface FTDBHelper : NSObject
{
    sqlite3 *database;  //数据库句柄
    NSLock *excutionLock;  //执行锁
    BOOL isFirstInit;  //判断是否是第一个初始化数据库
    NSString *databaseName;//数据库名称
}


//获取数据库句柄
- (sqlite3 *) getDatabase;

// 初始化，数据库 文件，如果不存在，则拷贝文件到 document 文件下
- (void)initDB;

@end
