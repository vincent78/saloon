//
//  NSData+Hash.h
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Hash)

- (NSString *)MD5;

- (NSString *)SHA1;

- (NSString *)SHA256;

- (NSString *)UTF8String;

@end
