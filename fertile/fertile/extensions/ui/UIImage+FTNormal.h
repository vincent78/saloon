//
//  UIImage+normal.h
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FTNormal)

/**
 *  @brief 将图片写入文件
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) writeToFile:(NSString *)filePath;

/**
 *  @brief 变换图片的大小
 *
 *  @param newSize <#newSize description#>
 *  @param quality <#quality description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;


/**
 *  创建指定颜色1px图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)ctd_imageWithColor:(UIColor *)color;

+ (UIImage *)ctd_imageWithColorAndSize:(UIColor *)color imageSize:(CGSize)size;



/**
 *  改变图片颜色
 *
 *  @param tintColor 目标颜色
 *
 *  @return 改变颜色后的图片对象
 */
- (UIImage *)ctd_imageWithTintColor:(UIColor *)tintColor;

/**
 *UIImage *imageToCrop = <yourImageToCrop>;
 *CGRect cropRect = <areaYouWantToCrop>;
 *
 *UIImage *croppedImage = [imageToCrop crop:cropRect];
 */
- (UIImage *)crop:(CGRect)rect;



-(UIImage*)resizedImageToSize:(CGSize)dstSize;

-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize
                    scaleIfSmaller:(BOOL)scale;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;



@end
