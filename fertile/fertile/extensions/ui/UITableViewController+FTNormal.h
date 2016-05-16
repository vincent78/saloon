//
//  UITableViewController+normal.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FTTableViewStyle)
{
    FTTableViewStyleNormal, //系统正常的显示
    FTTableViewStyleNone,   //什么都不显示
};

@interface UITableViewController (FTormal)

@end
