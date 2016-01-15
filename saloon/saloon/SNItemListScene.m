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
        NSString *tmpFileFullName = [[NSBundle mainBundle] pathForResource:@"items" ofType:@"json"];
        if ([FTFileUtil exist:tmpFileFullName])
            self.items = [FTFileUtil readArrayFromFile:tmpFileFullName];
    }
}


#pragma mark - tableview

/**
 *  @brief 去掉多余的分隔线
 *
 *  @param tableView <#tableView description#>
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items ? self.items.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
            [[FTRouteHelper sharedInstance] pushWithClass:NSClassFromString(vcName)];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

@end
