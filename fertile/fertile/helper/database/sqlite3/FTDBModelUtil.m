/*********************************************************************
 文件名称 : DBModelUtil.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 表操作类组件
 *********************************************************************/

#import "FTDBModelUtil.h"
#import "FTFieldInfo.h"
#import "FTClassInfo.h"
#import "FTDatabase.h"
#import "FTDbManager.h"

@implementation FTDBModelUtil


/*********************************************************************
 函数名称 : getOneDbModelFromDBase
 函数描述 : 从查询的dabase获取一个dbmodel
 参数 :
 dbase : sql查询结果
 modelClass：创建的modelClass类型
 classInfo：字段信息
 返回值 :
 DbModel: 查询的数据的dbModel
 作者 :
 *********************************************************************/
+ (id)getOneDbModelFromDBase:(sqlite3_stmt *)stmt
                  modelClass:(Class)modelClass
                   classInfo:(FTClassInfo *)classInfo
{
    id model = [[modelClass alloc]init];
    
    //查询数据库获取总的字段数
    int columnCount = sqlite3_column_count(stmt);
    
    //依次取得每个字段数据
    for (int i = 0; i<columnCount ; i++)
    {
        //获取数据库中的字段名称
        char *fieldNameChar=(char *)sqlite3_column_name(stmt,i);
        NSString *fieldName = [NSString stringWithUTF8String:fieldNameChar];
        
        //获取classInfo中该字段名称的字段模型
        FTFieldInfo *fieldInfo = [classInfo obtainFieldInfoForFieldName:fieldName];
        
        id fieldValue = nil;
        if (fieldInfo)
        {
            //获取该字段的数据库值
            switch (fieldInfo.fieldType) {
                case eDOUBLE:
                case eFLOAT:
                case eLONG:
                {
                    //double类型、float类型、long类型
                    double fieldValueDouble = sqlite3_column_double(stmt,i);
                    fieldValue = [NSNumber numberWithDouble:fieldValueDouble];
                }
                    break;
                case eINT:
                case eSHORT:
                {
                    //int类型或者Short类型
                    int fieldValueInt = sqlite3_column_int(stmt,i);
                    fieldValue = [NSNumber numberWithInt:fieldValueInt];
                }
                    break;
                case eNSSTRING:
                {
                    //NSString类型
                    char *fieldValueChar=(char *)sqlite3_column_text(stmt,i);
                    if(fieldValueChar!=nil)
                    {
                        NSString *fieldValueStr = [[NSString alloc]initWithUTF8String:fieldValueChar];
                        fieldValue = fieldValueStr;
                    }
                }
                    break;
                default:
                {
                    //NSString类型
                    char *fieldValueChar=(char *)sqlite3_column_text(stmt,i);
                    if(fieldValueChar!=nil)
                    {
                        NSString *fieldValueStr = [[NSString alloc]initWithUTF8String:fieldValueChar];
                        fieldValue = fieldValueStr;
                    }
                }
                    break;
            }
        }
        else
        {
            FTDLog(@"*****Orm未发现Class属性字段：%@",fieldName);
        }
        
        //将获取到的值存入到字段模型中
        if (fieldValue)
        {
            [model setValue:fieldValue forKey:fieldInfo.fieldName];
        }
    }
    return model;
}

/*********************************************************************
 函数名称 : getOneDicFromDBase
 函数描述 : 从查询的dabase获取一个字典集合
 参数 :
 dbase : sql查询结果
 返回值 :
 NSMutableDictionary: 查询的数据的字典  数据全部是NSString  key：filedName value:(NSString *)fieldValue
 作者 :
 *********************************************************************/
+ (NSMutableDictionary *)getOneDicFromDBase:(sqlite3_stmt *)stmt
{
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc]init];
    
    //查询数据库获取总的字段数
    int columnCount = sqlite3_column_count(stmt);
    
    //依次取得每个字段数据
    for (int i = 0; i<columnCount ; i++)
    {
        //获取数据库中的字段名称
        char *fieldNameChar=(char *)sqlite3_column_name(stmt,i);
        NSString *fieldName = [NSString stringWithUTF8String:fieldNameChar];
        
        //获取该字段数据NSString
        char *fieldValueChar=(char *)sqlite3_column_text(stmt,i);
        if(fieldValueChar!=nil)
        {
            NSString *fieldValueStr = [[NSString alloc]initWithUTF8String:fieldValueChar];
            
            //将获取到的值存入到字典中
            if (fieldName.length > 0 ) {
                [resultDic setValue:fieldValueStr forKey:fieldName];
            }
        }
    }
    return resultDic;
}

/*********************************************************************
 函数名称 : obtainObjectValidValue
 函数描述 : 获取目标类的有效字段，存入字典
 参数 :
 object : 有效NSObject对象
 fieldInfoArray：对应的字段信息数组
 isFilterDefalut :是否过滤掉无效值，YES：过滤掉无效值，NO，不过滤无效值
 返回值 :
 NSMutableDictionary: 有用的字段字典 key：字段名称  value： 字段值
 作者 :
 *********************************************************************/
+ (NSMutableDictionary *)obtainObjectValidValue:(NSObject *)object
                                 fieldInfoArray:(NSMutableArray *)fieldInfoArray
                                isFilterDefalut:(BOOL)isFilterDefalut
{
    //有效字段字典
    NSMutableDictionary *validFieldDic = [[NSMutableDictionary alloc]init];
    
    if (object && fieldInfoArray.count > 0)
    {
        for (FTFieldInfo *fieldInfo in fieldInfoArray)
        {
            //获取字段值
            id fieldValue = [object valueForKey:fieldInfo.fieldName];
            
            //需要过滤无效值
            if (isFilterDefalut)
            {
                //判断该类型是有效
                if ([self isValidForFieldValue:fieldValue fieldType:fieldInfo.fieldType])
                {
                    //获取dbmodel中这个字段的值
                    NSString *fieldValueStr = [[NSString alloc]initWithFormat:@"%@",fieldValue];
                    
                    //将值存入字典
                    if (fieldInfo.fieldName.length > 0 ) {
                        [validFieldDic setValue:fieldValueStr forKey:fieldInfo.fieldName];
                    }
                }
            }
            else
            {
                //不需要过滤无效值，直接获取dbmodel中这个字段的值
                NSString *fieldValueStr = [[NSString alloc]initWithFormat:@"%@",fieldValue];
                
                //将值存入字典
                if (fieldInfo.fieldName.length > 0 ) {
                    [validFieldDic setValue:fieldValueStr forKey:fieldInfo.fieldName];
                }
            }
        }
    }
    else
    {
        FTDLog(@"error: object不存在！或传入属性数组不存在！");
    }

    return validFieldDic;
}

/**
*  获取目标对象的值字典，以键值对保存到字典返回,不过滤无效值
*
*  @param object NSObject目标对象
*
*  @return 存放有效字段的字典
*/
+ (NSMutableDictionary *)obtainPropMap:(NSObject *)object dbName:(NSString *)dbName
{
    //获取一个DB
    FTDatabase *db = [FTDbManager getInstance:dbName];
      //获取该类型的属性
    FTClassInfo *classInfo = [db obtainClassInfoFromDic:object.class];
    
    NSMutableDictionary *fieldDic = [FTDBModelUtil obtainObjectValidValue:object
                                                         fieldInfoArray:classInfo.mFieldArray
                                                        isFilterDefalut:NO];
    return fieldDic;
}


/*********************************************************************
 函数名称 : obtainModelClassStr
 函数描述 : 获取传入model的类型字符串
 参数 :
 model : 数据模型
 返回值 :
 NSString: 返回模型类型字符串 eg: Ctripcity
 作者 :
 *********************************************************************/
+ (NSString *)obtainModelClassStr:(NSObject *)model
{
    NSString *classStr = NSStringFromClass(model.class);
    return classStr;
}

/*********************************************************************
 函数名称 : isValidForFieldValue
 函数描述 : 判断字段值是否有效
 函数说明 : 判断标准，如果是基础类型，则判断是否为其默认值0，如果是对象，则判断对象是否为空
 参数 :
 fieldValue : 字段值 id类类型，基础类型用NSNumber
 type : 字段类型
 返回值 : BOOL  YES:字段有效   NO:字段无效
 作者 :
 *********************************************************************/
+(BOOL)isValidForFieldValue:(id)fieldValue
                  fieldType:(eTypeOfProperty)type
{
    int result = NO;
    
    if (fieldValue)
    {
        switch (type)
        {
            case eDOUBLE:
            case eFLOAT:
            case eLONG:
            case eINT:
            case eSHORT:
            {
                NSNumber *value = fieldValue;
                if (![value isEqualToNumber:[NSNumber numberWithInt:0]])
                {
                    //如果是基础类型，并且不为0，值有效
                    result = YES;
                }
            }
                break;
            case eNSSTRING:
            {
                NSString *valueStr = fieldValue;
                if (notEmptyStr(valueStr))
                {
                    //字段值存在，值有效
                    result = YES;
                }
            }
                break;
            default:
                break;
        }
        
    }
    
    return result;
}

/*********************************************************************
 函数名称 : obtainFieldValueStrForModel
 函数描述 : 根据传入的字段属性获取该字段值,转化为String输出
 参数 :
 model : 有效数据模型
 fieldInfo : 字段属性
 返回值 :
 NSString :字段值
 作者 :
 *********************************************************************/
+(NSString *)obtainFieldValueStrForModel:(NSObject *)model
                               fieldInfo:(FTFieldInfo *)fieldInfo
{
    NSString *fieldValueStr = nil;
    //获取dbmodel中这个字段的值
    switch (fieldInfo.fieldType) {
        case eDOUBLE:
        case eFLOAT:
        case eLONG:
        case eINT:
        case eSHORT:
        {
            //这些类型以NSNumber获取
            NSNumber *fieldValueNumber = [model valueForKey:fieldInfo.fieldName];
            fieldValueStr = [[NSString alloc]initWithFormat:@"%@",fieldValueNumber];
        }
            break;
        case eNSSTRING:
        {
            //NSString类型
            fieldValueStr = [model valueForKey:fieldInfo.fieldName];
        }
            break;
        default:
            break;
    }
    return fieldValueStr;
}




@end




