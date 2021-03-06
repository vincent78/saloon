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



//void runBlockInMainThread(dispatch_block_t block) {
//    if (block == nil) {
//        return;
//    }
//    
//    if ([NSThread isMainThread]) {
//        block();
//    }
//    else {
//        dispatch_sync(dispatch_get_main_queue(), block);
//    }
//}

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



void FTExecuteOnMainThread(dispatch_block_t block, BOOL sync)
{
    if ([NSThread isMainThread]) {
        block();
    } else if (sync) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

@end
