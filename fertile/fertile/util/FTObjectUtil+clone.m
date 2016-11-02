//
//  FTObjectUtil+clone.m
//  fertile
//
//  Created by vincent on 16/5/10.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTObjectUtil+clone.h"

#import <objc/runtime.h>



NSArray *cloneArray(NSArray *inArr);
NSDictionary *cloneDictionary(NSDictionary *inDict);
id cloneObject(id inObj);

NSSet *cloneSet(NSSet *inSet) {
    if (![inSet isKindOfClass:[NSSet class]]) {
        return NULL;
    }
    
    NSArray *allValues = [inSet allObjects];
    NSArray *retArray = cloneArray(allValues);
    NSMutableSet *retSet = [NSMutableSet setWithArray:retArray];
    
    return retSet;
}

NSArray *cloneArray(NSArray *inArr) {
    if (![inArr isKindOfClass:[NSArray class]]) {
        return NULL;
    }
    
    NSMutableArray *retArr = [NSMutableArray array];
    
    for (id element in inArr) {
        id newObj = element;
        
        if ([element isKindOfClass:[NSObject class]]) {
            newObj = cloneObject(element);
        }
        else if ([element isKindOfClass:[NSArray class]]) {
            newObj = cloneArray(element);
        }
        else if ([element isKindOfClass:[NSDictionary class]]) {
            newObj = cloneDictionary(element);
        }
        else if ([element isKindOfClass:[NSSet class]])
            newObj = cloneSet(element);
        
        if (newObj != NULL) {
            [retArr addObject:newObj];
        }
    }
    
    
    return retArr;
}

NSDictionary *cloneDictionary(NSDictionary *inDict) {
    if (![inDict isKindOfClass:[NSDictionary class]]) {
        return NULL;
    }
    
    NSMutableDictionary *retDict = [NSMutableDictionary dictionary];
    NSArray *allKeys = [inDict allKeys];
    
    for (id aKey in allKeys) {
        id element = [inDict objectForKey:aKey];
        if (element == NULL) {
            continue;
        }
        
        id newObj = element;
        if ([element isKindOfClass:[NSObject class]]) {
            newObj = cloneObject(element);
        }
        else if ([element isKindOfClass:[NSArray class]]) {
            newObj = cloneArray(element);
        }
        else if ([element isKindOfClass:[NSDictionary class]]) {
            newObj = cloneDictionary(element);
        }
        else if ([element isKindOfClass:[NSSet class]])
            newObj = cloneSet(element);
        
        if (newObj != NULL) {
            [retDict setObjectForFT:newObj forKey:aKey];
        }
    }
    
    return retDict;
}

id cloneObject(id item) {
    Class cls = [item class];
    
    if (cls == NULL) {
        return NULL;
    }
    
    id cloneItem = [[cls alloc] init];
    
    while (cls != [NSObject class]) {
        
        unsigned int numberOfIvars = 0;
        Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
        
        if (ivars == NULL) {
            cls = class_getSuperclass(cls);
            continue;
        }
        
        for (const Ivar* p = ivars; p < ivars+numberOfIvars; p++) {
            
            Ivar const ivar = *p;
            const char *type = ivar_getTypeEncoding(ivar);
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            NSString *typeStr = [NSString stringWithUTF8String:type];
            
            if ([typeStr isEqualToString:@"*"]) {
                continue;
            }
            
            id oldValue = [item valueForKey:key];
            
            if(oldValue != nil){
                id newValue = oldValue;
                
                if ([typeStr hasPrefix:@"@\""] && typeStr.length > 3) {
                    
                    NSString *className = [typeStr substringWithRange:NSMakeRange(2, typeStr.length-3)];
                    
                    
                    if ([className isEqualToString:NSStringFromClass([NSString class])]) {
                        newValue = [oldValue copy];
                    }
                    else if ([className isEqualToString:NSStringFromClass([NSMutableString class])]) {
                        newValue = [oldValue mutableCopy];
                    }
                    else if ([oldValue isKindOfClass:[NSObject class]]) {
                        newValue = cloneObject(oldValue);
                    }
                    else if ([className isEqualToString:NSStringFromClass([NSArray class])]||[className isEqualToString:NSStringFromClass([NSMutableArray class])]) {
                        newValue = cloneArray(oldValue);
                    }
                    else if ([className isEqualToString:NSStringFromClass([NSDictionary class])]||[className isEqualToString:NSStringFromClass([NSMutableDictionary class])]) {
                        newValue = cloneDictionary(oldValue);
                    }
                    else if ([className isEqualToString:NSStringFromClass([NSSet class])]||[className isEqualToString:NSStringFromClass([NSMutableSet class])]) {
                        newValue = cloneSet(oldValue);
                    }
                    else {
                        FTDLog(@"Error: unsupport class type==%@, member==%@", className, key);
                    }
                }
                
                if (newValue != NULL) {
                    [cloneItem setValue:newValue forKey:key];
                }
            }
        }
        
        cls = class_getSuperclass(cls);
        free(ivars);
    }
    
    return cloneItem;
    
}



@implementation FTObjectUtil (clone)

+(id)cloneObj:(id)item {
    return cloneObject(item);
}

@end
