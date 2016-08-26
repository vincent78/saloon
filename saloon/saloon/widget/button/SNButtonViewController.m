//
//  SNButtonViewController.m
//  saloon
//
//  Created by vincent on 16/8/11.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNButtonViewController.h"

@interface SNButtonViewController ()

@end

@implementation SNButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initView
{
    [self initBtn01];
    [self initBtn02];
}


-(void) initBtn01
{
    [self.btn01 setTitle:@"测试按钮01" forState:UIControlStateNormal];
    self.btn01.backgroundColor = [UIColor yellowColor];
    [self.btn01 viewCornerRaidusType:4 borderColor:[UIColor redColor] borderWidth:1];
}

-(void) initBtn02
{
    [self.btn02 setTitle:@"测试按钮02" forState:UIControlStateNormal];
    self.btn02.backgroundColor = [UIColor yellowColor];
    [self.btn02 viewCornerRaidusType:4 roundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight borderWidth:[FTSystemHelper onePixeWidth] borderColor:[UIColor redColor] borderDashPattern:@[@2,@1]];
}


@end
