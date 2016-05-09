//
//  FTAssert.m
//  fertile
//
//  Created by vincent on 16/5/6.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTAssert.h"

@implementation FTAssert


NSException *_FTNotImplementedException(SEL, Class);
NSException *_FTNotImplementedException(SEL cmd, Class cls)
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented "
                     "for the class %@", sel_getName(cmd), cls];
    return [NSException exceptionWithName:@"RCTNotDesignatedInitializerException"
                                   reason:msg userInfo:nil];
}


@end
