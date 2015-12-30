//
//  FTAnimateHelper.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseHelper.h"

typedef NS_ENUM(NSInteger,UIViewAnimateType) {
    UIViewAnimateTypeNone               //无动画
    ,UIViewAnimateTypeSlowShow          //渐渐显示
    ,UIViewAnimateTypeSlowHide          //渐渐消失
};



@interface FTAnimateHelper : FTBaseHelper

+(FTAnimateHelper *) sharedInstance;

-(void) doSimpleAnimated;

@end
