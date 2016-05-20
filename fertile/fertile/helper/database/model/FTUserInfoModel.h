//
//  FTUserInfoModel.h
//  fertile
//
//  Created by vincent on 16/5/20.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTUserInfoModel : NSObject

@property (nonatomic,assign) int userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *passwd;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *lastLoginTime;

@end
