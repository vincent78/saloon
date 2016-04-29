//
//  SNOperationAutoLayoutMasonryViewController.m
//  saloon
//
//  Created by vincent on 16/4/27.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNOperationAutoLayoutMasonryViewController.h"

@interface SNOperationAutoLayoutMasonryViewController ()
@property (strong, nonatomic) IBOutlet UIView *horizonView;
@property (strong, nonatomic) IBOutlet UIView *verticalView;

@end

@implementation SNOperationAutoLayoutMasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initView];
}



-(void) initView
{
    [self initHorizonView];
    [self initVerticalView];
}

-(void) initHorizonView
{
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor redColor];
    [self.horizonView addSubview:view1];
    view1 = nil;
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor yellowColor];
    [self.horizonView addSubview:view2];
    view2 = nil;
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor blueColor];
    [self.horizonView addSubview:view3];
    view3 = nil;
    
    [self.horizonView makeSubSameWidthWithPadding:10 viewPadding:5];
    
}

-(void) initVerticalView
{
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor redColor];
    [self.verticalView addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor yellowColor];
    [self.verticalView addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor blueColor];
    [self.verticalView addSubview:view3];
    
    [self.verticalView makeSubSameHeightWithPadding:10 viewPadding:5];
}


@end
