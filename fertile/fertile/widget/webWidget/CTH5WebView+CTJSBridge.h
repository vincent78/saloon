//
//  CTH5WebView+CTJSBridge.h
//  CTBusiness
//
//  Created by derick on 9/29/15.
//  Copyright © 2015 Ctrip. All rights reserved.
//

#import "CTH5WebView.h"


@interface CTH5WebView (CTJSBridge)
- (NSString *)executeJs:(NSString *)js;
- (NSString *)callBackH5WithTagName:(NSString *)tagName param:(NSObject*)param;
- (void)autoCheckBridgeJS;
- (void)resetBridgeJSChecker;
- (BOOL)isLegalCtripURL;

@end
