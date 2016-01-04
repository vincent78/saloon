//
//  FTIndicatorWidget.m
//  fertile
//
//  Created by vincent on 16/1/4.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTIndicatorWidget.h"

@interface FTIndicatorWidget()

@property (strong, nonatomic)UIImageView *animationView;
@property (strong, nonatomic)NSTimer *timer;
@property (assign, nonatomic)BOOL animationing;

@end

@implementation FTIndicatorWidget

-(id)initWithFrame:(CGRect)frame {
    return nil;
}

- (instancetype)initWithActivityIndicatorStyle:(FTIndicatorViewStyle)style {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.activityIndicatorViewStyle = style;
        if (style == FTIndicatorViewStyleBig) {
            self.animationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_icon_big_c_refresh"]];
        }
        else {
            self.animationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_icon_small_c_refresh"]];
        }
        self.bounds = CGRectMake(0, 0, self.animationView.frame.size.width, self.animationView.frame.size.height);
        self.animationView.frame = self.animationView.bounds;
        
        [self addSubview:self.animationView];
    }
    
    return self;
}

-(void)setActivityIndicatorViewStyle:(FTIndicatorViewStyle)activityIndicatorViewStyle {
    CGPoint position = self.center;
    if (activityIndicatorViewStyle == _activityIndicatorViewStyle) {
        if (activityIndicatorViewStyle == FTIndicatorViewStyleBig) {
            self.animationView.image = [UIImage imageNamed:@"main_icon_big_c_refresh"];
        }
        else {
            self.animationView.image = [UIImage imageNamed:@"main_icon_small_c_refresh"];
        }
        _activityIndicatorViewStyle = activityIndicatorViewStyle;
        self.bounds = self.animationView.bounds;
        self.animationView.frame = self.animationView.bounds;
        self.center = position;
    }
}

-(void)setHidesWhenStopped:(BOOL)hidesWhenStopped {
    _hidesWhenStopped = hidesWhenStopped;
    if(self.animationing) {
        self.animationView.alpha = 1;
    }
    else {
        self.animationView.alpha = 0;
    }
}

- (void)startAnimating {
    [self stopAnimating];
    _animationView.alpha = 1;
    
    self.animationing = YES;
    self.animationView.transform = CGAffineTransformIdentity;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(repeatAnimation) userInfo:nil repeats:YES];
    
}
- (void)stopAnimating {
    if (self.timer) {
        [self.timer invalidate];
    }
    self.timer =nil;
    self.animationing = NO;
    if (self.hidesWhenStopped == YES) {
        self.animationView.alpha = 0;
    }
}
- (BOOL)isAnimating {
    return self.animationing;
}

-(void)repeatAnimation {
    [UIView beginAnimations:nil context:nil];
    self.animationView.transform = CGAffineTransformRotate(self.animationView.transform, M_PI/8);
    [UIView commitAnimations];
}

@end
