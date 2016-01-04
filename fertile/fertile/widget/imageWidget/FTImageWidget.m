//
//  FTImageWidget.m
//  fertile
//
//  Created by vincent on 16/1/4.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTImageWidget.h"
#import "SDWebImageOperation.h"
#import "SDWebImageManager.h"

#define kCTImageViewAnimateTime 0.5

@interface FTImageWidget ()
@property (nonatomic, strong) id<SDWebImageOperation> operation;
@property (nonatomic, strong) NSArray *whiteList;
@end

@implementation FTImageWidget

@synthesize url = _url;

#pragma mark - 全局配置
/// 设置下载并行线程数
+ (void)setConcurrentDownloadThreadCount:(NSInteger)count
{
    [[[SDWebImageManager sharedManager] imageDownloader] setMaxConcurrentDownloads:count];
}

/// 清除所有图片缓存
+ (void)clearImageCache
{
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
}

#pragma mark - --------------------退出清空--------------------
- (void)dealloc
{
//    TLog(@"CTImageView dealloced.");
    _delegate = nil;
    [_operation cancel];
    _operation = nil;
}

#pragma mark - --------------------外部初始化--------------------
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseData];
        [self initBaseView];
        _showCompleteAnimation = YES;
    }
    return self;
}

- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage
{
    return [self initWithPlaceHoldImage:placeHoldImage delegate:nil];
}

- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage delegate:(id<FTImageWidgetDelegate>)aDelegate
{
    return [self initWithPlaceHoldImage:placeHoldImage url:nil delegate:aDelegate];
}

- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage urlString:(NSString *)urlString delegate:(id<FTImageWidgetDelegate>)aDelegate
{
    return [self initWithPlaceHoldImage:placeHoldImage url:[NSURL URLWithString:urlString] delegate:aDelegate];
}

- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage url:(NSURL *)url delegate:(id<FTImageWidgetDelegate>)aDelegate
{
    return [self initWithPlaceHoldImage:placeHoldImage loadNothingImage:nil loadFailedImage:nil url:url delegate:aDelegate];
}

- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage
            loadNothingImage:(UIImage *)loadNothingImage
             loadFailedImage:(UIImage *)loadFailedImage
                   urlString:(NSString *)urlString
                    delegate:(id<FTImageWidgetDelegate>)aDelegate
{
    return [self initWithPlaceHoldImage:placeHoldImage loadNothingImage:loadFailedImage loadFailedImage:loadFailedImage url:[NSURL URLWithString:urlString] delegate:aDelegate];
}

//所有的自定义 init 方法最终都会调这个。
- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage
            loadNothingImage:(UIImage *)loadNothingImage
             loadFailedImage:(UIImage *)loadFailedImage
                         url:(NSURL *)url
                    delegate:(id<FTImageWidgetDelegate>)aDelegate
{
    if (self = [super initWithImage:placeHoldImage]) {
        [self initBaseData];
        [self initBaseView];
        
        _placeHoldImage = placeHoldImage;
        _loadNothingImage = loadNothingImage;
        _loadFailedImage = loadFailedImage;
        _delegate = aDelegate;
        [self setUrl:url];
    }
    return self;
}

#pragma mark - 内部初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initBaseData];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseView];
}

- (void)initBaseData
{
    if ([UIScreen mainScreen].scale == 1 || [UIScreen mainScreen].bounds.size.height == 480) {
        self.lowMemoryDevice = YES;
        _showAnimation = NO;
    } else {
        self.showAnimation = YES;
    };
    [self loadStateImages];
}

- (void)initBaseView
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    if(self.showAnimation) {
        if (!_indicatorView) {
            _indicatorView = [[FTIndicatorWidget alloc] initWithActivityIndicatorStyle:FTIndicatorViewStyleSmall];
            
            _indicatorView.hidesWhenStopped = YES;
            
            NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
            [self addSubview:_indicatorView];
            [_indicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self addConstraints:[NSArray arrayWithObjects:centerX, centerY, nil]];
        }
        _indicatorView.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    }
}

- (void)loadStateImages
{
    if (!_placeHoldImage) {
        if (self.lowMemoryDevice) {
//            _placeHoldImage = [CTResizableImage imageNamedForCtrip:kCTResizableImageLoading targetSize:self.bounds.size showType:eCTResizableLoadImageShowTypeSmall];
        } else {
//            _placeHoldImage = [CTResizableImage animationImageNamedForCtrip:kCTResizableImageLoading targetSize:self.bounds.size showType:eCTResizableLoadImageShowTypeSmall];
        }
    }
    if (!_loadNothingImage) {
        if (self.lowMemoryDevice) {
//            _loadNothingImage = [CTResizableImage imageNamedForCtrip:kCTResizableImageLoadNothing targetSize:self.bounds.size showType:eCTResizableLoadImageShowTypeSmall];
        }
        else {
//            _loadNothingImage = [CTResizableImage animationImageNamedForCtrip:kCTResizableImageLoadNothing targetSize:self.bounds.size showType:eCTResizableLoadImageShowTypeSmall];
        }
    }
    if (!_loadFailedImage) {
        if (self.lowMemoryDevice) {
//            _loadFailedImage = [CTResizableImage imageNamedForCtrip:kCTResizableImageLoadFailed targetSize:self.bounds.size showType:eCTResizableLoadImageShowTypeSmall];
        }
        else {
//            _loadFailedImage = [CTResizableImage animationImageNamedForCtrip:kCTResizableImageLoadFailed targetSize:self.bounds.size showType:eCTResizableLoadImageShowTypeSmall];
        }
    }
}

#pragma mark - --------------------功能函数--------------------
- (NSArray *)whiteList
{
    return @[];
//     if (!_whiteList) {
//        NSMutableArray *array = [NSMutableArray arrayWithObject:@"images4.c-ctrip.com"];
//        for (NSInteger i = 1; i <= 20; i++) {
//            NSString *indexString = @(i).stringValue;
//            if(i < 10) {
//                indexString = [@"0" stringByAppendingString:indexString];
//            }
//            [array addObject:[NSString stringWithFormat:@"dimg%@.c-ctrip.com", indexString]];
//        }
//        _whiteList = [NSArray arrayWithArray:array];
//    }
//    
//    return _whiteList;
}

- (NSURL *)url
{
    NSString *urlHostString = _url.absoluteString;
    if ([self.whiteList containsObject:urlHostString] && ![_url.absoluteString hasSuffix:@"_.webp"]) {//必须在白名单中且不是webp的url
        return [NSURL URLWithString:[_url.absoluteString stringByAppendingString:@"_.webp"]];
    } else {
        return _url;
    }
}
/// 下载入口
- (void)setUrl:(NSURL *)url
{
    if (_url) {//CTImageView 可能被复用，所以必须做清理。
        [self cancelDownloadAction];
        _url = nil;
    }
    
    if (!url) {
        [self setLoadNothing];
        return;
    }
    
    _url = [url copy];
    if (self.placeHoldImage) {
        self.image = self.placeHoldImage;
    }
    
    [self cancelDownloadAction];
    [self startAnimate];
    if (self.showAnimation) {
        _indicatorView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    }
    
    __weak __typeof(self) weakSelf = self;
    self.operation = [[SDWebImageManager sharedManager] downloadImageWithURL:self.url options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf downloadDidProgressWithURL:weakSelf.url receivedBytes:receivedSize totalBytes:expectedSize];
        });
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf downloadDidCompleteWithURL:imageURL image:image];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf downloadDidFailWithURL:imageURL error:error];
                });
            }
        }
    }];
}

/// 取消当前对象下载任务
- (void)cancelDownloadAction
{
    [self.operation cancel];
    self.operation = nil;
}

/// 开始转圈
- (void)startAnimate
{
    self.showingAnimation = YES;
    if (self.showAnimation) {
        [_indicatorView startAnimating];
    }
}

/// 停止转圈
- (void)stopAnimate
{
    self.showingAnimation = NO;
    [_indicatorView stopAnimating];
}

/// 设置暂无图片状态
- (void)setLoadNothing
{
    if (self.loadNothingImage) {
        self.image = self.loadNothingImage;
    }
    
    if (self.showAnimation) {
        [self stopAnimate];
    }
    
    [self animateShowingImage];
}

/// 设置加载失败状态
- (void)setLoadFailed
{
    if (self.loadFailedImage) {
        self.image = self.loadFailedImage;
    }
    
    [self stopAnimate];
    [self animateShowingImage];
}

/// 切换图片动画
- (void)animateShowingImage
{
    //animation 非阻塞
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:[NSNumber numberWithFloat:0.0]];
    [animation setToValue:[NSNumber numberWithFloat:1.0]];
    [animation setDuration:kCTImageViewAnimateTime];
    
    [self.layer addAnimation:animation forKey:@"fade_in"];
}

#pragma mark - CTImageViewDownloadDelegate
- (void)downloadDidProgressWithURL:(NSURL *)url receivedBytes:(NSUInteger)receivedBytes totalBytes:(long long)totalBytes
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewProgressed:receivedBytes:totalBytes:)]) {
        [self.delegate imageViewProgressed:self receivedBytes:receivedBytes totalBytes:totalBytes];
    }
}

- (void)downloadDidCompleteWithURL:(NSURL *)url image:(UIImage *)image
{
    self.image = image;
    [self stopAnimate];
    if (self.isShowCompleteAnimation) {
        [self animateShowingImage];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewLoadImageSucceed:)]) {
        [self.delegate imageViewLoadImageSucceed:self];
    }
}

- (void)downloadDidFailWithURL:(NSURL *)url error:(NSError *)error
{
    [self stopAnimate];
    [self setLoadFailed];
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewLoadImageFailed:error:)]) {
        [self.delegate imageViewLoadImageFailed:self error:[NSError errorWithDomain:@"CTImageViewDownload Failed" code:-401 userInfo:nil]];
    }
}

@end
