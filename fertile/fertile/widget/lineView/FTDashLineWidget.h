//
//  FTDashLineWidget.h
//  fertile_oc
//
//  Created by vincent on 15/12/17.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"

@interface FTDashLineWidget : FTBaseWidget


// 线宽，默认值是CTOnePixelLineHeight
@property (nonatomic, assign) CGFloat lineWidth;

// 填充色 无默认值
@property (nonatomic, strong) UIColor *strokeColor;

// 长度数组 ,无默认值, 格式{@"x", @"y",...}
// 比如{@"5", @"1"} 表示绘制5像素，跳过1像素。
// 不一定是2个元素，总之一个用于绘制，下一个用于跳过。
@property (nonatomic, strong) NSArray *lengths;


//使用默认的颜色和lenghts显示
- (void)setDefaultDisply;

@end
