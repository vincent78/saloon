//
//  FTMoveableWidget.m
//  fertile
//
//  Created by vincent on 16/6/24.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTMoveableWidget.h"

@implementation FTMoveableWidget

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint prePoint = [touch previousLocationInView:self.superview];
    CGPoint nowPoint = [touch locationInView:self.superview];
    CGPoint offset = CGPointMake(nowPoint.x-prePoint.x, nowPoint.y-prePoint.y);
    
    self.center = CGPointMake(self.center.x+offset.x, self.center.y+offset.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}


@end
