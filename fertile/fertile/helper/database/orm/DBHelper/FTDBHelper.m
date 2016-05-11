/*********************************************************************
 文件名称 : DBHelper.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : sqlite操作类
 *********************************************************************/

#import "FTDBHelper.h"
/** 数据库名称 ctrip.db */
static NSString *CTRIP_BUINESS_NAME = @"ctrip.db";
static NSString *CTRIP_USERINFO_NAME = @"ctrip_userinfo.db";
//static BOOL isFirstInit=NO;

@implementation FTDBHelper

- (sqlite3*) getDatabase
{
    return database;
}


#pragma mark ------------------------数据库初始化操作 -------------------------------------------------
// 初始化，数据库 文件，如果不存在，则拷贝文件到 document 文件下
- (void)initDB
{
    @synchronized(self)
    {
        if(isFirstInit == NO)
        {
            isFirstInit = YES;
            int retValue = -1;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *path1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
            NSString *documentPath = [path1 objectAtIndex:0];
          //  CLog(@"path=%@=",documentPath);
            NSString *path = [documentPath stringByAppendingPathComponent:databaseName];
         //   CLog(@"path=%@=",path);
            NSBundle *mainBundle = [NSBundle mainBundle];
            NSString *fromPath = [[mainBundle resourcePath] stringByAppendingPathComponent:databaseName];
            
            // 文件存在，则打开目录文件
            if([fileManager fileExistsAtPath:path] == YES)
            {
//                bool isNew = YES;//[self verifyCurrentVersionIsNewSourcePath:path];
//                
//                if(isNew == NO)
//                {
//                    #warning 刘午敬，这里临时
//                    //读取旧数据库文件中的部分用户纪录，之后写入新数据库,如果版本为3.4，则从plist中读取用户数据
////                    [SqliteUtil saveDataBaseCopyBean:path];
//
//                    // 首先 删除旧的文件(不管删除与否，下面拷贝的方法都会执行)
//                    [fileManager removeItemAtPath:path error:NULL];
//
//                    // 文件不存在，拷贝 文件到 document 下面
//                    BOOL bo = [fileManager copyItemAtPath:fromPath toPath:path error:NULL];
//
//                    if(bo == true)
//                    {
//                        sqlite3_shutdown();
//                        retValue = sqlite3_config(SQLITE_CONFIG_MULTITHREAD);
//                        if (retValue != SQLITE_OK) {
//                            //                            TLog(@"Database Config Failed!");
//                        }
//                        sqlite3_initialize();
//
//                        sqlite3_open([path UTF8String], &database);
//#warning 刘午敬，这里临时
//
//                    }else
//                    {
//                        CLog(@"数据库文件拷贝失败");
//                    }
//                }else
//                {
                    sqlite3_shutdown();
                    retValue = sqlite3_config(SQLITE_CONFIG_MULTITHREAD);
                    if (retValue != SQLITE_OK) {
                        //                        TLog(@"Database Config Failed!");
                    }
                    sqlite3_initialize();
                    
                    sqlite3_open([path UTF8String], &database);
//                }
            }else
            {
                // 文件不存在，拷贝 文件到 document 下面
                BOOL bo = [fileManager copyItemAtPath:fromPath toPath:path error:NULL];
                
                if(bo == true)
                {
                    sqlite3_shutdown();
                    retValue = sqlite3_config(SQLITE_CONFIG_MULTITHREAD);
                    if (retValue != SQLITE_OK) {
                        //                        TLog(@"Database Config Failed!");
                    }
                    sqlite3_initialize();
                    
                    sqlite3_open([path UTF8String], &database);
                }else
                {
                    FTLog(@"数据库文件不存在，请检查！！！！");
                }
            }
        }
    }
}







@end
