/*********************************************************************
 文件名称 : OrmErrorUtil.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 数据库错误操作类
 *********************************************************************/

#import "FTOrmErrorUtil.h"

@implementation FTOrmErrorUtil


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
                 errorCode:(ORMErrorCode)errorCode
{
    if (error)
    {
        //传入的错误描述errorDescrip信息是否存在
        if (errorDescrip || errorDescrip.length > 0)
        {
            NSError *AError = *error;
            //如果该错误信息还没有创建，则创建
            if (AError == nil)
            {
                NSString *keyStr = [[NSString alloc]initWithFormat:@"%d",errorCode];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorDescrip forKey:keyStr];
                *error = [NSError errorWithDomain:CustomErrorDomain code:errorCode userInfo:userInfo];
            }
            else
            {
                //存在error，加入错误信息
                NSString *keyStr = [[NSString alloc]initWithFormat:@"%d",errorCode];
                NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithDictionary:AError.userInfo];
                [userInfo setValue:errorDescrip forKey:keyStr];
                *error = [NSError errorWithDomain:CustomErrorDomain code:errorCode userInfo:userInfo];
                
            }
        }
    }
    
    return 1;
}

@end
