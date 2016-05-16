//
//  UILabel+rich.m
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "UILabel+FTRich.h"

@implementation UILabel (FTRich)

-(void) setHtml:(NSString *)htmlStr
{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                                                    options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                         documentAttributes:nil
                                                                      error:nil];
    self.attributedText = attrStr;

}

@end
