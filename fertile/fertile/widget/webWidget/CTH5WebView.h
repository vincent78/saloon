//
//  CTH5WebView.h
//  CTBusiness
//
//  Created by derick on 9/7/15.
//  Copyright (c) 2015 Ctrip. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kMaxRetryCheckBridgeJSTimes 10

@class CTRootViewController;

@interface CTH5WebView : UIWebView

@property (nonatomic, strong) NSTimer *checkBridgeJsTimer;
@property (nonatomic, assign) int retryCheckBridgeJsTimes;
@property (nonatomic, assign) int maxRetryCheckBridgeJsTimes;
@property (nonatomic, weak) CTRootViewController *viewController;
@property (nonatomic, assign) BOOL isBridgeSupport;
@property (nonatomic, assign) BOOL isFinishedLoadWebView;
@property (nonatomic, copy) NSString *webViewPageName;
@property (nonatomic, weak) id<UIWebViewDelegate> mDelegate;
@property (nonatomic, strong) NSMutableDictionary *pluginObjectsDict;

- (id)initWithFrame:(CGRect)frame;

- (void)cleanConnections;

- (void)loadRequestWithURL:(NSURL *)url;

- (void)callbackForWebViewAppear;

- (void)autoCheckHijackIfNeedWithRegEx:(NSString *)regEx;

- (void)recordInitTime:(NSString *)tag;

@end


@interface CTH5WebView(Private)

- (void)handleURLStringWithPlugin:(NSString *)string;
- (void)resetWebViewForMemoryWarningIfNeed;
- (void)reloadWebViewForMemoryWarningIfNeed;
- (void)logLoadPageFinishedIfNeed;
- (void)checkRequestURLForHybridPackages:(NSURL *)url;

@end
