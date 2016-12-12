//
//  FTVectorImageView.m
//  fertile
//
//  Created by vincent on 2016/12/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTVectorImageView.h"

@implementation FTVectorImageView

@synthesize imageColor;
@synthesize imageSize;
@synthesize imageName;



-(id)initWithFrame:(CGRect)frame iconFontFamliyName:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode
{
    
    return [self initWithFrame:frame fontFamilyName:FT_FONT_FAMLIY_NAME_ARRAY[iconFontFamliyName] fontName:imageCode];
}



-(id)initWithFrame:(CGRect)frame fontFamilyName:(NSString *)fontFamily imageCode:(NSString *)imageCode
{
    id ret = [super initWithFrame:frame fontFamilyName:fontFamily fontName:imageCode];
    
    BOOL isValid = [self isInvaidFontFamilyName:fontFamily];
    
    NSAssert(isValid,@"imageName is not in conformity with the rules");
    if (isValid) {
        
        self.imageCode = imageCode;
    }
    
    return ret;
}



-(id)initWithFrame:(CGRect)frame
         imageName:(NSString *)imageName1 {
    id ret;
    //非空判断
    if (imageName1 == nil) {
        ret = [self initWithFrame:frame];
    }
    
    NSDictionary *dic = [self analysisImageName:imageName1];
    if (dic) {
        NSString *fontFamilyName = [dic objectForKey:@"fontFamilyName"];
        NSString *fontName = [dic objectForKey:@"fontName"];
        ret = [super initWithFrame:frame
                    fontFamilyName:fontFamilyName
                          fontName:fontName];
        
        self.imageName = imageName1;
    }
    return ret;
}


-(void)fontFamilyName:(eCTIConFontFamliyName)iconFontFamliyName imageCode:(NSString *)imageCode
{
    self.fontFamily = FT_FONT_FAMLIY_NAME_ARRAY[iconFontFamliyName];
    
    BOOL isValid = [self isInvaidFontFamilyName:self.fontFamily];
    
    NSAssert(isValid,@"imageName is not in conformity with the rules");
    if (isValid) {
        
        self.imageCode = imageCode;
    }
    
    
    self.autoSizable = YES;
}



-(NSDictionary *)analysisImageName:(NSString *)imageName1 {
    
    NSArray *fontNameAndFont = [imageName1 componentsSeparatedByString:VectorImageNameSeperator];
    
    if ([fontNameAndFont count] != 2) {
        NSAssert(false,@"imageName is not in conformity with the rules");
    }
    
    NSString *fontNameString = [fontNameAndFont objectAtIndexForFT:0];
    NSString *fontName = [fontNameAndFont objectAtIndexForFT:1];
    
    NSArray *fontNameArray = [fontNameString componentsSeparatedByString:@"_"];
    NSString *fontFamilyName = nil;
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


-(void)setImageColor:(UIColor *)imageColor1 {
    imageColor = imageColor1;
    self.fontColor = imageColor;
}

-(UIColor *)imageColor {
    if (imageColor == nil) {
        imageColor = self.fontColor;
    }
    return imageColor;
}

-(void)setImageCode:(NSString *)imageCode{
    
    self.fontName = imageCode;
    
}

-(NSString *)imageCode{
    
    return self.fontName;
}

-(void)setImageName:(NSString *)imageName1 {
    NSDictionary *dic = [self analysisImageName:imageName1];
    if (dic) {
        NSString *fontFamilyName = [dic objectForKey:@"fontFamilyName"];
        NSString *fontName = [dic objectForKey:@"fontName"];
        imageName = fontName;
        self.fontFamily = fontFamilyName;
        self.fontName = imageName;
    }
}

-(CGFloat)imageSize {
    imageSize = self.fontContentSize;
    return imageSize;
}

@end
