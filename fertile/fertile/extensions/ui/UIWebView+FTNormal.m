//
//  UIWebView+normal.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "UIWebView+FTNormal.h"

@implementation UIWebView (FTNormal)


-(void) loadBlankPage
{
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    //适合高宽
    self.scalesPageToFit = YES;
    //禁止到顶后滑动
    self.scrollView.bounces = NO;
}

-(void) normalShow
{
    //适合高宽
    self.scalesPageToFit = YES;
    //禁止到顶后滑动
    self.scrollView.bounces = NO;
    self.layer.masksToBounds = YES;
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}




@end
