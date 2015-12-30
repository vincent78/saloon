//
//  SNItemListViewController.h
//  saloon
//
//  Created by vincent on 15/12/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTTableViewController.h"

@interface SNItemListViewController : FTTableViewController<FTTableViewDelegate>

@property(nonatomic,strong) NSArray *items;

@end
