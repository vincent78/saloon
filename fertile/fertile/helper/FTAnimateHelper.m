//
//  FTAnimateHelper.m
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTAnimateHelper.h"

@implementation FTAnimateHelper

#pragma mark - single
static FTAnimateHelper *sharedInstance = nil;

+(FTAnimateHelper *) sharedInstance
{    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTAnimateHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

-(void)helperInit
{
    [super helperInit];
}

-(void)resetHelper
{
    [super helperRelease];
}

- (void)didReceiveMemoryWarning
{
    
}

#pragma mark - custom area

-(void) doSimpleAnimated
{
    
}

@end
