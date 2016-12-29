//
//  UIButton+image.m
//  fertile
//
//  Created by vincent on 2016/12/29.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "UIButton+image.h"

@implementation UIButton (image)

- (void)setStretchableImage
{
    UIImage* imageNormal = [self backgroundImageForState:UIControlStateNormal] ;
    UIImage* imageHighlighted = [self backgroundImageForState:UIControlStateHighlighted] ;
    UIImage* imageSelected = [self backgroundImageForState:UIControlStateSelected] ;
    UIImage* imageDisabled = [self backgroundImageForState:UIControlStateDisabled] ;
    
    if (imageNormal!=nil) {
        imageNormal = [imageNormal stretchableImageWithLeftCapWidth:(int)(imageNormal.size.width/2)
                                                       topCapHeight:(int)(imageNormal.size.height/2)] ;
        [self setBackgroundImage:imageNormal forState:UIControlStateNormal] ;
    }
    if (imageHighlighted!=nil) {
        imageHighlighted = [imageHighlighted stretchableImageWithLeftCapWidth:(int)(imageHighlighted.size.width/2)
                                                                 topCapHeight:(int)(imageHighlighted.size.height/2)] ;
        [self setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted] ;
    }
    if (imageSelected!=nil) {
        imageSelected = [imageSelected stretchableImageWithLeftCapWidth:(int)(imageSelected.size.width/2)
                                                           topCapHeight:(int)(imageSelected.size.height/2)] ;
        [self setBackgroundImage:imageSelected forState:UIControlStateSelected] ;
    }
    if (imageDisabled!=nil) {
        imageDisabled = [imageDisabled stretchableImageWithLeftCapWidth:(int)(imageHighlighted.size.width/2)
                                                           topCapHeight:(int)(imageHighlighted.size.height/2)] ;
        [self setBackgroundImage:imageDisabled forState:UIControlStateDisabled] ;
    }
}

@end
