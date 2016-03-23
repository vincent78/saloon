//
//  SNProgressViewController.m
//  saloon
//
//  Created by vincent on 16/3/23.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNProgressViewController.h"

@interface SNProgressViewController ()
{
    FTProgressView *progressView01;
    NSTimer * asyncLoadTimer;
    BOOL isRuning;
}
@property (strong, nonatomic) IBOutlet UIView *containView01;
@property (strong, nonatomic) IBOutlet UIButton *btn01;

@end

@implementation SNProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    isRuning=false;
}

-(void) initProgressView
{
//    [self initProgressView1];
}

-(void) initProgressView1
{
    if (!progressView01)
    {
        progressView01 = [[FTProgressView alloc] initWithFrame:CGRectMake(0, 0, self.containView01.ftWidth, 30)];
    }
    
    [progressView01 removeFromSuperview];
    [progressView01 setTrackTintColor:[UIColor clearColor]];
    [progressView01 setProgressTintColor:[UIColor colorWithHexString:@"0xfeb534"]];
    progressView01.delegate = self;
    [self.containView01 addSubview:progressView01];
    if (asyncLoadTimer)
    {
        [asyncLoadTimer invalidate];
        asyncLoadTimer = nil;
    }
    [progressView01 setProgress:0];
    
    asyncLoadTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                      target:self
                                                    selector:@selector(updateProgress)
                                                    userInfo:nil
                                                     repeats:NO];
    
    
//    [[NSRunLoop mainRunLoop] addTimer:asyncLoadTimer forMode:NSRunLoopCommonModes];
    [asyncLoadTimer fire];
}


-(void) updateProgress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [progressView01 setProgress:progressView01.progress+1 animated:YES];
    });
}

-(void)progressViewFinishedLoad
{
    NSLog(@"the end!");
    isRuning = NO;
    if (asyncLoadTimer)
    {
        [asyncLoadTimer invalidate];
        asyncLoadTimer = nil;
    }
}

- (IBAction)btn01Clicked:(id)sender {
    if (!isRuning)
    {
        isRuning = YES;
        [self initProgressView1];
    }
}


@end
