//
//  SNItemListViewController.m
//  saloon
//
//  Created by vincent on 15/12/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "SNItemListViewController.h"

@interface SNItemListViewController ()

@end

@implementation SNItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Demo信息"];
    [self prepareItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




-(void) prepareItems
{
    if (!self.items || self.items.count == 0)
    {
        NSString *tmpFileFullName = [[NSBundle mainBundle] pathForResource:@"items" ofType:@"json"];
        if ([FTFileUtil exist:tmpFileFullName])
            self.items = [FTFileUtil readArrayFromFile:tmpFileFullName];
    }
}


#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items ? self.items.count : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TableCell"];
    }
    NSDictionary *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [item objectForKey:@"desc"];
    NSArray *subItems = [item objectForKey:@"subitems"];
    if ( subItems && subItems.count >0)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *subItems =  [[self.items objectAtIndex:indexPath.row] objectForKey:@"subitems"];
    if (subItems && subItems.count>0)
    {
        SNItemListViewController *itemListVC = [[SNItemListViewController alloc] init];
        itemListVC.items = subItems;
        [[FTRouteHelper sharedInstance] pushWithVC:itemListVC];
    }
}

@end
