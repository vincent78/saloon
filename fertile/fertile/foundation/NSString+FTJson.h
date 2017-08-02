//
//  NSString+json.h
//  fertile_oc
//
//  Created by vincent on 15/10/28.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FTJson)

/**
 *  @brief  json字符串转成对象
 
 An object that may be converted to JSON must have the following properties:
 - Top level object is an NSArray or NSDictionary
 - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
 - All dictionary keys are NSStrings
 - NSNumbers are not NaN or infinity

 *
 *  @return <#return value description#>
 */
-(id) json2Obj;

/**
 *  @brief  json字符串转成字典
 *
 *  @return <#return value description#>
 */
-(NSDictionary *) json2Dic;

/**
 *  @brief  json字符串转成数组
 *
 *  @return <#return value description#>
 */
-(NSArray *) json2Array;


@end
