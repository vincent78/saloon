/*********************************************************************
 文件名称 : ClassInfo.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 类字段数据信息类（当是表的对应的时候，需要传入表主键）
 *********************************************************************/

#import "FTClassInfo.h"

#import "FTFieldInfo.h"
#import "FTPropertyUtil.h"
#import "DBStringUtil.h"
#import <objc/message.h>

@implementation FTClassInfo
@synthesize mFieldArray;
@synthesize mTableName;
@synthesize mModelType;
@synthesize mPrimarykeyName;

#pragma mark -- init

- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

/*********************************************************************
 函数名称 : initWithDBmodel:tableName
 函数描述 : 初始化
 参数 :
 objectClass: 表名
 返回值 : id
 作者 :
 *********************************************************************/
-(id)initWithObjClass:(Class)objectClass
{
    if (self = [self init])
    {
        if (!objectClass)
        {
            FTLog(@"error---- the objectClass is null! ");
            return nil;
        }
        
        //存入Class
        self.mModelType = &(objectClass);
        
        //初始化一个该对象
        NSObject *obj = [[objectClass alloc]init];
        
        //存在获取表名方法
        SEL obtainTableNameStr = NSSelectorFromString(@"obtainTableNameStr");
        if ([obj respondsToSelector:obtainTableNameStr])
        {
            //获取表名，存入数组
            self.mTableName = (NSString *)objc_msgSend(obj, obtainTableNameStr);
        }
        
        //存在获取关键字名方法
        SEL obtainPrimaryKeyStr = NSSelectorFromString(@"obtainPrimaryKeyStr");
        if ([obj respondsToSelector:obtainPrimaryKeyStr])
        {
            //获取关键字字段名，存入数组
            self.mPrimarykeyName = (NSString *)objc_msgSend(obj, obtainPrimaryKeyStr);
        }
        
        NSMutableArray *noPersistenceArray = nil;
        //存在获取非持久化字段数组
        SEL obtainNoPersistenceArray = NSSelectorFromString(@"obtainNoPersistenceArray");
        if ([obj respondsToSelector:obtainNoPersistenceArray])
        {
            //获取非持久化字段数组
            noPersistenceArray = [(NSArray *)objc_msgSend(obj, obtainNoPersistenceArray) mutableCopy];
        }
        
        //获取所有属性到数组
        if (![DBStringUtil emptyOrNull:self.mPrimarykeyName])
        {
            //有主键
            self.mFieldArray = [FTPropertyUtil obtainObjClassFieldsToArray:objectClass excludeFieldArr:noPersistenceArray primarykeyName:self.mPrimarykeyName];
        }
        else
        {
            //无主键
            self.mFieldArray = [FTPropertyUtil obtainObjClassFieldsToArray:objectClass excludeFieldArr:noPersistenceArray];
        }
        
        obj = nil;
    }
    return self;
}

/*********************************************************************
 函数名称 : obtainPrimaryKeyFieldInfo
 函数描述 : 获取表信息中主键字段模型
 参数 :
 dbmodel : 数据模型
 返回值 :
 FieldInfo : 字段属性
 作者 :
 *********************************************************************/
-(FTFieldInfo *)obtainPrimaryKeyFieldInfo
{
    FTFieldInfo *fieldInfo = nil;
    
    //如果主键存在
    if (![DBStringUtil emptyOrNull:self.mPrimarykeyName])
    {
        //主键默认放在数组第一个
        if (self.mFieldArray.count > 0)
        {
            fieldInfo = [self.mFieldArray objectAtIndex:0];
        }
        else
        {
            FTLog(@"Error --- get PrimaryKey TabaleInfo error ,can not is null");
        }
    }
    
    return fieldInfo;
}

/*********************************************************************
 函数名称 : obtainFieldInfoForFieldName
 函数描述 : 根据字段名称获取表信息中字段模型
 参数 :
 fieldName : 字段名称
 返回值 :
 FieldInfo : 字段属性
 作者 :
 *********************************************************************/
-(FTFieldInfo *)obtainFieldInfoForFieldName:(NSString *)fieldName
{
    FTFieldInfo *fieldInfo = nil;
    
    if (![DBStringUtil emptyOrNull:fieldName])
    {
        //轮循查找fieldName同名的FieldInfo
        for (FTFieldInfo *obj in self.mFieldArray)
        {
            //比较字符串是否相同，不区分大小写
            BOOL isEqual = ([obj.fieldName compare:fieldName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame);
            if (isEqual)
            {
                fieldInfo = obj;
                break;
            }
        }
    }
    else
    {
        FTLog(@"error -- fieldName 不能为空！");
    }
    
    return fieldInfo;
}

@end
