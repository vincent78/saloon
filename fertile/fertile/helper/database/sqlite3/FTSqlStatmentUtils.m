/*********************************************************************
 文件名称 : SqlStatmentUtils.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 数据库语句操作类，包括sql语句的获取，替换，拼接等操作。
 *********************************************************************/

#import "FTSqlStatmentUtils.h"
#import "FTClassInfo.h"
#import "FTFieldInfo.h"
#import "FTDBModelUtil.h"
#import "FTOrmErrorUtil.h"

@implementation FTSqlStatmentUtils

/*********************************************************************
 函数名称 : getSqlByID
 函数描述 : 获取plist中的字段为key的值的sql语句
 函数说明 : sqlByID包含配置表名称信息和sqlID，用_隔开，eg； hotel_sqlID1 获取第一个_前面部分的String作为plist文件标识,配置表名称为 hotel_SqlMaps，sqlID为sqlID1
 参数 :
 key : 要读取的sql的名称
 plistName ：配置表名称
 返回值 :
 NSString: 返回string
 *********************************************************************/
+ (NSString *)getSqlByID:(NSString *)sqlByID
                   error:(NSError **)error
{
    if (sqlByID)
    {
        NSArray *separArr = [sqlByID componentsSeparatedByString:@"_"];
        if (separArr.count >1)
        {
            //获取配置表头
            NSString *plistHeadStr = [separArr objectAtIndex:0];
            
            //获取sql配置plist名称
            NSString *plstName = [[NSString alloc]initWithFormat:@"%@_SqlMaps",plistHeadStr];
            
            //sql标识
            NSString *sqlID = [sqlByID substringFromIndex:plistHeadStr.length + 1];
            
            if (![NSString emptyOrNil:plstName] && ![NSString emptyOrNil:sqlID])
            {
                NSString *plistPath = [[NSBundle mainBundle] pathForResource:plstName ofType:@"plist"];
                @try {
                    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
                    NSString *str = [[NSString alloc]initWithFormat:@"%@",[data valueForKey:sqlID]];
                    
                    if (![NSString emptyOrNil:str] && ![str isEqualToString:@"(null)"])
                    {
                        return str;
                    }
                }
                @catch (NSException *exception) {
                    return NULL;
                }
                @finally {

                }
               
            }
        }
    }

    NSString *errorMsg = [[NSString alloc]initWithFormat:@"获取sql语句失败,sqlByID为: %@ ",sqlByID];
    FTELog(@"%@",errorMsg);
    [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:GetSqlFailed];
    return @"";
}

/*********************************************************************
 函数名称 : getSqlInsertStr
 函数描述 : 根据dbmode获取insert sql语句
 参数 :
 model : insert数据
 classInfo：字段信息
 返回值 :
 NSString: Insert sql语句  eg: INSERT INTO table_name (列1, 列2,...) VALUES (值1, 值2,....)
 作者 :
 *********************************************************************/
+ (NSString *)getSqlInsertStr:(NSObject *)model
                    classInfo:(FTClassInfo *)classInfo
                        error:(NSError **)error
{
    
    NSMutableArray *fieldArray = classInfo.mFieldArray;
    
    //存放所有列名字符串  eg：列1, 列2,...
    NSMutableString *headStr = [[NSMutableString alloc]init];
    //存放所有value字符串 eg: 值1, 值2,....
    NSMutableString *tailStr = [[NSMutableString alloc]init];
    
    //拼接所有字段
    for (FTFieldInfo *fieldInfo in fieldArray)
    {
        //添加一个字段到headStr
        [headStr appendFormat:@" %@,",fieldInfo.fieldName];
        
        //添加字段值到tailStr
        NSString *fieldValueStr = [FTDBModelUtil obtainFieldValueStrForModel:model fieldInfo:fieldInfo];
        [tailStr appendFormat:@" '%@',",fieldValueStr];
    }
    
    //前面最后一个多了一个"，"这里要清除掉
    [headStr deleteCharactersInRange:NSMakeRange(headStr.length-1, 1)];
    [tailStr deleteCharactersInRange:NSMakeRange(tailStr.length-1, 1)];
    
    //拼装INSERT字符串 eg: INSERT INTO table_name (列1, 列2,...) VALUES (值1, 值2,....)
    NSString *insertStr = [[NSString alloc]initWithFormat:@"INSERT INTO %@ (%@) VALUES (%@) ",classInfo.mTableName,headStr,tailStr];
    
    return insertStr;
}


/*********************************************************************
 函数名称 : getSqlUpdateStr
 函数描述 : 根据dbmode获取update sql语句
 参数 :
 model : insert数据
 classInfo：字段信息
 返回值 :
 NSString: Insert sql语句  eg: UPDATE Person SET Address = 'Zhongshan', City = 'Nanjing' WHERE 列名称 = 某值
 作者 :
 *********************************************************************/
+ (NSString *)getSqlUpdateStr:(NSObject *)model
                    classInfo:(FTClassInfo *)classInfo
                        error:(NSError **)error
{
    NSMutableArray *fieldArray = classInfo.mFieldArray;
    
    //存放sql Str
    NSMutableString *updateStr = [[NSMutableString alloc]initWithFormat:@"UPDATE %@ SET",classInfo.mTableName];
    
    //拼接所有字段
    for (FTFieldInfo *fieldInfo in fieldArray)
    {
        //获取字段值
        NSString *fieldValueStr = [FTDBModelUtil obtainFieldValueStrForModel:model fieldInfo:fieldInfo];
        //拼接字段
        [updateStr appendFormat:@" %@ = '%@',",fieldInfo.fieldName,fieldValueStr];
    }
    
    //最后多了一个"，"这里要清除掉
    [updateStr deleteCharactersInRange:NSMakeRange(updateStr.length - 1, 1)];
    
    //获取主键值
    NSNumber *parayKeyValue = [model valueForKey:classInfo.mPrimarykeyName];
    
    //添加where判断
    [updateStr appendFormat:@" where %@ = '%@'",classInfo.mPrimarykeyName,parayKeyValue];
    
    //转换为NSString,用做返回值
    NSString *sqlUpdateStr = [[NSString alloc]initWithString:updateStr];
    
    return sqlUpdateStr;
}

/*********************************************************************
 函数名称 : getSqlDeleteStr
 函数描述 : 根据dbmode获取删除语句
 参数 :
 model : insert数据
 classInfo：字段信息
 返回值 :
 NSString: DELETE sql语句  eg: DELETE FROM 表名称 WHERE 列名称 = '值'
 作者 :
 *********************************************************************/
+ (NSString *)getSqlDeleteStr:(NSObject *)model
                    classInfo:(FTClassInfo *)classInfo
                        error:(NSError **)error
{
    //获取主键field
    FTFieldInfo *parmaryFieldInfo = [classInfo obtainPrimaryKeyFieldInfo];
    
    NSNumber *parmaryValue =[model valueForKey:parmaryFieldInfo.fieldName];
    
    NSString *deleteSqlStr = [[NSString alloc]initWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",
                              classInfo.mTableName,parmaryFieldInfo.fieldName,parmaryValue];
    return deleteSqlStr;
}

/*********************************************************************
 函数名称 : getSqlConditionStr
 函数描述 : 根据dbmode数据，取里面有值的数据，组装成判断语句，用于where组装
 参数 :
 model : 条件数据
 classInfo：字段信息
 返回值 :
 NSString: where 后面判断的sql语句  eg:列名称 = '值' AND 列名称 = '值' AND 列名称 = '值'
 作者 :
 *********************************************************************/
+ (NSString *)getSqlConditionStr:(NSObject *)model
                       classInfo:(FTClassInfo *)classInfo
                           error:(NSError **)error
{
    NSMutableString *conditionMutStr = [[NSMutableString alloc]init];
    
    NSMutableArray *fieldArray = classInfo.mFieldArray;
    
    for (FTFieldInfo *fieldInfo in fieldArray)
    {
        //判断值是否有效，只拼接有效值，无效值不拼接
        id value = [model valueForKey:fieldInfo.fieldName];
        if ([FTDBModelUtil isValidForFieldValue:value fieldType:fieldInfo.fieldType])
        {
            //获取str值
            NSString *fieldValueStr = [[NSString alloc]initWithFormat:@"%@",value];
            
            //组装字段
            [conditionMutStr appendFormat:@" %@ = '%@' AND",fieldInfo.fieldName,fieldValueStr];
        }   
    }
    
    //最后多了一个"AND"这里要清除掉
    NSString *conditionStr = [conditionMutStr substringToIndex:conditionMutStr.length - 3];
    
    return conditionStr;
}

/*********************************************************************
 函数名称 : getSqlFromPatternSql
 函数描述 : 将模板sql语句转换为可执行的sql语句
 函数说明 : 模板sql是从plist直接获取的sql语句，参数用#paraname#表示，此函数从绑定字典中获取paraname对应的参数值，替换掉。
 paraname为字典中的关键字   eg:  select * from ctripCity where cityId=#cityId#; 转换为 select * from ctripCity where cityId=#pana1#;
 参数 :
 paranameSqlStr : 从plist中获取的模板sql语句
 bindParamsDic：存放替换参数的字典，关键字为模板sql中参数名
 返回值 :
 NSString: 可用sql语句
 作者 :
 *********************************************************************/
+ (NSString *)getSqlFromPatternSql:(NSString *)paranameSqlStr
                     bindParamsDic:(NSMutableDictionary *)bindParamsDic
                             error:(NSError **)error
{
    if (paranameSqlStr)
    {
        //替换井号#
        NSString *sqlRepaceOcStr = [self patternSqlReplaceQuotes:paranameSqlStr
                                                   bindParamsDic:bindParamsDic
                                                           error:error];
        
        //替换单引号|
        NSString *sqlStr = [self patternSqlReplaceOctothorpe:sqlRepaceOcStr
                                               bindParamsDic:bindParamsDic
                                                       error:error];
        if (sqlStr.length > 0)
        {
            return sqlStr;
        }
    }
    FTELog(@"Error:没有正确的转换模板数据库");
    [FTOrmErrorUtil addOneErrorDescrip:error descrip:@"Error:没有正确的转换模板数据库" errorCode:SqlReplaceFailed];
    
    return @"";
}

/*********************************************************************
 函数名称 : patternSqlReplaceOctothorpe
 函数描述 : 将模板sql语句里面的井号替换上字典中对应的值 eg: cityId=#cityId#转换为cityId='pana1' 加引号
 参数 :
 paranameSqlStr : 从plist中获取的模板sql语句
 bindParamsDic：存放替换参数的字典，关键字为模板sql中参数名
 返回值 :
 NSString: 替换后的sql语句
 作者 :
 *********************************************************************/
+ (NSString *)patternSqlReplaceOctothorpe:(NSString *)paranameSqlStr
                     bindParamsDic:(NSMutableDictionary *)bindParamsDic
                             error:(NSError **)error
{
    if (paranameSqlStr)
    {
        /*
         替换思路：将paranameSqlStr用#分开 那么里面的奇数数组内容就是需要替换的参数
         轮循paranameArr，用skip记录光标移动位置，当数组为单数的时候，是参数，替换掉
         */
        NSArray *paranameArr = [paranameSqlStr componentsSeparatedByString:@"#"];
        
        //至少有一对#,即至少有一个参数需要替换
        NSInteger arrCount = paranameArr.count;
        if (arrCount > 2 && bindParamsDic.count > 0)
        {
            //可变字符串，用于替换
            NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:paranameSqlStr];
            NSInteger skip = 0; //记录光标移动位置
            for (NSInteger i = 0; i< arrCount; i++)
            {
                NSString *str = [paranameArr objectAtIndex:i];
                if (i % 2 != 0)
                {
                    //是奇数数组内容，是需要替换的内容
                    NSString *paraValue = [[NSString alloc]initWithFormat:@"%@",[bindParamsDic objectForKey:str]];
                    
                    if (!paraValue || [paraValue isEqualToString:@"(null)"])
                    {
                        //为获取到正确的sql语句
                        NSString *errorMsg = [[NSString alloc]initWithFormat:@"未获取到%@有效的替换值,sql: %@",str,paranameSqlStr];
                        FTELog(@"%@",errorMsg);
                        [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqlReplaceFailed];
                        break;
                    }
                    
                    //替换位置为skip，长度为str长度
                    NSRange range = NSMakeRange(skip - 1, str.length + 2); //-1 是因为要包括左右两个#
                    
                    if ([self isLinkStr:mutableStr paramRange:range])
                    {
                        //是link匹配
                        [mutableStr replaceCharactersInRange:range withString:paraValue];
                        skip = skip + paraValue.length - 1;//#拆分时#被过滤 +1，替换的时候替换掉类##左右2个，需要-2 所以此处 -2+1
                    }
                    else
                    {
                        //不是link匹配，给替换的内容左右两边加上‘’
                        NSString *replaceValue = [[NSString alloc]initWithFormat:@"'%@'",paraValue];
                        [mutableStr replaceCharactersInRange:range withString:replaceValue];
                        skip = skip + replaceValue.length - 1;//#拆分时#被过滤 +1，替换的时候替换掉类##左右2个，需要-2 所以此处 -2+1
                    }
                }
                else
                {
                    skip = skip + str.length + 1;//#拆分时#被过滤，此处加上
                }
            }
            NSString *availableSqlStr = [[NSString alloc]initWithFormat:@"%@",mutableStr];
            return availableSqlStr;
        }
        else if (arrCount == 1 || arrCount == 2)
        {
            //没有需要替换的参数
            return paranameSqlStr;
        }
    }
    
    return @"";
}

/*********************************************************************
 函数名称 : patternSqlReplaceQuotes
 函数描述 : 将模板sql语句里面的'|'替换上字典中对应的值 eg: cityId=|cityId|转换为cityId=pana1 不加引号
 参数 :
 paranameSqlStr : 从plist中获取的模板sql语句
 bindParamsDic：存放替换参数的字典，关键字为模板sql中参数名
 返回值 :
 NSString: 替换后的sql语句
 作者 :
 *********************************************************************/
+ (NSString *)patternSqlReplaceQuotes:(NSString *)paranameSqlStr
                     bindParamsDic:(NSMutableDictionary *)bindParamsDic
                             error:(NSError **)error
{
    if (paranameSqlStr)
    {
        /*
         替换思路：将paranameSqlStr用|分开 那么里面的奇数数组内容就是需要替换的参数
         轮循paranameArr，用skip记录光标移动位置，当数组为单数的时候，是参数，替换掉
         */
        NSArray *paranameArr = [paranameSqlStr componentsSeparatedByString:@"|"];
        
        //至少有一对|,即至少有一个参数需要替换
        NSInteger arrCount = paranameArr.count;
        if (arrCount > 2 && bindParamsDic.count > 0)
        {
            //可变字符串，用于替换
            NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:paranameSqlStr];
            NSInteger skip = 0; //记录光标移动位置
            for (NSInteger i = 0; i< arrCount; i++)
            {
                NSString *str = [paranameArr objectAtIndex:i];
                if (i % 2 != 0)
                {
                    //是奇数数组内容，是需要替换的内容
                    NSString *paraValue = [[NSString alloc]initWithFormat:@"%@",[bindParamsDic objectForKey:str]];
                    
                    if (!paraValue || [paraValue isEqualToString:@"(null)"])
                    {
                        //为获取到正确的sql语句
                        NSString *errorMsg = [[NSString alloc]initWithFormat:@"未获取到%@有效的替换值,sql: %@",str,paranameSqlStr];
                        FTELog(@"%@",errorMsg);
                        [FTOrmErrorUtil addOneErrorDescrip:error descrip:errorMsg errorCode:SqlReplaceFailed];
                        break;
                    }
                    
                    //替换位置为skip，长度为str长度
                    NSRange range = NSMakeRange(skip - 1, str.length + 2); //-1 是因为要包括左右两个|

                    //是link匹配
                    [mutableStr replaceCharactersInRange:range withString:paraValue];
                    skip = skip + paraValue.length - 1;//|拆分时|被过滤 +1，替换的时候替换掉类||左右2个，需要-2 所以此处 -2+1
                }
                else
                {
                    skip = skip + str.length + 1;//|拆分时|被过滤，此处加上
                }
            }
            NSString *availableSqlStr = [[NSString alloc]initWithFormat:@"%@",mutableStr];
            return availableSqlStr;
        }
        else if (arrCount == 1 || arrCount == 2)
        {
            //没有需要替换的参数
            return paranameSqlStr;
        }
    }

    return @"";
}


/**
 *  判断该位置的参数是否是link匹配
 *  如果是link匹配，不需要加双引号，此处判断是否是link匹配的参数，判断方式，参数前后是否有 % 或者 _ ,有就判定为link匹配字符
 *
 *  @param paranameSqlStr sql替换模板NSString
 *  @param paramRange     参数位置      
 *
 *  @return BOOL YES：是link匹配  NO：不是link匹配 
 */
+ (BOOL)isLinkStr:(NSString *)paranameSqlStr paramRange:(NSRange)paramRange
{
    //获取参数前面一个字符
    if (paramRange.location > 0)
    {
        NSString *headStr = [paranameSqlStr substringWithRange:NSMakeRange(paramRange.location -1, 1)];
        if ([headStr isEqualToString:@"%"] || [headStr isEqualToString:@"_"])
        {
            //是link匹配
            return YES;
        }
    }
    //获取参数后面一个字符
    if (paramRange.location + paramRange.length < paranameSqlStr.length -1)
    {
        NSString *tailStr = [paranameSqlStr substringWithRange:NSMakeRange(paramRange.location + paramRange.length, 1)];
        if ([tailStr isEqualToString:@"%"] || [tailStr isEqualToString:@"_"])
        {
            //是link匹配
            return YES;
        }
    }
    return NO;
}

@end
