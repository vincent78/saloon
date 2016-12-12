//
//  FTVectorButton.m
//  fertile
//
//  Created by vincent on 2016/12/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTVectorButton.h"


@interface FTVectorButton()
@property (strong, nonatomic) UIColor *normalStateColor;
@property (copy, nonatomic) NSString *normalStateName;

@property (strong, nonatomic) UIColor *highlightedStateColor;
@property (copy, nonatomic) NSString *highlightedStateName;

@property (strong, nonatomic) UIColor *selectedStateColor;
@property (copy, nonatomic) NSString *selectedStateName;

@property (strong, nonatomic) UIColor *disabledStateColor;
@property (copy, nonatomic) NSString *disabledStateName;

//图文混排之后，相应的缩小之后的imagesize
@property (assign, nonatomic) int adapterImageSize;
//图文混排之后，textsize
@property (assign, nonatomic) int textSize;
@property (copy, nonatomic) NSString *text;
//为toUIImage的时候准备的随scale放大的NSAttributedString
@property (copy, nonatomic) NSAttributedString *scaleAttrutedString;


@end

@implementation FTVectorButton
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoSizable = YES;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.autoSizable = YES;
    }
    return self;
}

#pragma mark -----new interface------

-(void)setVectorFontFamliyNameWith:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode
{
    [self setVectorFontFamliyNameWith:iconFontFamliyName imageCode:imageCode forState:UIControlStateNormal];
}


-(void)setVectorFontFamliyNameWith:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode forState:(UIControlState)state
{
    [self setVectorFontFamliyName:FT_FONT_FAMLIY_NAME_ARRAY[iconFontFamliyName] imageCode:imageCode forState:state];
}

-(void)setVectorFontFamliyName:(NSString*)fontFamily imageCode:(NSString *)imageCode
{
    [self setVectorFontFamliyName:fontFamily imageCode:imageCode forState:UIControlStateNormal];
}

-(void)setVectorFontFamliyName:(NSString*)fontFamily imageCode:(NSString *)imageCode forState:(UIControlState)state
{
    [self setVectorImageName:[NSString stringWithFormat:@"%@*_|_*%@*_|_*new",fontFamily,imageCode] forState:state];
}

-(void)setVectorFontFamliyNameWith:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode imageText:(NSString*)text textSize:(NSInteger)textSize forState:(UIControlState)state{
    
    [self setVectorFontFamliyName:FT_FONT_FAMLIY_NAME_ARRAY[iconFontFamliyName] imageCode:imageCode imageText:text textSize:textSize forState:state];
}


-(void)setVectorFontFamliyName:(NSString*)fontFamily imageCode:(NSString *)imageCode imageText:(NSString*)text textSize:(NSInteger)textSize forState:(UIControlState)state{
    
    [self setVectorImageName:[NSString stringWithFormat:@"%@*_|_*%@*_|_*new*_|_*%@*_|_*%ld",fontFamily,imageCode,text,textSize] forState:state];
}


#pragma mark -----set color for state------

-(void)setAnyVectorColor:(UIColor *)color forState:(UIControlState)state {
    
    
    if (self.text){
        
        NSMutableAttributedString *mabs = [[NSMutableAttributedString alloc]initWithAttributedString: [self attributedTitleForState:state]];
        
        if (mabs){
            
            [mabs addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [mabs length])];
            
            [self setAttributedTitle:mabs forState:state];
        }
        
    }else{
        [self setTitleColor:color forState:state];
    }
    
}

-(void)setNormalStateColor:(UIColor *)normalStateColor {
    _normalStateColor = normalStateColor;
    [self setAnyVectorColor:_normalStateColor forState:UIControlStateNormal];
}
-(void)setHighlightedStateColor:(UIColor *)normalStateColor {
    _highlightedStateColor = normalStateColor;
    [self setAnyVectorColor:_highlightedStateColor forState:UIControlStateHighlighted];
}
-(void)setSelectedStateColor:(UIColor *)selectedStateColor {
    _selectedStateColor = selectedStateColor;
    [self setAnyVectorColor:_selectedStateColor forState:UIControlStateSelected];
}
-(void)setDisabledStateColor:(UIColor *)disabledStateColor {
    _disabledStateColor = disabledStateColor;
    [self setAnyVectorColor:_disabledStateColor forState:UIControlStateDisabled];
}

-(void)setVectorImageColor:(UIColor *)color forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
        self.normalStateColor = color;
        break;
        case UIControlStateHighlighted:
        self.highlightedStateColor = color;
        break;
        case UIControlStateSelected:
        self.selectedStateColor = color;
        break;
        case UIControlStateDisabled:
        self.disabledStateColor = color;
        break;
        default:
        break;
    }
}

#pragma mark -----set imagename for state------
-(void)setAnyVectorName:(NSString *)imageName forState:(UIControlState)state {
    if (imageName == nil||[imageName isEqualToString:@""]) {
        return;
    }
    
    NSDictionary *dic = [self analysisImageName:imageName];
    if (dic) {
        NSString *fontFamilyName = [dic objectForKey:@"fontFamilyName"];
        NSString *fontName = [dic objectForKey:@"fontName"];
        CGFloat size;
        if (self.autoSizable == NO) {
            size = self.imageSize;
        }
        else {
            size = self.frame.size.width > self.frame.size.height ? self.frame.size.height:self.frame.size.width;
            _imageSize = size;
        }
        UIFont *font = [UIFont fontWithName:fontFamilyName size:size];
        self.titleLabel.font = font;
        
        NSString *text = [dic objectForKey:@"text"];
        
        if (text){
            
            int imageSize = size;
            
            self.text = text;
            
            int fontSize = [[dic objectForKey:@"textSize"] intValue];
            
            if (fontSize == 0){
                fontSize = 10;
            }
            
            if ([self.text containsString:@"\n"]){
                
                imageSize -= fontSize;
                
            }else{
                
                imageSize -= fontSize * self.text.length;
            }
            
            self.adapterImageSize = imageSize;
            
            self.textSize = fontSize;
            
            //图片和文字混排的情况
            self.titleLabel.numberOfLines = 0;
            
            NSMutableAttributedString *tmp = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", fontName, text]];
            
            //换行情况下要居中
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            //生成图片的时候也要能够居中
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:1.5]; //调整行间距
            [paragraphStyle setAlignment:NSTextAlignmentCenter];
            [tmp addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tmp length])];
            
            
            [tmp addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontFamilyName size:imageSize] range:NSMakeRange(0, [fontName length])];
            
            [tmp addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange([fontName length], tmp.length - [fontName length])];
            
            
            [self setAttributedTitle:tmp forState:state];
            
            CGFloat scale = [UIScreen mainScreen].scale;
            
            NSMutableAttributedString *tmp2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", fontName, text]];
            [tmp2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tmp2 length])];
            [tmp2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontFamilyName size:imageSize * scale] range:NSMakeRange(0, [fontName length])];
            
            [tmp2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize * scale] range:NSMakeRange([fontName length], tmp2.length - [fontName length])];
            
            self.scaleAttrutedString = tmp2;
            
        }else{
            
            //只有图形的情况
            [self setTitle:fontName forState:state];
            
        }
        
        
        
    }
}



-(void)setNormalStateName:(UIColor *)normalStateName {
    _normalStateName = [normalStateName copy];
    [self setAnyVectorName:_normalStateName forState:UIControlStateNormal];
}
-(void)setHighlightedStateName:(UIColor *)highlightedStateName {
    _highlightedStateName = [highlightedStateName copy];
    [self setAnyVectorName:_highlightedStateName forState:UIControlStateHighlighted];
}
-(void)setSelectedStateName:(UIColor *)selectedStateName {
    _selectedStateName = [selectedStateName copy];
    [self setAnyVectorName:_selectedStateName forState:UIControlStateNormal];
}
-(void)setDisabledStateName:(UIColor *)disabledStateName {
    _disabledStateName = [disabledStateName copy];
    [self setAnyVectorName:_disabledStateName forState:UIControlStateNormal];
}

-(void)setVectorImageName:(NSString *)imageName forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
        self.normalStateName = imageName;
        break;
        case UIControlStateHighlighted:
        self.highlightedStateName = imageName;
        break;
        case UIControlStateSelected:
        self.selectedStateName = imageName;
        break;
        case UIControlStateDisabled:
        self.disabledStateName = imageName;
        break;
        default:
        break;
    }
}

#pragma mark -----outside port----
-(UIColor *)imageColorForState:(UIControlState)state {
    UIColor *color = nil;
    switch (state) {
        case UIControlStateNormal:
        color = self.normalStateColor;
        break;
        case UIControlStateHighlighted:
        color = self.highlightedStateColor;
        break;
        case UIControlStateSelected:
        color = self.selectedStateColor;
        break;
        case UIControlStateDisabled:
        color = self.disabledStateColor;
        break;
        default:
        break;
    }
    return color;
}

-(NSString *)imageNameForState:(UIControlState)state {
    NSString *name = nil;
    switch (state) {
        case UIControlStateNormal:
        name = [self.normalStateName copy];
        break;
        case UIControlStateHighlighted:
        name = [self.highlightedStateName copy];
        break;
        case UIControlStateSelected:
        name = [self.selectedStateName copy];
        break;
        case UIControlStateDisabled:
        name = [self.disabledStateName copy];
        break;
        default:
        break;
    }
    return name;
}



-(void)setImageSize:(CGFloat)imageSize {
    if (!self.autoSizable) {
        _imageSize = imageSize;
        [self setAnyVectorName:_normalStateName forState:UIControlStateNormal];
        [self setAnyVectorName:_highlightedStateName forState:UIControlStateHighlighted];
        [self setAnyVectorName:_selectedStateName forState:UIControlStateNormal];
        [self setAnyVectorName:_disabledStateName forState:UIControlStateNormal];
    }
}

#pragma mark -----imagename analysize-----

-(NSString *)getFontNameWithImageName:(NSString *)imageName {
    NSDictionary *dic = [self analysisImageName:imageName];
    if (dic) {
        NSString *fontFamilyName = [dic objectForKey:@"fontFamilyName"];
        return fontFamilyName;
    }
    return nil;
}

-(NSDictionary *)analysisImageName:(NSString *)imageName1 {
    
    NSArray *fontNameAndFont = [imageName1 componentsSeparatedByString:VectorImageNameSeperator];
    
    //为2是老的iconfont,3为新的iconfont
    long fontNameAndFontCount = [fontNameAndFont count];
    
    if ( fontNameAndFontCount < 2) {
        NSAssert(false,@"imageName is not in conformity with the rules");
    }
    
    NSString *fontFamilyName = nil;
    NSString *fontName = nil;
    if (fontNameAndFontCount == 2){
        //old iconfont
        
        NSString *fontNameString = [fontNameAndFont objectAtIndexForFT:0];
        
        fontName = [fontNameAndFont objectAtIndexForFT:1];
        
        NSArray *fontNameArray = [fontNameString componentsSeparatedByString:@"_"];
        
        
        if ([fontNameArray count] >= 2) {
            //正常使用，正常时必须有 Bu名_业务名 组成familyName
            fontFamilyName = [[fontNameArray objectAtIndexForFT:0]
                              stringByAppendingFormat:@"_%@",
                              [fontNameArray objectAtIndexForFT:1]];
            BOOL isValid = [self isInvaidFontFamilyName:fontFamilyName];
            
            NSAssert(isValid,@"imageName is not in conformity with the rules");
            if (isValid) {
                return @{@"fontFamilyName":fontFamilyName,@"fontName":fontName};
            }
        }
        else {
            //异常使用，正常时必须有 Bu名_业务名 组成familyName
            NSAssert(false,@"imageName is not in conformity with the rules");
        }
        
    }else if (fontNameAndFontCount >= 3){
        
        //new iconfont
        fontFamilyName = fontNameAndFont[0];
        fontName = fontNameAndFont[1];
        BOOL isValid = [self isInvaidFontFamilyName:fontFamilyName];
        
        NSAssert(isValid,@"imageName is not in conformity with the rules");
        
        
        if(fontNameAndFont.count == 5){
            //imageCode with text
            if (isValid) {
                return @{@"fontFamilyName":fontFamilyName,@"fontName":fontName,@"text":fontNameAndFont[3],@"textSize":fontNameAndFont[4]};
            }
        }else{
            
            if (isValid) {
                return @{@"fontFamilyName":fontFamilyName,@"fontName":fontName};
            }
        }
        
        
        
    }
    return nil;
}

-(BOOL)isInvaidFontFamilyName:(NSString *)fontFamilyName {
    NSArray *fontFamilys = [UIFont familyNames];
    for (NSString *familyName in fontFamilys) {
        if ([familyName isEqualToString:fontFamilyName]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark ------dealloc-----

-(void)dealloc {
    self.autoSizable = NO;
}


#pragma mark-----bound change-----

-(void)autoSize {
    [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)cancelAutoSize {
    [self removeObserver:self forKeyPath:@"bounds"];
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSValue *boundsValue = [change objectForKey:@"new"];
    CGRect bounds = [boundsValue CGRectValue];
    
    if (CGRectEqualToRect(bounds, CGRectNull) || CGRectEqualToRect(bounds, CGRectInfinite)) {
        return;
    }
    CGFloat size = bounds.size.width > bounds.size.height ? bounds.size.height:bounds.size.width;
    _imageSize = size;
    
    switch (self.state) {
        case UIControlStateNormal:
        self.titleLabel.font = [UIFont fontWithName:[self getFontNameWithImageName:self.normalStateName] size:size];
        break;
        case UIControlStateHighlighted:
        self.titleLabel.font = [UIFont fontWithName:[self getFontNameWithImageName:self.highlightedStateName] size:size];
        break;
        case UIControlStateSelected:
        self.titleLabel.font = [UIFont fontWithName:[self getFontNameWithImageName:self.selectedStateName] size:size];
        break;
        case UIControlStateDisabled:
        self.titleLabel.font = [UIFont fontWithName:[self getFontNameWithImageName:self.disabledStateName] size:size];
        break;
        default:
        break;
    }
    
    [self setAnyVectorName:_normalStateName forState:UIControlStateNormal];
    [self setAnyVectorName:_highlightedStateName forState:UIControlStateHighlighted];
    [self setAnyVectorName:_selectedStateName forState:UIControlStateNormal];
    [self setAnyVectorName:_disabledStateName forState:UIControlStateNormal];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state {
    if ([self isMemberOfClass:[FTVectorButton class]]){
        return;
    }else{
        
        [super setImage:image forState:state];
    }
    
}


#pragma mark ----autosizable------
-(void)setAutoSizable:(BOOL)autoSizable {
    if (autoSizable == YES) {
        if (self.autoSizable != YES) {
            [self autoSize];
        }
    }
    else {
        if (self.autoSizable == YES) {
            [self cancelAutoSize];
        }
    }
    _autoSizable = autoSizable;
}


#pragma mark ----toUIImage------
-(UIImage*)toUIImage{
    
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize contextSize = CGSizeMake(self.bounds.size.width * scale, self.bounds.size.height * scale);
    
    
    
    UIGraphicsBeginImageContext(contextSize);
    
    if ([self attributedTitleForState:UIControlStateNormal] != nil){
        
        int offsetX = 0;
        int offsetY = 0;
        
        if ([self.text containsString:@"\n"]){
            
            int maxWidth = MAX(self.adapterImageSize, self.textSize);
            
            offsetX = (self.bounds.size.width * scale - maxWidth * scale) / 2;
            offsetY = (self.bounds.size.height * scale - self.adapterImageSize * scale - self.textSize * scale ) / 2;
            
        }else{
            
            offsetX = (self.bounds.size.width * scale - self.adapterImageSize * scale - self.textSize * self.text.length * scale) / 2;
            offsetY = (self.bounds.size.height * scale - self.adapterImageSize * scale ) / 2;
            
        }
        
        [self.scaleAttrutedString drawAtPoint:CGPointMake(offsetX, offsetY)];
        
    }else{
        
        int offsetX = (self.bounds.size.width * scale - self.imageSize * scale) / 2;
        int offsetY = (self.bounds.size.height * scale - self.imageSize * scale) / 2;
        
        UIFont * font = [UIFont fontWithName:self.titleLabel.font.fontName size:self.imageSize * scale];
        
        [self.titleLabel.text drawAtPoint:CGPointMake(offsetX, offsetY) withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: self.titleLabel.textColor == nil ? [UIColor whiteColor] : self.titleLabel.textColor}];
    }
    
    
    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark ----isIconfont------
-(BOOL)isIconfont{
    
    return _normalStateName != nil && ![_normalStateName isEqualToString:@""];
}

@end
