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



/**
 *  @brief 递归计算到所有包含指定点的view
 *
 *  @param point <#point description#>
 *  @param views <#views description#>
 *
 *  @return <#return value description#>
 */
-(NSArray *) findViewContainsPoint:(CGPoint)point withView:(UIView *)view
{
    if (!view || view.subviews.count ==0)
    {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    NSMutableDictionary *typeDic = [NSMutableDictionary dictionary];
    
    for (int i=0;i<view.subviews.count;i++)
    {
        UIView *subView = (UIView *)[view.subviews objectAtIndex:i];
        CGRect subRect = [subView convertRect:subView.frame toView:self];
        
        NSString *className = NSStringFromClass([subView class]);
        NSString *currStr = @"";
        int subIndex = 0;
        if ([typeDic objectForKey:className])
        {
            subIndex = [[typeDic objectForKey:className] intValue] + 1;
            
        }
        [typeDic setObject:[NSNumber numberWithInt:subIndex] forKey:className];
        currStr = [NSString stringWithFormat:@"/%@[%i]",className,subIndex];
        
        NSLog(@"view-> %@ point->(%.2f,%.2f) rect->(%.2f %.2f %.2f %.2f)"
              ,currStr,point.x,point.y,subRect.origin.x,subRect.origin.y,subRect.size.width,subRect.size.height);
        if (CGRectContainsPoint(subRect, point))
        {
            NSLog(@"isContains.");
            NSArray *subArray = [self findViewContainsPoint:point withView:subView ];
            if (subArray)
            {
                for(int i=0;i<subArray.count;i++)
                {
                    [array addObject:[NSString stringWithFormat:@"%@%@",currStr,[subArray objectAtIndex:i]]];
                    NSLog(@"the level str :%@",[NSString stringWithFormat:@"%@%@",currStr,[subArray objectAtIndex:i]]);
                }
            }
            else
            {
                [array addObject:currStr];
                NSLog(@"the leaf str :%@",currStr);
            }
        }
        else
        {
            NSLog(@"notContains.");
        }
    }
    
    return array;
}


@end
