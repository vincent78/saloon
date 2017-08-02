//
//  FTMoveableWidget.m
//  fertile
//
//  Created by vincent on 16/6/24.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTMoveableBtn.h"

#define kImageViewTagForMoveableButton 12222


@interface FTMoveableBtn()

@property (nonatomic,copy)Action actionBlock;

@end

@implementation FTMoveableBtn

- (id)initWithImage:(UIImage *)image clickedBlock:(Action)block {
    if (self = [super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)]) {
        self.actionBlock = block;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.image = image;
        imageView.frame = self.bounds;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.tag = kImageViewTagForMoveableButton;
        [self addSubview:imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setBgImage:(UIImage *)bgImage {
    UIImageView *imageView = (UIImageView*)[self viewWithTag:kImageViewTagForMoveableButton];
    imageView.image = bgImage;
    CGRect frame = self.frame;
    frame.size.width = bgImage.size.width;
    frame.size.height = bgImage.size.height;
    imageView.bounds = frame;
    self.frame = frame;
}


#pragma mark - --------------------System--------------------
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

#pragma mark - --------------------功能函数--------------------
#pragma mark 分块内功能函数注释
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}


@end
