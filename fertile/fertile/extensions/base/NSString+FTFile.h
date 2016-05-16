//
//  NSString+file.h
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FTFile)

/**
 *  @brief  追加字符串到文件（线程安全）
 *
 *  @param fileFullName <#fileFullName description#>
 */
-(void) appendToFile:(NSString *)fileFullName;


@end
