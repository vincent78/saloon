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

-(void) initWithImg:(UIView *)img withTxt1:(NSString *)txt1 withTxt2:(NSString *)txt2 withTxt3:(NSString *)txt3
{
    self.img = img;
    self.label1.text = txt1;
    self.label2.text = txt2;
    self.label3.text = txt3;
}

@end
