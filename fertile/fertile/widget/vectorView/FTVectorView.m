//
//  FTBaseVectorView.m
//  fertile_oc
//
//  Created by vincent on 15/11/3.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTVectorView.h"

@interface FTVectorView ()

@property (strong, nonatomic) UILabel* vectorLabel;
@property (strong, nonatomic) UIFont* vectorLabelFont;

@end

@implementation FTVectorView

@synthesize fontColor;
@synthesize fontContentSize;
@synthesize fontName;
@synthesize fontFamily;

- (id)initWithFrame:(CGRect)frame
     fontFamilyName:(NSString*)fontFamily1
           fontName:(NSString*)fontName1
{
    self = [self initWithFrame:frame];
    if (self) {
        self.fontFamily = fontFamily1;
        self.fontName = fontName1;
        self.autoSizable = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
     fontFamilyName:(NSString*)fontFamily1
           fontName:(NSString*)fontName1
          fontColor:(UIColor *)fontColor1
{
    self = [self initWithFrame:frame fontFamilyName:fontFamily1 fontName:fontName1];
    if (self) {
        self.fontColor = fontColor1;
    }
    return self;
}


- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];

        self.autoSizable = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    if (!self.vectorLabel) {
        self.vectorLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.vectorLabel setBackgroundColor:[UIColor clearColor]];
        [self.vectorLabel fillInView:self];
        [self.vectorLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.vectorLabel setTextAlignment:NSTextAlignmentCenter];
        self.vectorLabel.numberOfLines = 1;
        self.vectorLabel.font = self.vectorLabelFont;
        self.backgroundColor = [UIColor clearColor];
        [self setClipsToBounds:YES];
    }
}

- (void)setFontColor:(UIColor*)color1
{
    fontColor = color1;
    [self.vectorLabel setTextColor:fontColor];
}

- (UIColor*)fontColor
{
    return fontColor;
}

- (CGFloat)fontContentSize
{
    CGRect bounds = self.bounds;
    fontContentSize = bounds.size.width > bounds.size.height ? bounds.size.height : bounds.size.width;
    return fontContentSize;
}

- (UIFont*)vectorLabelFont
{
    _vectorLabelFont = [UIFont fontWithName:self.fontFamily size:self.fontContentSize];
    return _vectorLabelFont;
}

- (void)setFontFamily:(NSString*)fontFamily1
{
    fontFamily = fontFamily1;
    [self.vectorLabel setFont:self.vectorLabelFont];
}

- (NSString*)fontFamily
{
    if (fontFamily == nil || [fontFamily isEqualToString:@""]) {
        fontFamily = MainFontFileNameForVectorLabel;
    }
    return fontFamily;
}

- (void)autoSizeToFit
{
    [self.vectorLabel addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)cancelAutoSizeToFit
{
    [self.vectorLabel removeObserver:self forKeyPath:@"bounds"];
}

- (void)dealloc
{
    self.autoSizable = NO;
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if (self.vectorLabel.text == nil) {
        return;
    }
    NSValue* boundsValue = [change objectForKey:@"new"];
    CGRect bounds = [boundsValue CGRectValue];

    if (CGRectEqualToRect(bounds, CGRectNull) || CGRectEqualToRect(bounds, CGRectInfinite)) {
        return;
    }

    fontContentSize = bounds.size.width > bounds.size.height ? bounds.size.height : bounds.size.width;
    [self.vectorLabel setFont:self.vectorLabelFont];
}

- (void)setFontName:(NSString*)fontName1
{
    fontName = fontName1;
    self.vectorLabel.text = fontName1;
}

- (NSString*)fontName
{
    return fontName;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.vectorLabel setFont:self.vectorLabelFont];
}

#pragma mark----autosizable------
- (void)setAutoSizable:(BOOL)autoSizable
{
    if (autoSizable == YES) {
        if (self.autoSizable != YES) {
            [self autoSizeToFit];
        }
    }
    else {
        if (self.autoSizable == YES) {
            [self cancelAutoSizeToFit];
        }
    }
    _autoSizable = autoSizable;
}

//-(UIImage*)toImage
//{
//    CGSize imageSize = self.bounds.size;
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
//    [self.vectorLabel.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
//    return retImage;
//}


@end
