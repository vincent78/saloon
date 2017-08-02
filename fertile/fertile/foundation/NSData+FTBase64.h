//
//  NSData+base64.h
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FTBase64)

- (NSString *)base64EncodeToString ;

+ (NSData *)base64DecodeToData:(NSString *)base64String;

@end
