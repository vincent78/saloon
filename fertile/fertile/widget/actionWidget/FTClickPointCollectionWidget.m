//
//  FTClickPointCollectionWidget.m
//  fertile
//
//  Created by vincent on 16/4/29.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTClickPointCollectionWidget.h"

@implementation FTClickPointCollectionWidget

/**
 *  @brief 这个函数的用处是判断当前的点击或者触摸事件的点是否在当前的view中
 它被hitTest:withEvent:调用
 *
 *  @param point <#point description#>
 *  @param event <#event description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    NSLog(@"the tap point : %f  %f",point.x ,point.y);
//    [FTToastWidget showText:[NSString stringWithFor@""]
    
    //return fase 不响应事件
    return false;
}

@end
