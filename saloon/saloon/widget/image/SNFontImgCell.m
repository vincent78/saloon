//
//  SNFontImgCell.m
//  saloon
//
//  Created by vincent on 16/1/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNFontImgCell.h"

@implementation SNFontImgCell



- (void)awakeFromNib {
    
}


-(CGSize) getCellSize
{
    return CGSizeMake(180, 80);
}


-(void) setFontFamily:(UIFont *)font withColor:(UIColor *)color
{
    self.fontImg.font = font;
    self.fontImg.textColor = color;
    [self.fontImg setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.fontImg setTextAlignment:NSTextAlignmentCenter];
    self.fontImg.numberOfLines = 1;
    self.fontImg.backgroundColor = [UIColor clearColor];
}

-(void) initWithImg:(NSString *)img withTxt1:(NSString *)txt1 withTxt2:(NSString *)txt2 withTxt3:(NSString *)txt3
{
    self.fontImg.text = img;
    self.label1.text = txt1;
    self.label2.text = txt2;
    self.label3.text = txt3;
}

@end
