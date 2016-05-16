//
//  NSString+file.m
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+FTFile.h"

@implementation NSString (FTFile)


-(void) appendToFile:(NSString *)fileFullName
{
    if ([self isEmpty])
        return ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        BOOL isDir = false;
        BOOL isExit = [[NSFileManager defaultManager] fileExistsAtPath:fileFullName isDirectory:&isDir];
        
        if (!isExit || isDir) {

            [self writeToFile:fileFullName atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:fileFullName];
        
        if(outFile == nil)
        {
            NSLog(@"Open of file for writing failed");
        }
        //找到并定位到outFile的末尾位置(在此后追加文件)
        [outFile seekToEndOfFile];
        //读取inFile并且将其内容写到outFile中
        [outFile writeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
        //关闭读写文件  
        [outFile closeFile];
            
    });
    
}

@end
