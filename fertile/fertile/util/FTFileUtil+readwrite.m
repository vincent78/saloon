//
//  FTFileUtil+readwrite.m
//  fertile
//
//  Created by vincent on 16/4/14.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTFileUtil+readwrite.h"

@implementation FTFileUtil (readwrite)


#pragma mark 读文件

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



// 读取文件
+ (NSData *)readDataFromFile:(NSString *)filePath
{
    NSData *data = nil;
    
    if([self exist:filePath])
    {
        data = [NSData dataWithContentsOfFile:filePath];
    }
    
    return data;
}


+(NSMutableDictionary *) readPListFile:(NSString *)fileName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    if (emptyStr(plistPath) || ![self exist:plistPath])
    {
        return nil;
    }
    return [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}


#pragma mark 写文件

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



// 写文件
+ (BOOL)writeData:(NSData *)data filePath:(NSString *)filePath
{
    BOOL isSuccess = NO;
    
    if(data != nil)
    {
        isSuccess = [data writeToFile:filePath atomically:YES];
    }
    
    return isSuccess;
}


// 写字符串 到文件
+ (BOOL)writeContent:(NSString *)content filePath:(NSString *)filePath
{
    BOOL isSuccess = NO;
    
    if(content != nil)
    {
        isSuccess = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    return isSuccess;
}





@end
