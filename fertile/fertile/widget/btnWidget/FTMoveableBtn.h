//
//  FTMoveableWidget.h
//  fertile
//
//  Created by vincent on 16/6/24.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTMoveableBtn.h"

@interface FTMoveableBtn : FTBaseWidget

/**
 *  执行的block
 *
 */
typedef  void (^Action)();


- (id)initWithImage:(UIImage *)image clickedBlock:(Action)block;

@property (nonatomic, strong) UIImage *bgImage;


@end
