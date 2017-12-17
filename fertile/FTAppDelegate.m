//
//  FTAppDelegate.m
//  fertile
//
//  Created by vincent on 2016/11/11.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTAppDelegate.h"

@implementation FTAppDelegate

+(void)load
{
    FTDLog(@"class load");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        FTDLog(@"FTAppDelegate init");
        [self initApplicationSignals];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//
    FTDLog(@"FTAppDelegate didFinishLaunchingWithOptions");
    [FTAppHelper sharedInstance];
    [self.applicationDidFinishLaunchingSignal sendNext:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [FTNavigationHelper sharedInstance].getCurrNav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self.applicationWillResignActiveSignal sendNext:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.applicationDidEnterBackgroundSignal sendNext:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self.applicationWillEnterForegroundSignal sendNext:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.applicationDidBecomeActiveSignal sendNext:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.applicationWillTerminateSignal sendNext:nil];
}

-(void) initApplicationSignals
{
    FTDLog(@"FTAppDelegate initApplicationSignals");
    self.applicationDidFinishLaunchingSignal = [RACSubject subject];
    self.applicationWillResignActiveSignal = [RACSubject subject];
    self.applicationDidEnterBackgroundSignal = [RACSubject subject];
    self.applicationWillEnterForegroundSignal = [RACSubject subject];
    self.applicationDidBecomeActiveSignal = [RACSubject subject];
    self.applicationWillTerminateSignal = [RACSubject subject];
    self.didReceiveMemoryWarningSignal = [RACSubject subject];
}


@end
