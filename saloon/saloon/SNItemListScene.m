//
//  SNItemListScene.m
//  saloon
//
//  Created by vincent on 16/1/11.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNItemListScene.h"

@interface SNItemListScene ()

@end

@implementation SNItemListScene

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareItems];
    [self setExtraCellLineHidden:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) prepareItems
{
    if (!self.items || self.items.count == 0)
    {
        NSString *tmpFileFullName = [[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"json"];
        if ([FTFileUtil exist:tmpFileFullName])
            self.items = [FTFileUtil readArrayFromFile:tmpFileFullName];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self formatLastCellSeparatorLine];
}


#pragma mark - tableview

/**
 *  @brief 去掉多余的分隔线
 *
 *  @param tableView <#tableView description#>
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void) formatLastCellSeparatorLine
{
    UITableViewCell *cell = [self.tableView.visibleCells lastObject];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items ? self.items.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    NSDictionary *item = [self.items objectAtIndex:indexPath.row];
    
    NSArray *subItems =  [item objectForKey:@"subitems"];
    if (subItems && subItems.count>0)
    {
        SNItemListScene *itemListVC = [[SNItemListScene alloc] init];
        itemListVC.items = subItems;
        [[FTRouteHelper sharedInstance] pushWithVC:itemListVC];
    }
    else
    {
        NSString * vcName = [item objectForKey:@"viewcontroller"];
        if (![NSString isNilOrEmpty:vcName])
        {
            FTBaseViewController *vc = [NSClassFromString(vcName) new];
//            [[FTRouteHelper sharedInstance] pushWithClass:NSClassFromString(vcName)];
            [[FTRouteHelper sharedInstance] pushWithVC:vc];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

@end
