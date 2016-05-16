//
//  NSDictionary+json.m
//  fertile_oc
//
//  Created by vincent on 15/10/28.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSDictionary+FTJson.h"

@implementation NSDictionary (FTJson)

-(NSString *) jsonString
{
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error)
        {
            return jsonString;
        }
        else
        {
            return nil;
        }
    }
    else
        return nil;
}


-(void) write2File:(NSString *)fileFullName append:(BOOL)flag
{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileFullName] && !flag)
    {
        [[NSFileManager defaultManager] removeItemAtPath:fileFullName error:nil];
    }
    
    NSString *tmp = [self jsonString];
    [tmp writeToFile:fileFullName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
