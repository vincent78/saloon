//
//  FTCornerView.h
//  fertile_oc
//
//  Created by vincent on 15/12/8.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"

typedef NS_OPTIONS(NSUInteger, FTCornerType) {
    FTCornerTypeNone                = 0,
    FTCornerTypeTopLeft             = 1 << 0,
    FTCornerTypeTopRight            = 1 << 1,
    FTCornerTypeDownLeft            = 1 << 2,
    FTCornerTypeDownRight           = 1 << 3,
    FTCornerTypeAll                 = 1 << 4,
};

@interface FTCornerView : FTBaseWidget

@property (nonatomic, assign) FTCornerType cornerType;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *topLineColor;
@property (nonatomic, strong) UIColor *bottomLineColor;

- (instancetype)initWithFrame:(CGRect)frame
                    fillColor:(UIColor *)fillColor
                   cornerType:(FTCornerType)cornerType
                       radius:(CGFloat)radius;
@end
