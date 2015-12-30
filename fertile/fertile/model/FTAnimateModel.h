//
//  FTAnimateModel.h
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseModel.h"

typedef void(^animateBlockType)(void);

typedef void(^animateFinishedBlockType)(BOOL finished);


@interface FTAnimateModel : FTBaseModel


/**
 *  @brief  动画持续时间
 */
@property(nonatomic) NSTimeInterval *duration;

/**
 *  @brief  动画的延迟开始的时间
 */
@property(nonatomic) NSTimeInterval delay;

/**
 *  @brief  动画的对象
 */
@property(nonatomic,weak) UIView *animateObj;

/**
 *  @brief  执行的次数    MAXFLOAT为重复执行
 */
@property(nonatomic,assign) int doNum;

/**
 *  @brief  动画的操作
 */
@property(nonatomic,copy) animateBlockType animateBlock ;

/**
 *  @brief  动画开始的block
 */
@property(nonatomic,copy) animateBlockType beginBlock;

/**
 *  @brief  动画结束后的block
 */
@property(nonatomic,copy) animateFinishedBlockType finishedBlock;



@end
