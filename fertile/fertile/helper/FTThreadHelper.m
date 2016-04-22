//
//  FTThreadHelper.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTThreadHelper.h"

@interface FTThreadHelper()
{
    NSMutableDictionary * serialQueue ;
    NSString *defaultSerialQueueIdentifier;
    NSMutableDictionary * concurrentQueue;
//    dispatch_queue_t defaultSerialQueue = dispatch_queue_create("com.dispatch.writedb", DISPATCH_QUEUE_SERIAL);
}

@end

@implementation FTThreadHelper

static FTThreadHelper *sharedInstance = nil;

+(FTThreadHelper *) sharedInstance
{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FTThreadHelper new];
        [sharedInstance helperInit];
    });
    return sharedInstance;
}

#pragma mark - FTHelperProtocol

-(void)helperInit
{
    [super helperInit];
    serialQueue = [NSMutableDictionary dictionaryWithCapacity:1];
    defaultSerialQueueIdentifier = [[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@".defaultSerialQueue"];
    dispatch_queue_t defaultSerialQueue = dispatch_queue_create([defaultSerialQueueIdentifier UTF8String], DISPATCH_QUEUE_SERIAL);
    [serialQueue setObjectForFT:defaultSerialQueue forKey:defaultSerialQueueIdentifier];

    concurrentQueue = [NSMutableDictionary dictionaryWithCapacity:3];
}

-(void)helperRelease
{
    
    [super helperRelease];
}


- (void)didReceiveMemoryWarning
{
    
}

#pragma mark - custom area

-(void) doInDefaultSerialQueue:(void(^)(void))block
{
    dispatch_async([serialQueue objectForKey:defaultSerialQueueIdentifier], block);
}





@end
