//
//  FTProgressView.m
//  fertile
//
//  Created by vincent on 16/3/23.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTProgressView.h"

@implementation FTProgressView
{
    CGFloat SYSTEM_VERSION;
    ProgressImageResizingMode progressImgResizeMode;
    TrackImageResizingMode trackImgResizeMode;
    float currentPercent;
    NSTimer * timer;
    BOOL animation;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _progress = 0.0f;
        _progressTintColor = nil;
        _trackTintColor = nil;
        _progressImage = nil;
        _trackImage = nil;
        _radius = 0.0f;
        progressImgResizeMode = ProgressImageResizingModeStretch;
        trackImgResizeMode = TrackImageResizingModeStretch;
        SYSTEM_VERSION = [[[UIDevice currentDevice] systemVersion] floatValue];
        self.backgroundColor = [UIColor clearColor];
        currentPercent = 0.0f;
        animation = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    //设置圆角,如果如果圆角的半径*2>高度，则圆角半径改为高度/2
    CGFloat radius = 0.0f;
    if (_radius * 2 >= height) {
        radius = height/2.0f;
    }else{
        radius = _radius>0?_radius:0;
    }
    
    //设置填充百分比
    CGFloat fillPercent = 0.0f;
    if (animation) {
        fillPercent = currentPercent;
    }else{
        fillPercent = _progress;
    }
    if (fillPercent <= 0.0f) {
        fillPercent = 0.0f;
    }else if (fillPercent >= 1.0f){
        fillPercent = 1.0f;
    }
    
    //绘制track
    CGContextRef context = UIGraphicsGetCurrentContext();
    //保存当前上下文状态
    CGContextSaveGState(context);
    //创建背景路径
    CGMutablePathRef trackPathRef = CGPathCreateMutable();
    CGPathAddArc(trackPathRef, nil, radius, radius, radius, M_PI, -M_PI_2, 0);
    CGPathAddLineToPoint(trackPathRef, nil, width-radius, 0.0f);
    CGPathAddArc(trackPathRef, nil, width-radius, radius, radius, -M_PI_2, 0, 0);
    CGPathAddLineToPoint(trackPathRef, nil, width, height-radius);
    CGPathAddArc(trackPathRef, nil, width-radius, height-radius, radius, 0, M_PI_2, 0);
    CGPathAddLineToPoint(trackPathRef, nil, radius, height);
    CGPathAddArc(trackPathRef, nil, radius, height-radius, radius, M_PI_2, M_PI, 0);
    CGPathCloseSubpath(trackPathRef);
    //设置背景填充
    CGContextSetFillColorWithColor(context, _trackTintColor.CGColor);
    //context添加path
    CGContextAddPath(context, trackPathRef);
    //填充path
    CGContextFillPath(context);
    CGPathRelease(trackPathRef);
    
    if (fillPercent > 0.0f) {
        CGMutablePathRef progressPathRef = CGPathCreateMutable();
        float fillWidth = fillPercent * width ;
        if (radius > 0) {
            //如果有圆角的话,则要判断当前进度和圆角的关系
            if (fillWidth > radius) {
                //如果当前进度大于圆角半径,则正常绘制左边的圆角
                CGPathAddArc(progressPathRef, nil, radius, radius, radius, -M_PI_2, M_PI, 1);
                CGPathAddLineToPoint(progressPathRef, nil, 0.0f, height-radius);
                CGPathAddArc(progressPathRef, nil, radius, height-radius, radius, M_PI, M_PI_2, 1);
                if (fillWidth <= width - radius) {
                    CGPathAddLineToPoint(progressPathRef, nil, fillWidth, height);
                    CGPathAddLineToPoint(progressPathRef, nil, fillWidth, 0.0f);
                }else if (fillWidth > width-radius){
                    CGPathAddLineToPoint(progressPathRef, nil, fillWidth, height);
                    //当前进度在右边圆角内
                    double corner = acos((fillWidth+radius-width)/radius);
                    CGPathAddArc(progressPathRef, nil, width-radius, height-radius, radius, M_PI_2, corner, 1);
                    CGPathAddLineToPoint(progressPathRef, nil, fillWidth, radius);
                    CGPathAddArc(progressPathRef, nil, width-radius, radius, radius, -corner, -M_PI_2, 1);
                }
            }else {
                //当前进度还在左边圆角之内
                double corner = acos((radius-fillWidth)/radius);    //计算和x轴的夹角
                CGPathAddArc(progressPathRef, nil, radius, radius, radius, -(M_PI-corner), M_PI, 1);
                CGPathAddLineToPoint(progressPathRef, nil, 0.0f, height-radius);
                CGPathAddArc(progressPathRef, nil, radius, height-radius, radius, M_PI, M_PI-corner, 1);
            }
            
            CGPathCloseSubpath(progressPathRef);
        }else{  //如果没有圆角,直接画直线
            CGPathMoveToPoint(progressPathRef, nil, 0.0f, 0.0f);
            CGPathAddLineToPoint(progressPathRef, nil, fillWidth, 0.0f);
            CGPathAddLineToPoint(progressPathRef, nil, fillWidth, height);
            CGPathAddLineToPoint(progressPathRef, nil, 0.0f, height);
            CGPathCloseSubpath(progressPathRef);
        }
        CGContextSetFillColorWithColor(context, _progressTintColor.CGColor);
        CGContextAddPath(context, progressPathRef);
        CGContextFillPath(context);
        CGPathRelease(progressPathRef);
        
    }
    CGContextRestoreGState(context);
    if (fillPercent >= 1.0f && self.delegate) {
        [self.delegate progressViewFinishedLoad];
    }
}

#pragma mark - -----------------------设置进度方法------------------------
- (void)setProgress:(float)progress animated:(BOOL)animated{
    if (progress>1.0f) {
        progress = 1.0f;
    }
    currentPercent = _progress;
    animation = animated;
    _progress = progress;
    if (animated) { //如果需要动画的话
        if (!timer) {
            timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animationDraw) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        }
    }else{
        [self setNeedsDisplay];
    }
}

-(void)animationDraw{
    currentPercent+=0.01f;
    if (currentPercent > _progress) {
        currentPercent = _progress;
        [timer invalidate];
        timer = nil;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

- (void)setProgress:(float)progress{
    [self setProgress:progress animated:NO];
}

#pragma mark - -----------------------设置背景图片------------------------
-(void)setTrackImage:(UIImage *)trackImage{
    if (trackImage) {
        _trackImage = trackImage;
        UIImage *onImage = _trackImage;
        if (SYSTEM_VERSION >= 6) {
            onImage = [_trackImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        } else if (SYSTEM_VERSION >= 5) {
            onImage = [_trackImage resizableImageWithCapInsets:UIEdgeInsetsZero];
        }
        float width = 0.0f;
        if (trackImgResizeMode == TrackImageResizingModeStretch) {
            //如果选择背景图片为拉伸模式,则设定宽度为视图宽度
            width = self.frame.size.width;
        }else {
            //如果选择背景图片为平铺模式,则设置拉伸宽度为图片宽度
            width = onImage.size.width;
        }
        onImage = [self scaleToSize:onImage size:CGSizeMake(width, self.frame.size.height)];
        [self setTrackTintColorWithTrackTintImage:onImage];
    }
}

#pragma mark - -----------------------设置进度条图片------------------------
-(void)setProgressImage:(UIImage *)progressImage {
    if (progressImage) {
        _progressImage = progressImage;
        UIImage * onImage;
        if (SYSTEM_VERSION >= 6) {
            onImage = [_progressImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        }else {
            onImage = [_progressImage resizableImageWithCapInsets:UIEdgeInsetsZero];
        }
        float width = 0.0f;
        if (progressImgResizeMode == ProgressImageResizingModeStretch) {
            //如果选择进度条图片拉伸模式,则设置宽度为视图宽度
            width = self.frame.size.width;
        }else {
            //如果选择进度条图片平铺模式,则设置拉伸宽度为图片宽度
            width = onImage.size.width;
        }
        onImage = [self scaleToSize:onImage size:CGSizeMake(width, self.frame.size.height)];
        [self setProgressTintColorWithProgressTintImage:onImage];
    }
}

#pragma mark - -----------------------设置背景颜色---------------------------
-(void)setTrackTintColor:(UIColor *)trackTintColor{
    if (_trackImage) {
        //如果设置了背景图片，则忽略背景颜色
        return;
    }
    _trackTintColor = trackTintColor;
    if (!_trackTintColor) {
        _trackTintColor = [UIColor grayColor];
    }
    [self setNeedsDisplay];
}

-(void)setTrackTintColorWithTrackTintImage:(UIImage *)trackTintImage{
    _trackTintColor = [UIColor colorWithPatternImage:trackTintImage];;
    if (!_trackTintColor) {
        _trackTintColor = [UIColor grayColor];
    }
    [self setNeedsDisplay];
}

#pragma mark - ----------------------设置进度条颜色--------------------------
-(void)setProgressTintColor:(UIColor *)progressTintColor{
    if (_progressImage) {
        //如果设置了进度条图片,则忽略进度条颜色
        return;
    }
    _progressTintColor = progressTintColor;
    if (!_progressTintColor) {
        _progressTintColor = [UIColor blueColor];
    }
    [self setNeedsDisplay];
}

-(void)setProgressTintColorWithProgressTintImage:(UIImage *)progressTintImage{
    _progressTintColor = [UIColor colorWithPatternImage:progressTintImage];
    if (!_progressTintColor) {
        _progressTintColor = [UIColor blueColor];
    }
    [self setNeedsDisplay];
}
#pragma mark - -----------------------图片缩放-----------------------------
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(void)dealloc{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}


@end
