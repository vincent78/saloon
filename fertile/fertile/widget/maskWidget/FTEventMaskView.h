//
//  FTEventMaskView.h
//  fertile
//
//  Created by vincent on 2017/1/24.
//  Copyright © 2017年 fruit. All rights reserved.
//

/*
 
 cell.eventMaskView = [[FTEventMaskView alloc] init];
 cell.eventMaskView.userInteractionEnabled = YES;
 if (!cell.eventMaskView.passthroughViews)
 {
 cell.eventMaskView.passthroughViews = [NSMutableArray arrayWithCapacity:1];
 }
 if (numStepperView.leftBtn.isEnabled)
 {
 [cell.eventMaskView.passthroughViews addObjectForCtrip:numStepperView.leftBtn];
 }
 if (numStepperView.rightBtn.isEnabled)
 {
 [cell.eventMaskView.passthroughViews addObjectForCtrip:numStepperView.rightBtn];
 }
 [otherView addSubview:cell.eventMaskView];
 */


#import <UIKit/UIKit.h>

@interface FTEventMaskView : UIView

@property (nonatomic,strong) NSMutableArray *passthroughViews;

@end
