//
//  CTH5WebView+CTJSBridge.m
//  CTBusiness
//
//  Created by derick on 9/29/15.
//  Copyright © 2015 Ctrip. All rights reserved.
//

#import "CTH5WebView+CTJSBridge.h"
#import "CTGlobalMemoryCache.h"
#import "CTH5LogUtil.h"



@implementation CTH5WebView (CTJSBridge)

#pragma mark - CTJSBridge API
- (NSString *)executeJs:(NSString *)js
{
    if (js.length == 0) {
        return nil;
    }
    
    __block NSString *ret = nil;
    
    if (![NSThread currentThread].isMainThread) {
        __block BOOL isFinishedExecuteJS = NO;
        __weak CTH5WebView *weakSelf = (id)self;
        runBlockInMainThread(^{
            ret = [weakSelf tryExecuteJs:js];
            isFinishedExecuteJS = YES;
        });
        
        while (!isFinishedExecuteJS) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    } else {
        ret = [self tryExecuteJs:js];
    }

    H5Log(js, ret);
    return ret;
}

- (NSString *)callBackH5WithTagName:(NSString *)tagName param:(NSObject*)param
{
    if (![self isLegalCtripURL] || ![self isBridgeSupport]) {
        return nil;
    }
    
    NSString *jsRet = nil;
    
    if (tagName.length > 0) {
        NSMutableDictionary *jsonDict = [NSMutableDictionary dictionary];
        [jsonDict setSafeObject:tagName forKey:@"tagname"];
        
        if (param != NULL) {
            [jsonDict setSafeObject:param forKey:@"param"];
        }
        
        NSString *jsParam = [jsonDict JSONStringForCtrip];
        if (jsParam.length > 0) {
            NSString *js = [CTH5Global makeBridgeCallbackJSString:jsParam];
            jsRet = [self executeJs:js];
        }
    }
    return jsRet;
}


#pragma mark - ---- webView加载完成事件

- (void)resetBridgeJSChecker {
    self.retryCheckBridgeJsTimes = 0;
    self.isBridgeSupport = NO;
    [self.checkBridgeJsTimer invalidate];
    self.checkBridgeJsTimer = nil;
}

- (void)callbackForWebViewLoadFinished {
    NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    userDict[@"version"] = getAppVersion();
    userDict[@"platform"] = [NSNumber numberWithInt:1];
    userDict[@"osVersion"] = [NSString stringWithFormat:@"iOS_%@", [UIDevice currentDevice].systemVersion];
    userDict[@"extSouceID"] = [[CTGlobalMemoryCache getInstance] getValidExtSourceStr];
    [self callBackH5WithTagName:@"web_view_finished_load" param:userDict];
}

- (void)autoCheckBridgeJS {
    if ([self isLegalCtripURL]) {
        [self checkBridgeJSTimerAction:NULL];
        if (!self.isBridgeSupport) {
            [self.checkBridgeJsTimer invalidate];
            self.checkBridgeJsTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                         target:self
                                                                       selector:@selector(checkBridgeJSTimerAction:)
                                                                       userInfo:nil
                                                                        repeats:YES];
        }
    }
}

- (void)checkBridgeJSIsSupport {
    if (!self.isBridgeSupport) {
        NSString *js = @"(window.app!=undefined)&&(window.app.callback!=undefined)";
        NSString *obj = (id)[self executeJs:js];
        NSString *log = [NSString stringWithFormat:@"h5_check window.app.callback ==%@", obj];
        H5Log(log,nil);
        self.isBridgeSupport = [obj boolValue];
    }
}

- (void)checkBridgeJSTimerAction:(NSTimer *)timer {
    self.retryCheckBridgeJsTimes++;
    [self checkBridgeJSIsSupport];

    if (self.retryCheckBridgeJsTimes >= self.maxRetryCheckBridgeJsTimes || self.isBridgeSupport) {
        [self.checkBridgeJsTimer invalidate];
        self.checkBridgeJsTimer = NULL;
    }
    
    if (self.isBridgeSupport) {
        [self callbackForWebViewLoadFinished];
    }
}

#pragma mark - Internal Methods
- (NSString *)tryExecuteJs:(NSString *)js
{
    NSString *ret = nil;
    @try {
        ret = [self stringByEvaluatingJavaScriptFromString:js];
    } @catch(NSException *e) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setSafeObject:js forKey:@"js"];
        [dict setSafeObject:e.name forKey:@"name"];
        [dict setSafeObject:e.reason forKey:@"reason"];
        [dict setSafeObject:e.userInfo forKey:@"userInfo"];
        [CTLogUtil logTrace:@"o_exe_js_error" userInfo:dict];
    }
    
    return ret;
}

- (BOOL)isLegalCtripURL {
    if (isDevEnv()) {
        return YES;
    } else {
        NSURL *currentURL = self.request.URL;
        NSString *urlString = [currentURL.absoluteString lowercaseString];
        BOOL isLocalHTMLFile = [urlString hasPrefix:@"file://"];
        BOOL isDevURL = [urlString rangeOfString:@"http://10.2.57.11/"].location != NSNotFound;
        if (isLocalHTMLFile || [StringUtil isCtripURL:currentURL.host] || isDevURL) {
            return YES;
        }
        
        return NO;
        
    }
}
@end
