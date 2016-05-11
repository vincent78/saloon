//
//  FTFileUtil+zip.h
//  fertile
//
//  Created by vincent on 16/4/7.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "FTFileUtil.h"
#import "ZipArchive.h"

@interface FTFileUtil (zip)

/**
 *  @brief 解压缩
 *
 *  @param zipFile   <#zipFile description#>
 *  @param unzipPath <#unzipPath description#>
 */
+ (void)unZip:(NSString *)zipFile unzipto:(NSString *)unzipPath;

/**
 *  @brief  压缩文件
 *
 *  @param itemFullName <#itemFullName description#>
 *  @param zipFileName  <#zipFileName description#>
 */
+ (void)zip:(NSString *)zipPath toZipFile:(NSString *)zipFileName;
@end
