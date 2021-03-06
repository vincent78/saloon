//
//  SNFontImgCell.h
//  saloon
//
//  Created by vincent on 16/1/18.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNFontImgCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UIImageView *iconImg;



-(CGSize) getCellSize;
-(void) initWithImg:(NSString *)img withTxt1:(NSString *)txt1 withTxt2:(NSString *)txt2 withTxt3:(NSString *)txt3;
-(void) setFontFamily:(NSString *)font withColor:(UIColor *)color;


@end
