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
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 按指定大小和颜色创建图片

 @param color <#color description#>
 @param size  <#size description#>

 @return <#return value description#>
 */
+ (UIImage *)imageWithColorAndSize:(UIColor *)color imageSize:(CGSize)size;



/**
 *  改变图片颜色
 *
 *  @param tintColor 目标颜色
 *
 *  @return 改变颜色后的图片对象
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;




-(UIImage*)resizedImageToSize:(CGSize)dstSize;

-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize
                    scaleIfSmaller:(BOOL)scale;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;

/**
 图片裁剪
 
 *UIImage *imageToCrop = <yourImageToCrop>;
 *CGRect cropRect = <areaYouWantToCrop>;
 *
 *UIImage *croppedImage = [imageToCrop crop:cropRect];
 */
- (UIImage *)crop:(CGRect)rect;


/**
 图片裁剪

 @param superImage <#superImage description#>
 @param subImageRect <#subImageRect description#>
 @return <#return value description#>
 */
+(UIImage *)getImageFromImage:(UIImage*)superImage subImageRect:(CGRect)subImageRect;


/**
 图片合并

 @param image1 <#image1 description#>
 @param image2 <#image2 description#>
 @param targetRect <#targetRect description#>
 @return <#return value description#>
 */
+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 withRect:(CGRect)targetRect;



@end
