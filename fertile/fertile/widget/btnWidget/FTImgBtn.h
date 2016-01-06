//
//  FTImgBtn.h
//  fertile_oc
//
//  Created by vincent on 15/11/5.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTImgBtn : UIButton

/**
 *  @brief  唯一标识
 */
@property (nonatomic,strong) NSString *key;

@property(nonatomic,copy) NSString *fontName;

@property(nonatomic,copy) NSString *imgName;

@property(nonatomic,copy) UIColor *normalColor;

@property(nonatomic,copy) UIColor *highlightColor;

//@property (nonatomic)

-(instancetype) initWithFrame:(CGRect)frame withKey:(NSString *)key;



@end
