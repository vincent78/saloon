//
//  CTWebViewPreloader.m
//  CTBusiness
//
//  Created by derick on 11/23/15.
//  Copyright © 2015 Ctrip. All rights reserved.
//

#import "CTWebViewPreloader.h"
#import "CTH5WebView.h"

@interface CTWebViewPreloader () <UIWebViewDelegate>
@property (nonatomic, strong) NSMutableArray *webViewArray;
@end

@implementation CTWebViewPreloader
+ (instancetype)sharedInstance
{
    static CTWebViewPreloader *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CTWebViewPreloader alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    if (self= [super init]) {
        _webViewArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)preloadURL:(NSURL *)url
{
    NSAssert(url, @"preload url can not be nil.");
    FTLog(@"%@", url);
    CTH5WebView *webView = [[CTH5WebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    webView.delegate = self;
    webView.maxRetryCheckBridgeJsTimes = 1;
    [self.webViewArray addObject:webView];
    
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    webView.hidden = YES;
    [keyWindow insertSubview:webView atIndex:0];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    FTLog();
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    FTLog();
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    FTLog();
    webView.delegate = nil;
    [webView removeFromSuperview];
    [self.webViewArray removeObject:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    TLog();
    webView.delegate = nil;
    [webView removeFromSuperview];
    [self.webViewArray removeObject:webView];
}
@end
