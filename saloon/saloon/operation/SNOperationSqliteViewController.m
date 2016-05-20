//
//  SNOperationSqliteViewController.m
//  saloon
//
//  Created by vincent on 16/5/13.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNOperationSqliteViewController.h"

@interface SNOperationSqliteViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtDBName;

@end

@implementation SNOperationSqliteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)createDBAction:(id)sender {
    
    NSString *dbName = _txtDBName.text;
    [FTDbManager getInstance:dbName];
    [FTAlertWidget showAlertWithMessage:@"数据库已创建"];
}
- (IBAction)deleteDBAction:(id)sender {
    NSString *dbFile = [[FTFileUtil getDocDirectory] stringByAppendingPathComponent:@"db"];
    dbFile = [dbFile stringByAppendingPathComponent:_txtDBName.text];
    [FTFileUtil removeItem:dbFile];
    [FTAlertWidget showAlertWithMessage:@"数据库已创建"];
}

@end
