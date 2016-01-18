//
//  FTBaseViewController.m
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseViewController.h"

@interface FTBaseViewController()
{
    UIView *container;
}


@end

@implementation FTBaseViewController


#pragma mark - system circle

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.showNav = YES;
        self.showStatusBar = YES;
        self.overlapNavAndStatusBar = NO;
        self.contentFrame = CGRectMake(0, 0, [FTSystemHelper screenWidth], [FTSystemHelper screenHeight]);
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}




-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0
//                                                                , [FTSystemHelper screenWidth]
//                                                                , [FTSystemHelper screenHeight])];
//    [self.view addSubview:self.contentView];
    self.view.backgroundColor = [FTAppHelper sharedInstance].vcBackGroundColor;
    //导航栏相关
    [self appendNavBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)dealloc
{
    self.ftNavWidget = nil;
    if (container)
    {
        [container removeFromSuperview];
        container = nil;
    }
}

-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - navigateBar

-(void) appendNavBar
{
    if (!self.showNav)
    {
        return;
    }
    if (!self.ftNavWidget)
    {
        [self.navigationController setNavigationBarHidden:NO];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES];
        float navTop = 0;
        if (self.showStatusBar && !self.overlapNavAndStatusBar)
        {
            navTop = [FTSystemHelper statusBarHeight];
        }
        self.ftNavWidget.ftTop = navTop;
        [self.view addSubview:self.ftNavWidget];        
        self.contentFrame = CGRectMake(0
                                            , navTop + [FTSystemHelper navBarHeight]
                                            , [FTSystemHelper screenWidth]
                                            , [FTSystemHelper screenHeight] - navTop - [FTSystemHelper navBarHeight]);

    }
    
}
@end
