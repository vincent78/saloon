//
//  FTIndicatorWidget.h
//  fertile
//
//  Created by vincent on 16/1/4.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTBaseWidget.h"

typedef NS_ENUM(NSInteger, FTIndicatorViewStyle) {
    FTIndicatorViewStyleBig,
    FTIndicatorViewStyleSmall,
};

@interface FTIndicatorWidget : FTBaseWidget

- (instancetype)initWithActivityIndicatorStyle:(FTIndicatorViewStyle)style;
@property(nonatomic) FTIndicatorViewStyle activityIndicatorViewStyle;
@property(nonatomic) BOOL  hidesWhenStopped;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
