//
//  FTImageWidget.h
//  fertile
//
//  Created by vincent on 16/1/4.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"
#import "FTIndicatorWidget.h"


/// 图片下载虚基类，子类可自由覆盖
@protocol FTImageViewDownloadProtocol <NSObject>
@optional
- (void)downloadDidProgressWithURL:(NSURL *)url receivedBytes:(NSUInteger)receivedBytes totalBytes:(long long)totalBytes;
- (void)downloadDidCompleteWithURL:(NSURL *)url image:(UIImage *)image;
- (void)downloadDidFailWithURL:(NSURL *)url error:(NSError *)error;
@end


@class FTIndicatorWidget;
@protocol FTImageWidgetDelegate;

@interface FTNetImageWidget : UIImageView<FTImageViewDownloadProtocol>


@property (nonatomic, weak) id<FTImageWidgetDelegate> delegate;/// 代理
@property (nonatomic, copy) NSURL *url;/// 图片 url

@property (assign, nonatomic) BOOL lowMemoryDevice;/// 设备类型
@property (nonatomic,assign)BOOL showAnimation;/// 是否展示动画
@property (nonatomic, getter=isShowingAnimation, assign) BOOL showingAnimation;/// 正在显示动画
@property (nonatomic, getter=isShowCompleteAnimation, assign) BOOL showCompleteAnimation;//是否调用下载完成图片切换动画，默认YES

@property (nonatomic, strong) UIImage *placeHoldImage;/// image placeholder,图片下载完成之前显示
@property (nonatomic, strong) UIImage *loadNothingImage;/// url 为空时显示的图片
@property (nonatomic, strong) UIImage *loadFailedImage;/// 下载失败显示的图片

@property (nonatomic, strong) FTIndicatorWidget *indicatorView;/// 加载指示器

#pragma mark - 全局配置
/**
 * @brief 设置下载并行线程数
 * @param count 并行线程数
 */
+ (void)setConcurrentDownloadThreadCount:(NSInteger)count;

/**
 * @brief 清除所有图片缓存
 */
+ (void)clearImageCache;

#pragma mark - 初始化
/**
 * @brief 初始化方法
 * @param frame imageView 的 frame
 * @return FTImageView对象
 */
- (id)initWithFrame:(CGRect)frame;

/**
 * @brief 初始化方法
 * loadNothingImage = nil,loadFailedImage = nil; urlString = nil; delegate = nil;
 * @param placeHoldImage 加载等待图片
 * @return FTImageView对象
 */
- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage;

/**
 * @brief 初始化方法
 * loadNothingImage = nil,loadFailedImage = nil; urlString = nil;
 * @param placeHoldImage 加载等待图片
 * @param delegate 下载代理对象
 * @return FTImageView对象
 */
- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage delegate:(id<FTImageWidgetDelegate>)aDelegate;

/**
 * @brief 初始化方法，这个方法会在 6.5 中废弃
 * loadNothingImage = nil,loadFailedImage = nil;
 * @param placeHoldImage 加载等待图片
 * @param urlString 下载地址
 * @param delegate 下载代理对象
 * @return FTImageView对象
 */
- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage
                   urlString:(NSString *)urlString
                    delegate:(id<FTImageWidgetDelegate>)aDelegate DEPRECATED_ATTRIBUTE;

/**
 * @brief 初始化方法
 * loadNothingImage = nil,loadFailedImage = nil;
 * @param placeHoldImage 加载等待图片
 * @param url 下载地址
 * @param delegate 下载代理对象
 * @return FTImageView对象
 */
- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage
                         url:(NSURL *)url
                    delegate:(id<FTImageWidgetDelegate>)aDelegate;

/**
 * @brief 初始化方法
 * @param placeHoldImage 加载等待图片
 * @param loadNothingImage 暂无图片
 * @param loadFailedImage 加载失败图片
 * @param urlString 下载地址
 * @param delegate 下载代理
 * @return FTImageView对象
 */
- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage
            loadNothingImage:(UIImage *)loadNothingImage
             loadFailedImage:(UIImage *)loadFailedImage
                   urlString:(NSString *)urlString
                    delegate:(id<FTImageWidgetDelegate>)aDelegate DEPRECATED_ATTRIBUTE;

/**
 * @brief 初始化方法
 * @param placeHoldImage 加载等待图片
 * @param loadNothingImage 暂无图片
 * @param loadFailedImage 加载失败图片
 * @param url 下载地址
 * @param delegate 下载代理
 * @return FTImageView对象
 */
- (id)initWithPlaceHoldImage:(UIImage *)placeHoldImage
            loadNothingImage:(UIImage *)loadNothingImage
             loadFailedImage:(UIImage *)loadFailedImage
                         url:(NSURL *)url
                    delegate:(id<FTImageWidgetDelegate>)aDelegate;

#pragma mark -
/**
 初始化数据
 */
- (void)initBaseData;
- (void)loadStateImages;
/**
 初始化视图
 */
- (void)initBaseView;

/**
 手动开始转圈
 */
- (void)startAnimate;
/**
 手动停止转圈
 */
- (void)stopAnimate;
/**
 设置为暂无图片状态
 */
- (void)setLoadNothing;
/**
 设置为加载失败状态
 */
- (void)setLoadFailed;
/**
 切换图片动画
 */
- (void)animateShowingImage;

/**
 * @brief 取消当前对象下载任务
 */
- (void)cancelDownloadAction;

@end


/// @brief FTImageView代理协议
@protocol FTImageWidgetDelegate <NSObject>
@optional
/**
 * @brief 下载成功回调
 * @param imageView FTImageView对象
 */
- (void)imageViewLoadImageSucceed:(FTNetImageWidget *)imageView;

/**
 * @brief 下载进度更新回调
 * @param imageView FTImageView对象
 * @param receivedBytes 接收字节数
 * @param totalBytes 总共字节数
 */
- (void)imageViewProgressed:(FTNetImageWidget *)imageView receivedBytes:(NSUInteger)receivedBytes totalBytes:(long long)totalBytes;

/**
 * @brief 下载失败回调
 * @param imageView FTImageView对象
 * @param error 错误对象
 */
- (void)imageViewLoadImageFailed:(FTNetImageWidget *)imageView error:(NSError *)error;

/**
 * @brief 下载取消回调
 * @param imageView FTImageView对象
 */
- (void)imageViewLoadImageCanceled:(FTNetImageWidget *)imageView;
@end
