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
    if (!nibNameOrNil)
    {
        nibNameOrNil = NSStringFromClass([self class]);
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.widgets = [[NSMutableArray alloc] initWithCapacity:1];
        self.ftNavWidget = [[FTAppHelper sharedInstance] getNavWidget];
        
        if (self.ftNavWidget)
            [self.widgets safeAddObject:self.ftNavWidget];
        
        self.showNav = YES;
        self.showStatusBar = YES;
        self.overlapNavAndStatusBar = NO;
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0
                                                                   , [FTSystemHelper screenWidth]
                                                                   , [FTSystemHelper screenHeight])];
        
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
    
    //加载导航栏
    if (self.showNav)
    {
        [self appendNavBar];
    }
    [self.view addSubview:self.contentView];
    
    for (int i=0;i<self.widgets.count;i++)
    {
        FTBaseWidget *widget = (FTBaseWidget *)[self.widgets safeObjectAtIndex:i];
        if (!widget.hasDidLoad)
            [widget widgetDidLoad];
    }
    self.view.backgroundColor = [FTAppHelper sharedInstance].vcBackGroundColor;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    for (int i=0;i<self.widgets.count;i++)
    {
        FTBaseWidget *widget = (FTBaseWidget *)[self.widgets safeObjectAtIndex:i];
        if (!widget.hasAppeared)
            [widget widgetWillAppear];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (int i=0;i<self.widgets.count;i++)
    {
        FTBaseWidget *widget = [self.widgets safeObjectAtIndex:i];
        if (!widget.hasAppeared)
            [widget widgetDidAppear];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    for (int i=(int)self.widgets.count -1;i>= 0;i--)
    {
        FTBaseWidget *widget = [self.widgets safeObjectAtIndex:i];
        if (widget.hasAppeared)
            [widget widgetWillDisappear];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    for (int i=(int)self.widgets.count -1;i >= 0;i--)
    {
        FTBaseWidget *widget = [self.widgets safeObjectAtIndex:i];
        if (widget.hasAppeared)
            [widget widgetDidDisappear];
    }
}

-(void)dealloc
{
    self.ftNavWidget = nil;
    
//    for (int i=(int)self.widgets.count -1;i>= 0;i--)
//    {
//        FTBaseWidget *widget = [self.widgets safeObjectAtIndex:i];
//        widget = nil;
//    }
    [self.widgets removeAllObjects];
    self.widgets = nil;
    
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
    if (!self.ftNavWidget)
    {
        [self.navigationController setNavigationBarHidden:NO];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES];
    }
        
    float navTop = 0;
    if (self.showStatusBar && !self.overlapNavAndStatusBar)
    {
        navTop = [FTSystemHelper statusBarHeight];
    }
    self.ftNavWidget.ftTop = navTop;
    [self.view addSubview:self.ftNavWidget];
    
    
    self.contentView.frame = CGRectMake(0
                                        , navTop + [FTSystemHelper navBarHeight]
                                        , [FTSystemHelper screenWidth]
                                        , [FTSystemHelper screenHeight] - navTop - [FTSystemHelper navBarHeight]);
}


-(void) setTitle:(NSString *)title
{
    [super setTitle:title];
    [self.ftNavWidget setNavTitle:title];
}




@end