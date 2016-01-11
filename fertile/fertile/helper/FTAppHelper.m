//
//  FTAppHelper.m
//  fertile_oc
//  
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTAppHelper.h"

@interface FTAppHelper()
{
    NSMutableArray *helperArray;
}

@end

@implementation FTAppHelper

#pragma mark - single

static FTAppHelper *sharedInstance = nil;

+(FTAppHelper *) sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTAppHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

-(void)helperInit
{
    [super helperInit];
    self.appDic = [[NSMutableDictionary alloc] init];
    
    self.vcBackGroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    
    helperArray = [NSMutableArray arrayWithCapacity:5];
    [helperArray addObject:[FTLoggerHelper sharedInstance]];
    [helperArray addObject:[FTHotfixHelper sharedInstance]];
    [helperArray addObject:[FTSystemHelper sharedInstance]];
    [helperArray addObject:[FTRouteHelper sharedInstance]];
    [helperArray addObject:[FTThreadHelper sharedInstance]];
    [helperArray addObject:[FTNetWorkHelper sharedInstance]];
    [helperArray addObject:[FTAnimateHelper sharedInstance]];
    
    
    NSString * path = [FTFileUtil getResFullPath:@"common" ofType:@"ttf" withFramework:@"fertile" ];
    [FTSystemHelper loadFont:path];
//    [FTSystemHelper printSysAllFontInfo];
//    NSLog(path,nil);
    
}

-(void)helperRelease
{
    if (self.delegate)
    {
        [self.delegate appRelease];
    }
    
    for (int i= ((int)helperArray.count -1); i>=0; i--) {
        FTBaseHelper *helper = [helperArray objectAtIndex:i];
        [helper helperRelease];
    }
    
    self.appDic = nil;
}

- (void)helper:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    for(FTBaseHelper *helper in helperArray)
    {
        if ([helper respondsToSelector:@selector(helper:didFinishLaunchingWithOptions:)])
            [helper helper:application didFinishLaunchingWithOptions:launchOptions];
    }
    

}

- (void)helperWillResignActive:(UIApplication*)application
{
    for(FTBaseHelper *helper in helperArray)
    {
        if ([helper respondsToSelector:@selector(helperWillResignActive:)])
            [helper helperWillResignActive:application];
    }
}

- (void)helperDidEnterBackground:(UIApplication*)application
{
    for(FTBaseHelper *helper in helperArray)
    {
        if ([helper respondsToSelector:@selector(helperDidEnterBackground:)])
            [helper helperDidEnterBackground:application];
    }
}


- (void)helperWillEnterForeground:(UIApplication*)application
{
    for(FTBaseHelper *helper in helperArray)
    {
        if ([helper respondsToSelector:@selector(helperWillEnterForeground:)])
            [helper helperWillEnterForeground:application];
    }
}

- (void)helperDidBecomeActive:(UIApplication*)application
{
    for(FTBaseHelper *helper in helperArray)
    {
        if ([helper respondsToSelector:@selector(helperDidBecomeActive:)])
            [helper helperDidBecomeActive:application];
    }
}

- (void)helperWillTerminate:(UIApplication*)application
{
    
    for(FTBaseHelper *helper in helperArray)
    {
        if ([helper respondsToSelector:@selector(helperWillTerminate:)])
            [helper helperWillTerminate:application];
    }
}

- (void)didReceiveMemoryWarning
{
    for(FTBaseHelper *helper in helperArray)
    {
        [helper didReceiveMemoryWarning];
    }
}

#pragma mark - navigate

-(FTNavigateWidget *)getNavWidget
{
    FTNavigateWidget * navWidget ;
    if (self.delegate)
    {
        [self.delegate appInit];
        navWidget = [self.delegate prepareNavigateBar];
    }
    else
    {
        navWidget = [[FTNavigateWidget alloc] initWithFrame:CGRectMake(0,0,[FTSystemHelper screenWidth],[FTSystemHelper navBarHeight])];
    }
    return navWidget;
}


#pragma mark - 系统字体


+(UIFont *) defaultFont:(CGFloat)size
{
    return [UIFont systemFontOfSize:size];
}

+(UIFont *) defaultBoldFont:(CGFloat)size
{
    return [UIFont boldSystemFontOfSize:size];
}




@end
