//
//  FTUserExtInfoModel.h
//  fertile
//
//  Created by vincent on 16/5/20.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTUserExtInfoModel : NSObject

@property (nonatomic,assign) int userId;
@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *extend;

@end
