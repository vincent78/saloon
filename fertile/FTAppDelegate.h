//
//  FTAppDelegate.h
//  fertile
//
//  Created by vincent on 2016/11/11.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FTAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RACSubject *applicationDidFinishLaunchingSignal;

@property (strong, nonatomic) RACSubject *applicationWillResignActiveSignal;

@property (strong, nonatomic) RACSubject *applicationDidEnterBackgroundSignal;

@property (strong, nonatomic) RACSubject *applicationWillEnterForegroundSignal;

@property (strong, nonatomic) RACSubject *applicationDidBecomeActiveSignal;

@property (strong, nonatomic) RACSubject *applicationWillTerminateSignal;

@end
