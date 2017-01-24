//
//  FTEventMaskView.m
//  fertile
//
//  Created by vincent on 2017/1/24.
//  Copyright © 2017年 fruit. All rights reserved.
//

#import "FTEventMaskView.h"

@interface FTEventMaskView()
{
    BOOL testHits;
}


@end;

@implementation FTEventMaskView

-(UIView *) hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    if (testHits)
    {
        return nil;
    }
    
    if (!self.passthroughViews || (self.passthroughViews && self.passthroughViews.count == 0))
    {
        return self;
    }
    else
    {
        UIView *hitView = [super hitTest:point withEvent:event];
        if (hitView == self)
        {
            testHits = YES;
            CGPoint superPoint = [self.superview convertPoint:point fromView:self];
            UIView *superHitView = [self.superview hitTest:superPoint withEvent:event];
            testHits = NO;
            
            if ([self isPassthroughView:superHitView])
            {
                hitView = superHitView;
            }
            
        }
        
        return hitView;
    }
}

- (BOOL)isPassthroughView:(UIView *)view {
    if (!view)
    {
        return NO;
    }
    if ([self.passthroughViews containsObject:view])
    {
        return YES;
    }
    
    return [self isPassthroughView:view.superview];
}

-(void) dealloc
{
    self.passthroughViews = nil;
}


@end
