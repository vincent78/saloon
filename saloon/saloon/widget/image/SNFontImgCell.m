//
//  SNFontImgCell.m
//  saloon
//
//  Created by vincent on 16/1/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNFontImgCell.h"
#import "UIImage+font.h"

@interface SNFontImgCell()
{
    NSString *fontFamily;
    UIColor *textColor;
    UIColor *bkColor;
}

@end

@implementation SNFontImgCell



- (void)awakeFromNib {
    [super awakeFromNib];
}


-(CGSize) getCellSize
{
    return CGSizeMake(180, 80);
}


-(void) setFontFamily:(NSString *)fontFamily1 withColor:(UIColor *)color1
{
    fontFamily = fontFamily1;
    textColor = color1;
    bkColor = [UIColor clearColor];
}

-(void) initWithImg:(NSString *)img withTxt1:(NSString *)txt1 withTxt2:(NSString *)txt2 withTxt3:(NSString *)txt3
{
    self.iconImg.image = [[UIImage alloc] initWithText:img withFontFamilyName:fontFamily withSize:self.iconImg.bounds.size withColor:textColor];
    self.label1.text = txt1;
    self.label2.text = txt2;
    self.label3.text = txt3;
}


@end
