//
//  NSData+box.m
//  fertile
//
//  Created by vincent on 16/4/21.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "NSData+FTBox.h"

@implementation NSData (FTBox)


-(NSString *) toString
{
    return [ [NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

-(Byte *) toBytes
{
    return (Byte *)[self bytes];
}

-(NSString *) toHexString
{
    
    Byte *bytes = [self toBytes];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    for (int i = 0; i < [self length]; i++) {
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", bytes[i]]];
    }
    
    return hexString;
}



@end
