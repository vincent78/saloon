//
//  CTWebViewPreloader.h
//  CTBusiness
//
//  Created by derick on 11/23/15.
//  Copyright © 2015 Ctrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTWebViewPreloader : NSObject
+ (instancetype)sharedInstance;

- (void)preloadURL:(NSURL *)url;
@end
