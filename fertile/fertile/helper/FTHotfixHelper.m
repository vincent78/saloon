//
//  FTHotfixHelper.m
//  fertile_oc
//
//  Created by vincent on 15/11/18.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTHotfixHelper.h"
#import "JPEngine.h"
@interface FTHotfixHelper()
{
    NSMutableDictionary * aopDic;
}
@end

@implementation FTHotfixHelper

static FTHotfixHelper *sharedInstance = nil;

+(FTHotfixHelper *) sharedInstance
{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTHotfixHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

/**
 *  @brief  初始化
 */
- (void)helperInit
{
    aopDic = [NSMutableDictionary dictionary];
}
/**
 *  @brief  重置
 */
- (void)helperRelease
{
    if (aopDic)
    {
        [aopDic removeAllObjects];
        aopDic = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    
}

#pragma mark - custom area

/**
 *  @brief 添加新的AOP方法
 *
 *  @param className <#className description#>
 *  @param funcName  <#funcName description#>
 *  @param oper      <#oper description#>
 */
-(void) append:(NSString *)className
      withFunc:(NSString *)funcName
      withOper:(NSString *)oper
    withOption:(int)option
{
    NSMutableDictionary *funcDic = [aopDic objectForKey:className];
    if (!funcDic)
    {
        funcDic  = [NSMutableDictionary dictionary];
        [aopDic setObjectForFT:funcDic forKey:className];
    }
    
    NSMutableDictionary *objDic = [funcDic objectForKey:funcName];
    if (!objDic)
    {
        objDic = [NSMutableDictionary dictionary];
        [funcDic setObjectForFT:objDic forKey:funcName];
    }
    
    NSString *tokenKey = [NSString stringWithFormat:@"%@%d",@"token",option];
    id<AspectToken> token = [objDic objectForKey:tokenKey];
    if (!token)
    {
        AspectOptions aspectOption = AspectPositionAfter;
        if (option == 0)
        {
            aspectOption = AspectPositionAfter;
        }
        else if (option == 1)
        {
            aspectOption = AspectPositionInstead;
        }
        else if (option == 2)
        {
            aspectOption = AspectPositionBefore;
        }
        
        token = [ NSClassFromString(className) aspect_hookSelector:NSSelectorFromString(funcName)
                                                       withOptions:aspectOption
                                                        usingBlock:[self operBlock:oper]
                                                             error:NULL];
        [objDic setObjectForFT:token forKey:tokenKey];
    }
    
}


/**
 *  @brief 将AOP加载的方法解绑
 *
 *  @param className <#className description#>
 *  @param funcName  <#funcName description#>
 *  @param option    <#option description#>
 */
-(void) remove:(NSString *)className withFunc:(NSString *)funcName withOption:(int)option
{
    NSMutableDictionary *funcDic = [aopDic objectForKey:className];
    if (funcDic)
    {
        NSMutableDictionary *objDic = [funcDic objectForKey:funcName];
         NSString *tokenKey = [NSString stringWithFormat:@"%@%d",@"token",option];
        if (objDic )
        {
            id<AspectToken> token = [objDic objectForKey:tokenKey];
            if (token)
            {
                if ([token remove])
                {
                    [objDic removeObjectForKey:tokenKey];
                }
                
            }
        }
    }
}


-(id)operBlock:(NSString *)funcName
{
    return ^(id<AspectInfo> info){
        [self performSelector:NSSelectorFromString(funcName) withObject:info afterDelay:0];
    };
}



-(NSString *) getInstanceName:(id<AspectInfo>) info
{
    return [NSString stringWithUTF8String:object_getClassName([info instance])];
}



@end
