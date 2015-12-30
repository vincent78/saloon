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
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return docDir;
}

+ (NSString *)getCachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}

+ (NSString *)getTmpDirectory
{
    return NSTemporaryDirectory ();
}

+(NSString *)getAppDirectory
{
    return [[NSBundle mainBundle] resourcePath];
}


+(NSString *)getEmbedFrameworkDirectory
{
    return [[self getAppDirectory] stringByAppendingPathComponent:@"Frameworks"];
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
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullName isDirectory:&isDirectory])
    {
        if (!isDirectory)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
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


@end
