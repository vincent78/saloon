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
    
    FTAppDelegate *appDelegate = (FTAppDelegate *) [[UIApplication sharedApplication] delegate];
    [self subscribeAppDelegateSingals:appDelegate];
    
    
    self.printAppInfoSingal = [RACSubject subject];
    [self subscribeHelperSingals];
    
}

-(void)helperRelease
{
    for (int i= ((int)helperArray.count -1); i>=0; i--) {
        FTBaseHelper *helper = [helperArray objectAtIndex:i];
        [helper helperRelease];
        helper = nil;
    }
    self.appDic = nil;
}



- (void)didReceiveMemoryWarning
{
}



#pragma mark - 订阅signals

/**
 订阅appDelegate的signal

 @param appDelegate <#appDelegate description#>
 */
-(void) subscribeAppDelegateSingals:(FTAppDelegate *)appDelegate
{
    WS(weakSelf)
    [appDelegate.applicationDidFinishLaunchingSignal subscribeNext:^(NSDictionary *launchOptions) {
        if (launchOptions)
        {
            FTDLog(@"launchOptions:%@",[launchOptions yy_modelToJSONString]);
        }
        FTDLog(@"%@:didFinishLaunchingSignal",NSStringFromClass(self.class));
        
        [weakSelf.printAppInfoSingal sendNext:nil];
    }];
    
    [appDelegate.applicationWillTerminateSignal subscribeNext:^(id x) {
        [weakSelf helperRelease];
    }];
    
    [appDelegate.didReceiveMemoryWarningSignal subscribeNext:^(id x) {
        [weakSelf didReceiveMemoryWarning];
    }];
}

/**
 订阅本类内的signal
 */
-(void) subscribeHelperSingals
{
    [self.printAppInfoSingal subscribeNext:^(id x) {
       
        FTDLog(@"\n%@\ndocPath:\n%@\n\ndeviceInfo:\n%@\n\n%@\n\nappInfo:\n%@\n%@"
               ,@"==================="
               ,[FTFileUtil getDocDirectory]
               ,[FTDeviceHelper getDeviceInfo]
               ,[NSString stringWithFormat:@"screenWidth: %.2f  screenHeight: %.2f scale:%.2f"
                 ,[FTSystemHelper screenWidth]
                 ,[FTSystemHelper screenHeight]
                 ,[FTSystemHelper scale]]
               ,[FTAppHelper getVersion]
               ,@"===================");
    }];
}


#pragma mark - 其它操作

/**
 初始化其它Helper
 */
-(void) initOtherHelpers
{
    helperArray = [NSMutableArray arrayWithCapacity:5];
    [helperArray addObject:[FTLoggerHelper sharedInstance]];
    [helperArray addObject:[FTHotfixHelper sharedInstance]];
    [helperArray addObject:[FTDeviceHelper sharedInstance]];
    [helperArray addObject:[FTSystemHelper sharedInstance]];
    [helperArray addObject:[FTNavigationHelper sharedInstance]];
    [helperArray addObject:[FTThreadHelper sharedInstance]];
    [helperArray addObject:[FTNetWorkHelper sharedInstance]];
    [helperArray addObject:[FTAnimateHelper sharedInstance]];

}

#pragma mark  navigate

-(FTNavigateWidget *)getNavWidget
{
    FTNavigateWidget * navWidget ;
    if (self.delegate)
    {
        navWidget = [self.delegate prepareNavigateBar];
    }
    else
    {
        navWidget = [[FTNavigateWidget alloc] initWithFrame:CGRectMake(0,0,[FTSystemHelper screenWidth],[FTSystemHelper navBarHeight])];
    }
    return navWidget;
}


#pragma mark  APP字体
+(UIFont *) defaultFont:(CGFloat)size
{
    return [UIFont systemFontOfSize:size];
}

+(UIFont *) defaultBoldFont:(CGFloat)size
{
    return [UIFont boldSystemFontOfSize:size];
}

#pragma mark  APP的信息

+(NSDictionary *) bundleInfo
{
    return [[NSBundle mainBundle] infoDictionary];
}

+(NSString *) getVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(BOOL) isDebug
{
#if defined(DEBUG)||defined(_DEBUG)
    return true;
#endif
    return false;
}


/**
 获取当前屏幕显示的viewcontroller

 @return <#return value description#>
 */
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


/**
 获取当前屏幕中present出来的viewcontroller

 @return <#return value description#>
 */
- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}


@end
