//
//  FTAlertUtil.m
//  fertile_oc
//
//  Created by vincent on 15/11/2.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTAlertUtil.h"

@implementation FTAlertUtil

+(void) alertMsg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
