//
//  SNTestViewController.m
//  saloon
//
//  Created by vincent on 16/1/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNTestViewController.h"

@interface SNTestViewController ()
{
    NSTimer *timer;
}

@end

@implementation SNTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testAction:(id)sender {
    [self beginTimer];
//    [self performSelectorInBackground:@selector(beginTimer) withObject:nil];
//    [self performSelector:@selector(stopTimer) withObject:nil afterDelay:2];
}

-(void) beginTimer
{
    timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(test) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    [[NSRunLoop currentRunLoop] run];
    FTDLog(@"thread %@",[NSThread currentThread]);
    [timer fire];
}

-(void)stopTimer
{
    FTDLog(@"timer set to nil");
    if (timer.isValid)
    {
        timer = nil;
    }
//        [timer setFireDate:[NSDate distantFuture]];
}

-(void)test
{
    FTDLog(@"testtest.....");
    FTDLog(@"thread %@",[NSThread currentThread]);
}



@end
