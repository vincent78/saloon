//
//  FTTableViewController.h
//  fertile_oc
//
//  Created by vincent on 15/11/5.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseViewController.h"


@interface FTTableViewController : FTBaseViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *tableView;



@end
