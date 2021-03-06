//
//  UILabel+fitSize.h
//  fertile_oc
//
//  Created by vincent on 15/12/17.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FTFitSize)

/**
 *  实际内容宽度
 *
 *  @return 返回lable显示全部内容需要的实际宽度
 */
- (CGFloat) ftContentWidth;

/**
 *  宽度固定的情况下，显示全部内容需要的宽度
 *
 *  @return 返回lable显示全部内容需要的实际高度
 */
- (CGFloat) ftContentHeight;

/**
 *  宽度自调整，注意如果textAlignment == UITextAlignmentRight，会调整x坐标，以保证右对齐；同理UITextAlignmentCenter
 *
 *  @return 调整后的宽度
 */
- (CGFloat) ftWidthToFit;

/**
 *  高度自调整，保持label宽度不变
 *
 *  @return 调整后的高度
 */
- (CGFloat) ftHeightToFit;

//裁剪字符串长度去适配宽度
- (void) ftClipLengthToFitWidth;

@end
