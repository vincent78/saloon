//
//  FTFileUtil+zip.m
//  fertile
//
//  Created by vincent on 16/4/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTFileUtil+zip.h"

@implementation FTFileUtil (zip)


+ (void)unZip:(NSString *)zipFile unzipto:(NSString *)unzipPath
{
    ZipArchive *zip = [[ZipArchive alloc] init];
    if ([zip UnzipOpenFile:zipFile])
    {
        BOOL ret = [zip UnzipFileTo:unzipPath overWrite:YES];
        if (NO == ret)
        {
            NSLog (@"error");
        }
        [zip UnzipCloseFile];
    }
}

+ (void)zip:(NSString *)zipPath toZipFile:(NSString *)zipFileName
{
    //判断文件是否存在，如果存在则删除文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    @try
    {
        if ([fileManager fileExistsAtPath:zipFileName])
        {
            if (![fileManager removeItemAtPath:zipFileName error:nil])
            {
//                DEBUGLOG (@"Delete zip file failure.");
            }
        }
    }
    @catch (NSException *exception)
    {
//        DEBUGLOG (@"%@", exception);
    }
    
    NSArray *paramFiles = [self findFiles:zipPath HasPrefixPath:NO];
    
    //判断需要压缩的文件是否为空
    if (paramFiles == nil || [paramFiles count] == 0)
    {
//        DEBUGLOG (@"The files want zip is nil. %@",zipPath);
        return;
    }
    
    //实例化并创建zip文件
    ZipArchive *zipArchive = [[ZipArchive alloc] init];
    [zipArchive CreateZipFile2:zipFileName];
    
    //遍历文件
    for (NSString *fileName in paramFiles)
    {
        NSString *filePath = [zipPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:filePath])
        { //添加文件到压缩文件
            [zipArchive addFileToZip:filePath newname:fileName];
        }
    }
    //关闭文件
    if ([zipArchive CloseZipFile2])
    {
//        DEBUGLOG (@"Create zip file success.");
    }
    zipArchive = nil;
}



@end
