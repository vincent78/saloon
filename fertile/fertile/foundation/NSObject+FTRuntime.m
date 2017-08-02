//
//  NSObject+FTRuntime.m
//  fertile
//
//  Created by vincent on 16/5/16.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSObject+FTRuntime.h"

#import <objc/runtime.h>

static NSString * FL_OBJECT_ASS_KEY = @"com.vincent.OBJECTS";


@implementation NSObject (FTRuntime)


- (id) ftObjInfo {
    id ret = objc_getAssociatedObject(self, (__bridge const void *)FL_OBJECT_ASS_KEY) ;
    return ret ;
}

- (void) setFtObjInfo:(id)ftInfo {
    objc_setAssociatedObject(self, (__bridge const void *)FL_OBJECT_ASS_KEY, ftInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//
//
//-(id) getPropertyValueByName:(NSString *)key
//{
//    if ([NSString emptyOrNull:key])
//    {
//        return nil;
//    }
//    __block id tmpObj = self;
//    NSArray *properties = [key componentsSeparatedByString:@"."];
//    [properties bk_each:^(id  _Nonnull obj) {
//        if (tmpObj)
//        {
//            tmpObj = [tmpObj valueForKey:(NSString *)obj];
//        }
//    }];
//    return tmpObj;
//}
//
//
//
//
//-(void) setPropertyByName:(NSString *)name withValue:(id)value
//{
//    if ([StringUtil emptyOrNull:name])
//    {
//        return ;
//    }
//    
//    
//    if (value)
//    {
//        if( [value respondsToSelector:@selector(mutableCopyWithZone:)])
//        {
//            value = [value mutableCopy];
//        }
//        else if ([value respondsToSelector:@selector(copyWithZone:)])
//        {
//            value = [value copy];
//        }
//    }
//    
//    
//    
//    __block id tmpObj = self;
//    NSString *propertyName = @"";
//    NSMutableArray *properties = [[name componentsSeparatedByString:@"."] mutableCopy];
//    propertyName = [properties lastObject];
//    [properties removeLastObject];
//    [properties bk_each:^(id  _Nonnull obj) {
//        if (tmpObj)
//        {
//            tmpObj = [tmpObj valueForKey:(NSString *)obj];
//        }
//    }];
//    
//    if (tmpObj)
//    {
//        SEL seletor = NSSelectorFromString(propertyName);
//        if ([tmpObj respondsToSelector:seletor])
//        {
//            [tmpObj setValue:value forKey:propertyName];
//        }
//    }
//}
//
//-(BOOL) propertyExist:(NSString *)name
//{
//    BOOL exist = NO;
//    unsigned int outCount = 0;
//    //获取到所有的成员变量列表
//    //遍历所有的成员变量
//    
//    Class cls = [self class];
//    while (cls != [NSObject class])
//    {
//        
//        Ivar *vars = class_copyIvarList(cls, &outCount);
//        if(vars == NULL)
//        {
//            cls = class_getSuperclass(cls);
//            continue;
//        }
//        
//        for (int i =0;i<outCount;i++)
//        {
//            Ivar ivar = vars[i];
//            const char *propertyName = ivar_getName(ivar);
//            NSString *tmpName = [[NSString alloc] initWithCString:propertyName encoding:NSASCIIStringEncoding];
//            tmpName = [tmpName substringFromIndex:1];
//            if ([tmpName isEqualToString:name])
//            {
//                return YES;
//            }
//        }
//        
//        cls = class_getSuperclass(cls);
//        
//    }
//    
//    
//    return exist;
//}
//
//
//-(void) save:(NSString *)sourceName nextCacheBean:(CTCacheBean *)nextCacheBean
//          to:(NSString *)targetName type:(CTPropertySaveType) type
//    required:(Boolean)required
//{
//    if ([self propertyExist:sourceName])
//    {
//        id value = [self getPropertyValueByName:sourceName];
//        
//        switch (type) {
//            case CTPropertySaveTypeRetain:
//                [self retainPropertyByName:targetName withValue:value nextCacheBean:nextCacheBean required:required];
//                break;
//            case CTPropertySaveTypeCopy:
//                [self copyPropertyWithName:targetName withValue:value nextCacheBean:nextCacheBean required:required];
//                break;
//            default:
//                [self retainPropertyByName:targetName withValue:value nextCacheBean:nextCacheBean required:required];
//                break;
//        }
//    }
//}
//
//
//-(void) setValueToObj:(NSString *)name withValue:(id)value nextCacheBean:(CTCacheBean *)nextCacheBean
//{
//    Class    sourceOjbectClass = [self class];
//    id       targetObject      = nextCacheBean;
//    id       parentObject      = nil;
//    NSArray *keyArray          = [name componentsSeparatedByString:@"."];
//    NSString *lastKey          = nil;
//    
//    for (int i = 0; i < keyArray.count; i++) {
//        NSString *levelKey = [keyArray objectAtIndexForCtrip:i];
//        if (levelKey.length > 0) {
//            objc_property_t childProperty = class_getProperty(sourceOjbectClass, [levelKey UTF8String]);
//            if (childProperty) {
//                if (targetObject && [targetObject propertyExist:levelKey]) {
//                    lastKey      = levelKey;
//                    parentObject = targetObject;
//                    targetObject = [targetObject valueForKey:levelKey];
//                    sourceOjbectClass = [value class];
//                }
//                else
//                {
//                    TLog(@"对象%@的属性%@，赋值为%@失败。父对象%@", nextCacheBean, name, value, parentObject);
//                }
//            }
//            else
//            {
//                TLog(@"对象%@的属性%@，赋值为%@失败。类%@无此信息%@", nextCacheBean, name,  value, sourceOjbectClass, levelKey);
//            }
//        }
//        else
//        {
//            //空字符跳过
//        }
//    }
//    
//    if (parentObject && lastKey.length > 0) {
//        [parentObject setValue:value forKey:lastKey];
//    }
//    
//}
//
//-(void) retainPropertyByName:(NSString *)name withValue:(id)value nextCacheBean:(CTCacheBean *)nextCacheBean required:(Boolean)required
//{
//    [self setValueToObj:name withValue:value nextCacheBean:nextCacheBean];
//}
//
//-(void) copyPropertyWithName:(NSString *)name withValue:(id)value nextCacheBean:(CTCacheBean *)nextCacheBean required:(Boolean)required
//{
//    SEL copySelector = NULL;
//    NSString *className = @"";
//    if(value)
//    {
//        className =  NSStringFromClass([value class]);
//    }
//    
//    copySelector = @selector(mutableCopyWithZone:);
//    
//    
//    if ([value respondsToSelector:@selector(mutableCopyWithZone:)])
//    {
//        [self setValueToObj:name withValue:[value mutableCopy] nextCacheBean:nextCacheBean];
//    }
//    else if ([value respondsToSelector:@selector(copyWithZone:)])
//    {
//        [self setValueToObj:name withValue:[value copy] nextCacheBean:nextCacheBean];
//    }
//    else
//    {
//        
//        TLog(@"Save源数据不支持Copy，fromKey:%@ fromValue:%@\nFromCacheBean:%@ ToCacheBean:%@", name, value, NSStringFromClass([self class]), nextCacheBean);
//    }
//    
//}
//


- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}


- (NSDictionary *)getAllPropertiesAndValue
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}


-(NSArray *) getAllIvars:(NSString *)className
{
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(NSClassFromString(className), &numIvars);
    //Ivar *vars = class_copyIvarList([UIView class], &numIvars);
    NSMutableArray *ivarArray = [NSMutableArray arrayWithCapacity:1];
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        NSMutableDictionary *ivarDic = [NSMutableDictionary dictionaryWithCapacity:1];
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        NSLog(@"variable name :%@", key);
        [ivarDic setObjectForFT:key forKey:@"name"];
        key = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
        NSLog(@"variable type :%@", key);
        [ivarDic setObjectForFT:key forKey:@"type"];
        [ivarArray addObjectForFT:ivarDic];
        
    }
    free(vars);
    return ivarArray;
}

-(NSArray *) getAllIvars
{
    NSString *className = NSStringFromClass([self class]);
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(NSClassFromString(className), &numIvars);
    //Ivar *vars = class_copyIvarList([UIView class], &numIvars);
    NSMutableArray *ivarArray = [NSMutableArray arrayWithCapacity:1];
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        NSMutableDictionary *ivarDic = [NSMutableDictionary dictionaryWithCapacity:1];
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        NSLog(@"variable name :%@", key);
        [ivarDic setObjectForFT:key forKey:@"name"];
        key = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
        NSLog(@"variable type :%@", key);
        [ivarDic setObjectForFT:key forKey:@"type"];
        [ivarArray addObjectForFT:ivarDic];
        
    }
    free(vars);
    return ivarArray;
}

-(NSMutableArray *)getAllMethods
{
    unsigned int mothCout_f =0;
    NSMutableArray *methodArray = [NSMutableArray arrayWithCapacity:1];
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
        //        IMP imp_f = method_getImplementation(temp_f);
        //        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,[NSString stringWithUTF8String:encoding]);
        NSMutableDictionary *methodDic = [NSMutableDictionary dictionaryWithCapacity:1];
        [methodDic setObjectForFT:[NSString stringWithUTF8String:name_s] forKey:@"name"];
        [methodDic setObjectForFT:[NSNumber numberWithInt:arguments] forKey:@"paramNum"];
        [methodArray addObjectForFT:methodDic];
    }
    free(mothList_f);
    
    return methodArray;
}

@end
