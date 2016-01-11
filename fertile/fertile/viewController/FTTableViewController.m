//
//  FTTableViewController.m
//  fertile_oc
//
//  Created by vincent on 15/11/5.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTTableViewController.h"

@interface FTTableViewController()
{
    
}

@end


@implementation FTTableViewController



#pragma mark - system circle

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
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
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView fillInView:self.contentView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


@end
