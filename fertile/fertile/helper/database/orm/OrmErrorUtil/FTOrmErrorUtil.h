/*********************************************************************
 文件名称 : OrmErrorUtil.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 数据库错误操作类
 *********************************************************************/

#import <Foundation/Foundation.h>

#define CustomErrorDomain @"OrmError"

typedef enum {
    SqliteExeFailed = -1000,    //执行失败
    SqlReplaceFailed,    //sql语句替换失败
    InputParamError,    //输入参数有误
    GetSqlFailed,  //获取sql失败
    
}ORMErrorCode;

@interface FTOrmErrorUtil : NSObject

/*********************************************************************
 函数名称 : getErrorWithDescrip
 函数描述 : 传入错误描述和错误代码，获取一个错误类
 参数 :
 error ： error参数
 errorDescrip :错误描述
 errorCode ：错误代码
 返回值 :
 *********************************************************************/
+ (int)addOneErrorDescrip:(NSError **)error
                   descrip:(NSString *)errorDescrip
                 errorCode:(ORMErrorCode)errorCode;




@end
