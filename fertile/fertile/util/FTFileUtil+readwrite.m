//
//  FTFileUtil+readwrite.m
//  fertile
//
//  Created by vincent on 16/4/14.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTFileUtil+readwrite.h"

@implementation FTFileUtil (readwrite)




+(NSString *) readStrFromFile:(NSString *)fileFullName
{
    if ([self fileExist:fileFullName])
    {
        return [NSString stringWithContentsOfFile:fileFullName encoding:NSUTF8StringEncoding error:nil];
    }
    else
    {
        return nil;
    }
}

+(NSDictionary *) readDicFromFile:(NSString *)fileFullName
{
    NSString *tmp = [self readStrFromFile:fileFullName];
    if (tmp)
    {
        return [tmp json2Dic];
    }
    else
    {
        return nil;
    }
}

+(NSArray *) readArrayFromFile:(NSString *)fileFullName
{
    NSString *tmp = [self readStrFromFile:fileFullName];
    if (tmp)
    {
        return [tmp json2Array];
    }
    else
    {
        return nil;
    }
}

+(void) strAppendToFile:(NSString *)fileFullName with:(NSString *)str
{
    if (!str || [str isEmpty])
        return ;
    
    BOOL isDir = false;
    BOOL isExit = [[NSFileManager defaultManager] fileExistsAtPath:fileFullName isDirectory:&isDir];
    
    if (!isExit || isDir) {
        
        [str writeToFile:fileFullName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:fileFullName];
    
    if(outFile == nil)
    {
        NSLog(@"Open of file for writing failed");
    }
    //找到并定位到outFile的末尾位置(在此后追加文件)
    [outFile seekToEndOfFile];
    //读取inFile并且将其内容写到outFile中
    [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    //关闭读写文件
    [outFile closeFile];
    
}

@end
