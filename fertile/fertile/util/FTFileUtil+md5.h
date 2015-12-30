//
//  FTFileUtil+md5.h
//  fertile_oc
//
//  Created by vincent on 15/10/28.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "FTFileUtil.h"

@interface FTFileUtil (md5)

/**
 *  @brief  获得文件的MD5
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)getFileMD5WithPath:(NSString *)fileFullPath;


@end
