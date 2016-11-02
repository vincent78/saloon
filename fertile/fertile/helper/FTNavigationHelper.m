//
//  FTRouteHelper.m
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTNavigationHelper.h"

@interface FTNavigationHelper()
{
    UINavigationController *rootNavigationController;
    UINavigationController *currNav;
    FTNavigateControllerModel *currModel;
    NSMutableDictionary *navDic;
}

@end

@implementation FTNavigationHelper

#pragma mark - single

static FTNavigationHelper *sharedInstance = nil;

+(FTNavigationHelper *) sharedInstance
{    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTNavigationHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

-(void)helperInit
{
    [super helperInit];
    navDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [self setCurrNavByKey:@"root"];
}

-(void)helperRelease
{
    rootNavigationController = nil;
    currNav = nil;
    currModel = nil;

    [super helperRelease];
}

- (void)didReceiveMemoryWarning
{
    
}

#pragma mark - custom area

-(UINavigationController *) getCurrNav
{
    if (!currNav)
        [self helperInit];
    return currNav;
}

-(void) setCurrNavByKey:(NSString *)key
{
    FTNavigateControllerModel *model = [navDic objectForKey:key];
    if (!model)
    {
        model = [FTNavigateControllerModel new];
        model.key = key;
        model.parentKey = currModel?currModel.key:@"";
        [navDic setObjectForFT:model forKey:model.key];
    }
    
    currNav = model.nav;
    currModel = model;
}

-(void) pushWithClass:(Class)vcClass
{
    [currNav pushViewController:[vcClass new] animated:NO];
}

-(void) pushVC:(Class)vcClass
   withAnimate:(UIViewAnimateType) animateType
{
    //TODO：设置动画的效果
    [currNav pushViewController:[vcClass new]
                       animated:animateType == UIViewAnimateTypeNone ? NO :YES];
}


-(void) pushWithVC:(FTBaseViewController *)vc
{
    [currNav pushViewController:vc animated:NO];
}

-(void) pushWithVC:(FTBaseViewController *)vc
       withAnimate:(UIViewAnimateType) animateType
{
    //TODO:设置动画的效果
    [currNav pushViewController:vc animated:YES];
}


-(void) pop
{
    [currNav popViewControllerAnimated:NO];
}

-(void) popToVC:(FTBaseViewController *)vc
{
    [currNav popToViewController:vc animated:NO];
}

-(void) popToClass:(Class) vcClass
{
    for (FTBaseViewController *vc in currNav.viewControllers)
    {
        if ([vc isKindOfClass:vcClass])
        {
            [currNav popToViewController:vc animated:NO];
            return;
        }
    }
}

-(FTBaseViewController *) contain:(Class)vcClass
{
    if (!currNav)
        return nil;
    for (FTBaseViewController *vc in currNav.viewControllers)
    {
        if ([vc isKindOfClass:vcClass])
        {
            return vc;
        }
    }
    
    return nil;
}

-(FTBaseViewController *) contain:(Class)vcClass
        withNav:(UINavigationController *)nav
{
    if (!nav)
        return nil;
    
    for (FTBaseViewController *vc in nav.viewControllers)
    {
        if ([vc isKindOfClass:vcClass])
        {
            return vc;
        }
    }
    
    return nil;
}

-(FTBaseViewController *) getPreVC
{
    if (currNav
        && currNav.viewControllers
        && currNav.viewControllers.count >0)
    {
        return (FTBaseViewController *)currNav.viewControllers.lastObject;
    }
    else
    {
        return nil;
    }
    
}


@end
