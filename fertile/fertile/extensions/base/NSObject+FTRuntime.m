//
//  NSObject+FTRuntime.m
//  fertile
//
//  Created by vincent on 16/5/16.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSObject+FTRuntime.h"

#import <objc/runtime.h>

@implementation NSObject (FTRuntime)

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
