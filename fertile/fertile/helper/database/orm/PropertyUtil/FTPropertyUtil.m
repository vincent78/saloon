/*********************************************************************
 文件名称 : PropertyUtil.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 类属性操作类
 *********************************************************************/

#import "FTPropertyUtil.h"
#import <objc/message.h>
#import "FTFieldInfo.h"

@implementation FTPropertyUtil

/*********************************************************************
 函数名称 : obtainObjClassFieldsToArray
 函数描述 : 获取objectClass类的所有属性保存到数组
 参数 :
 objectClass : 目标类
 noPersistFieldArray : 不需要持久化字段的数组，不存入到返回结果中,存放NSString
 返回值 :
 NSMutableArray : 返回属性数组，存放类型为FieldInfo
 作者 :
 *********************************************************************/
+(NSMutableArray *)obtainObjClassFieldsToArray:(Class)objectClass
                               excludeFieldArr:(NSMutableArray *)noPersistFieldArray
{
    //创建属性数组
    NSMutableArray *propertArray = [self obtainObjClassFieldsToArray:objectClass excludeFieldArr:noPersistFieldArray primarykeyName:nil];
    
    return propertArray;
}

/*********************************************************************
 函数名称 : obtainObjClassFieldsToArray
 函数描述 : 获取objectClass类的所有属性保存到数组,如果有主键，则主键放到数组第一个的位置
 参数 :
 objectClass : 目标类
 noPersistFieldArray : 不需要持久化字段的数组，不存入到返回结果中,存放NSString
 primaryName : 主键名称
 返回值 :
 NSMutableArray : 返回属性数组，存放类型为FieldInfo
 作者 :
 *********************************************************************/
+(NSMutableArray *)obtainObjClassFieldsToArray:(Class)objectClass
                               excludeFieldArr:(NSMutableArray *)noPersistFieldArray
                                primarykeyName:(NSString *)primaryName
{    
    unsigned int count;
    //获取所有的字段列表，存入字典中
    objc_property_t* properties = class_copyPropertyList(objectClass, &count);
    
    //创建属性数组
    NSMutableArray *propertArray = [[NSMutableArray alloc]initWithCapacity:count];
    
    //深度搜索，搜索到NSObject下的所有父类
    if (objectClass == [NSObject class])
    {
        return nil;
    }
    else
    {
        //递归查找父类的属性
        Class theSuperClass = [objectClass superclass];
        if (theSuperClass != [NSObject class])
        {
            NSMutableArray *parentArray = [self obtainObjClassFieldsToArray:theSuperClass
                                                            excludeFieldArr:nil];
            [propertArray addObjectsFromArray:parentArray];
        }
    }
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t property = properties[i];
        
        //获取字段model
        FTFieldInfo *fieldInfo = [self analyseProperty:property];
        
        //判断是不需要持久化化的字段
        BOOL isInNoPersist = NO;
        if (noPersistFieldArray.count > 0)
        {
            for (NSString *nopersistStr in noPersistFieldArray)
            {
                if ([fieldInfo.fieldName isEqualToString:nopersistStr])
                {
                    isInNoPersist = YES;
                    break;
                }
            }
        }
        
        //如果当前字段是不需要持久化的字段，则跳过本字段的存储
        if(isInNoPersist)
        {
            continue;
        }
        
        //当主键存在，且不是第一个，当前字段等于主键时，交换主键和第一个obj的位置
        if (primaryName && i != 0 && [fieldInfo.fieldName isEqualToString:primaryName])
        {
            //主键字段模型存入数组第一个
            [propertArray insertObject:fieldInfo atIndex:0];
        }
        else
        {
            //字段模型存入数组
            if (fieldInfo != NULL) {
                [propertArray addObject:fieldInfo];
            }
        }
    }

    if (properties)
    {
        free(properties);
    }
    
    return propertArray;
}

/*********************************************************************
 函数名称 : analyseProperty
 函数描述 : 分析字段属性pProperty，返回字段模型FieldInfo
 参数 :
 pProperty : 字读属性
 返回值 :
 FieldInfo : 字段模型
 作者 :
 *********************************************************************/
+ (FTFieldInfo *)analyseProperty:(objc_property_t)pProperty
{
    //获取属性名称
    NSString *propertyName = [NSString stringWithUTF8String:property_getName(pProperty)];
    //属性描述
    NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(pProperty)];
    //获取属性类型
    eTypeOfProperty typeOfProperty = eNIL;
    NSArray *array = [propertyAttributes componentsSeparatedByString:@","];
    NSString *typeAtt = [[array objectAtIndex:0]lowercaseString];
    if ([typeAtt hasPrefix:@"td"])
    {
        typeOfProperty = eDOUBLE;
    } else if ([typeAtt hasPrefix:@"ti"])
    {
        typeOfProperty = eINT;
    } else if ([typeAtt hasPrefix:@"tf"])
    {
        typeOfProperty = eFLOAT;
    } else if ([typeAtt hasPrefix:@"tl"])
    {
        typeOfProperty = eLONG;
    } else if ([typeAtt hasPrefix:@"ts"])
    {
        typeOfProperty = eSHORT;
    } else if ([typeAtt hasPrefix:@"t@"])
    {
        //是对象
        if ([typeAtt length] > 4)
        {
            //截取对象类型
            Class class = NSClassFromString([typeAtt substringWithRange:NSMakeRange(3, [typeAtt length] - 4)]);
            if ([class isSubclassOfClass:[NSString class]])
            {
                typeOfProperty = eNSSTRING;
            }
        }
    }
    
    //初始化一个字段模型并赋值
    FTFieldInfo *fieldInfo = [[FTFieldInfo alloc]init];
    fieldInfo.fieldName = propertyName;
    fieldInfo.fieldType = typeOfProperty;
    
    return fieldInfo;
}


@end
