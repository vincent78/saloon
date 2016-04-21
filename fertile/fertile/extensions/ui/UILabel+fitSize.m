//
//  UILabel+fitSize.m
//  fertile_oc
//
//  Created by vincent on 15/12/17.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "UILabel+fitSize.h"

@implementation UILabel (fitSize)

/**
 *  实际内容宽度
 *
 *  @return 返回lable显示全部内容需要的实际宽度
 */
- (CGFloat) ftContentWidth
{
    if (self.text.length==0)
    {
        return 0;
    }
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    return ceilf(size.width) ;
}
/**
 *  宽度固定的情况下，显示全部内容需要的宽度
 *
 *  @return 返回lable显示全部内容需要的实际高度
 */
- (CGFloat) ftContentHeight
{
    if (self.text.length==0)
    {
        return 0;
    }
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    return ceilf(size.height);
}

/**
 *  宽度自调整，注意如果textAlignment == UITextAlignmentRight，会调整x坐标，以保证右对齐；同理UITextAlignmentCenter
 *
 *  @return 调整后的宽度
 */
- (CGFloat) ftWidthToFit
{
    CGRect rect = self.frame;
    CGFloat xOffset = rect.origin.x;
    if (self.textAlignment == NSTextAlignmentRight)
    {
        xOffset += rect.size.width;
    }
    else if (self.textAlignment == NSTextAlignmentCenter)
    {
        xOffset += (rect.size.width / 2.0);
    }
    
    rect.size.width = [self ftContentWidth];
    if (self.textAlignment == NSTextAlignmentRight)
    {
        rect.origin.x = xOffset-rect.size.width ;
    }
    else if (self.textAlignment == NSTextAlignmentCenter)
    {
        rect.origin.x = xOffset-(rect.size.width/2.0) ;
    }
    else
    {
        rect.origin.x = xOffset ;
    }
    self.frame = rect ;
    return rect.size.width ;
}
/**
 *  高度自调整，保持label宽度不变
 *
 *  @return 调整后的高度
 */
- (CGFloat) ftHeightToFit {
    //调整高度，需要把这个设置一下，不然万一不是0，调整无效
    if(self.numberOfLines!=0)
    {
        self.numberOfLines = 0 ;
    }
    self.ftHeight = [self ftContentHeight] ;
    return self.ftHeight ;
}

//裁剪字符串长度去适配宽度
- (void) ftClipLengthToFitWidth {
    while (self.ftContentWidth>self.ftWidth) {
        self.text = [self.text substringToIndex:self.text.length-1] ;
    }
}

@end
