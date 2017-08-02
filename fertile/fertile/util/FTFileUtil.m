//
//  FTFileUtil.m
//  fertile_oc
//
//  Created by vincent on 15/10/28.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTFileUtil.h"

@implementation FTFileUtil


+(NSString *) getResFullPath:(NSString *)resName ofType:(NSString *)type
{
    return [[NSBundle mainBundle] pathForResource:resName ofType:type];
}

+(NSString *)getResFullPath:(NSString *)resName ofType:(NSString *)type withFramework:(NSString *)frameworkName
{
    NSBundle *resBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:frameworkName ofType:@"framework" inDirectory:@"Frameworks"]];
    NSString* path = [resBundle pathForResource:resName ofType:type];
    return path;
}

+(NSString *)getResFullPath:(NSString *)resName ofType:(NSString *)type in:(NSBundle *)bundle
{
    return [bundle pathForResource:resName ofType:type];
}

+(NSBundle *) getBundleByName:(NSString *)bundleName
{
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"framework" inDirectory:@"Frameworks"]];
}


+ (NSString *)getHomeDirectory
{
    return NSHomeDirectory ();
}

+ (NSString *)getDocDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)getCachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)getLibraryDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)getTmpDirectory
{
    return NSTemporaryDirectory();
}

+(NSString *)getAppDirectory
{
    return [[NSBundle mainBundle] resourcePath];
}


+(NSString *)getEmbedFrameworkDirectory
{
    return [[self getAppDirectory] stringByAppendingPathComponent:@"Frameworks"];
}


+(NSString *)getFileName:(NSString *)path hasSufix:(BOOL) hasSufix
{
    NSString *fileName = path.lastPathComponent;
    if (hasSufix)
    {
        return fileName;
    }
    else
    {
        return [fileName stringByDeletingPathExtension];
    }
}

+(NSString *)getFileExtName:(NSString *)path
{
    return [path pathExtension];
}


+(BOOL) exist:(NSString *)fullName
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullName])
        return TRUE;
    else
        return FALSE;
}

+(BOOL) fileExist:(NSString *)fullName
{
    BOOL isDirectory = YES;
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullName isDirectory:&isDirectory] && !isDirectory)
    {
        return TRUE;
    }
    else
    {
        return  FALSE;
    }
}

+ (NSMutableArray *)findFiles:(NSString *)subDirPath
{
    //DEBUGLOG (@"curr Dir: %@", subDirPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *filesPath = [NSMutableArray array];
    NSArray *tmpArray = [fileManager contentsOfDirectoryAtPath:subDirPath error:nil];
    for (NSString *fileName in tmpArray)
    {
        BOOL flag = YES;
        NSString *fullPath = [subDirPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag])
        {
            //非目录
            if (!flag)
            {
                [filesPath addObject:fullPath];
            }
            //目录
            else
            {
                [filesPath addObjectsFromArray:[self findFiles:fullPath]];
            }
        }
    }
    return filesPath;
}

/**
 *  @brief  返回目录下所有的文件
 *
 *  @param targetPath    <#targetPath description#>
 *  @param hasPrefixPath <#hasPrefixPath description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableArray *)findFiles:(NSString *)targetPath HasPrefixPath:(BOOL)hasPrefixPath
{
    if (hasPrefixPath)
    {
        return [self findFiles:targetPath];
    }
    else
    {
        NSMutableArray *filesInfo = [FTFileUtil findFiles:targetPath];
        int pathPrefixLength = (int)targetPath.length;
        for (int i = 0; i < filesInfo.count; i++)
        {
            [filesInfo replaceObjectAtIndex:i
                                 withObject:[[filesInfo objectAtIndex:i] substringFromIndex:(pathPrefixLength + 1)]];
        }
        return filesInfo;
    }
}


+ (NSMutableArray *)findFilesOnLevel:(NSString *)targetPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *filesPath = [NSMutableArray array];
    NSArray *tmpArray = [fileManager contentsOfDirectoryAtPath:targetPath error:nil];
    for (NSString *fileName in tmpArray)
    {
        BOOL flag = YES;
        NSString *fullPath = [targetPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag])
        {
            //非目录
            if (!flag)
            {
                [filesPath addObject:fullPath];
            }
        }
    }
    return filesPath;
}


+ (NSMutableArray *)findDirectOnLevel:(NSString *)targetPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *filesPath = [NSMutableArray array];
    NSArray *tmpArray = [fileManager contentsOfDirectoryAtPath:targetPath error:nil];
    for (NSString *fileName in tmpArray)
    {
        BOOL flag = YES;
        NSString *fullPath = [targetPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag])
        {
            //目录
            if (flag)
            {
                [filesPath addObject:fullPath];
            }
        }
    }
    return filesPath;
}





+ (void)copyItem:(NSString *)sourceFullName
              to:(NSString *)targetFullName
       overwrite:(BOOL)shouldOverwrite
{
    if ([sourceFullName isEmpty])
    {
        return;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // create file directory, include multilayer directory
    NSRange lastTag = [targetFullName rangeOfString:@"/" options:NSBackwardsSearch];
    if (lastTag.location != NSNotFound && lastTag.location != 0)
    {
        NSString *targetDir = [targetFullName substringToIndex:lastTag.location];
        // DEBUGLOG (@"sourceFullName: %@ \ntargetFullName: %@",sourceFullName, targetFullName);
        if (![fileManager fileExistsAtPath:targetDir])
        {
            [fileManager createDirectoryAtPath:targetDir
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:nil];
        }
    }
    
    // file not exists or want to overwrite it
    if (shouldOverwrite || ![fileManager fileExistsAtPath:targetFullName])
    {
        NSError *error;
        
        [fileManager removeItemAtPath:targetFullName error:&error];
        [fileManager copyItemAtPath:sourceFullName toPath:targetFullName error:&error];
        //        BOOL suc = ;
        //        DEBUGLOG (@"copy file %@", suc ? @"successfully" : @"failed");
    }
}



+ (void)removeItem:(NSString *)fullName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:fullName error:&error];
}

+ (BOOL)createDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    return [fileManager createDirectoryAtPath:path
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error];
}

#pragma mark 文件属性


+ (BOOL)addSkipBackUpFileWithPath:(NSString *)path
{
    
    BOOL isDir = NO;
    BOOL isExist =[[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    NSURL *url = NULL;
    if (isExist) {
        url = [NSURL fileURLWithPath:path isDirectory:isDir];
    }
    
    BOOL ret = NO;
    
    if (url) {
        ret = [self addSkipBackupAttributeToItemAtURL:url];
    }
    
    return ret;
}


+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    
    return success;
}

+ (BOOL)checkSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    NSError *error;
    id flag = nil;
    [URL getResourceValue: &flag
                   forKey: NSURLIsExcludedFromBackupKey error: &error];
//    NSLog (@"NSURLIsExcludedFromBackupKey flag value is %@", flag);
    return flag;
}


//获取文件大小,失败返回0
+(unsigned long long)getFileSizeWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([self exist:filePath])
    {
        NSError *error = nil;
        NSDictionary* fileAttrDic = [fileManager attributesOfItemAtPath:filePath error:&error];
        if(fileAttrDic != nil){
            return [fileAttrDic fileSize];
        }else{
            FTELog(@"获取文件大小失败 description %@, failureReason %@",[error localizedDescription],[error localizedFailureReason]);
            return 0;
        }
    }else{
        return 0;
    }
}


@end
