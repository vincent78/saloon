//
//  UIView+normal.m
//  fertile_oc
//
//  Created by vincent on 15/10/26.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "UIView+FTNormal.h"

@implementation UIView (FTNormal)

- (void)setFtHeight:(CGFloat)ftHeight {
  CGRect frame = self.frame;
  frame.size.height = ftHeight;
  self.frame = frame;
}
- (void)setFtWidth:(CGFloat)ftWidth {
  CGRect frame = self.frame;
  frame.size.width = ftWidth;
  self.frame = frame;
}

- (void)setFtLeft:(CGFloat)ftLeft {
  CGRect frame = self.frame;
  frame.origin.x = ftLeft;
  self.frame = frame;
}

- (void)setFtRight:(CGFloat)ftRight {
  CGRect frame = self.frame;
  frame.origin.x = ftRight - frame.size.width;
  self.frame = frame;
}

- (void)setFtBottom:(CGFloat)ftBottom {
  CGRect frame = self.frame;
  frame.origin.y = ftBottom - frame.size.height;
  self.frame = frame;
}

- (void)setFtTop:(CGFloat)ftTop {
  CGRect frame = self.frame;
  frame.origin.y = ftTop;
  self.frame = frame;
}
- (void)setFtSize:(CGSize)ftSize {
  CGRect frame = self.frame;
  frame.size = ftSize;
  self.frame = frame;
}
- (void)setFtOrigin:(CGPoint)ftOrigin {
  CGRect frame = self.frame;
  frame.origin = ftOrigin;
  self.frame = frame;
}
- (CGFloat)ftLeft {
  return self.frame.origin.x;
}
- (CGFloat)ftTop {
  return self.frame.origin.y;
}
- (CGFloat)ftHeight {
  return self.frame.size.height;
}
- (CGFloat)ftWidth {
  return self.frame.size.width;
}
- (CGSize)ftSize {
  return self.frame.size;
}
- (CGPoint)ftOrigin {
  return self.frame.origin;
}
- (CGFloat)ftRight {
  return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)ftBottom {
  return self.frame.origin.y + self.frame.size.height;
}

- (void)setViewHeight:(CGFloat)height {
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

- (void)showBorderWithColor:(UIColor *)color {
#ifdef DEBUG
  self.layer.borderWidth = 1;
  self.layer.borderColor = color.CGColor;
#endif
}




- (void)removeAllSubView {
  NSArray *arraySubView = [NSArray arrayWithArray:self.subviews];
  for (UIView *subView in arraySubView) {
    if (subView.subviews.count != 0) {
      [subView removeAllSubView];
    }
    [subView removeFromSuperview];
  }
}

- (void)printPosition {
  CGRect myFrame = self.frame;
  NSLog(@"Origin: (%.0f,%.0f), Width: %.0f, Height: %.0f", myFrame.origin.x,
        myFrame.origin.y, myFrame.size.width, myFrame.size.height);
}

- (void)moveRightToParentWithPadding:(CGFloat)padding {
  if (self.superview == nil) {
    return;
  }

  CGRect myFrame = self.frame;
  myFrame.origin.x =
      self.superview.frame.size.width - myFrame.size.width - padding;

  self.frame = myFrame;
}



+ (instancetype)extractFromXib {
    NSString *viewName = NSStringFromClass([self class]);
    NSArray *views =
    [[NSBundle mainBundle] loadNibNamed:viewName owner:nil options:nil];
    Class targetClass = NSClassFromString(viewName);
    
    for (UIView *view in views) {
        if ([view isMemberOfClass:targetClass]) {
            return view;
        }
    }
    
    return nil;
}


- (instancetype) viewWithXibNamed:(NSString*) xibName owner:(id)owner
{
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:xibName owner:owner options:nil] ;
    if (views.count>0) {
        for (UIView* view in views) {
            if ([view isKindOfClass:self.class]) {
                return view;
            }
        }
    }
    return nil ;
}

- (instancetype) viewFromClassXibWithOwner:(id)owner
{
    return [self viewWithXibNamed:NSStringFromClass(self.class) owner:owner] ;
}


-(void) removeSubViewByTag:(int)tag
{
    
    for (UIView *subView in self.subviews)
    {
        if (subView.tag == tag)
        {
            [subView removeFromSuperview];
            return;
        }
    }
}


- (UIImage *) getImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnailImage;
}


@end
