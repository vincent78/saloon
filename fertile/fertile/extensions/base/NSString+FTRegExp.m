//
//  NSString+regExp.m
//  fertile_oc
//
//  Created by vincent on 15/10/25.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "NSString+FTRegExp.h"

@implementation NSString (FTRegExp)


-(BOOL)isValidDigit
{
    NSString *match=@"[0-9]+|[0-9]+[.]|[.]{1}[0-9]+|[0-9]+|[0-9]+[.]{1}[0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    bool valid = [predicate evaluateWithObject:self];
    
    return valid;
}

-(BOOL)isValidInteger
{
    NSString *match=@"^[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    bool valid = [predicate evaluateWithObject:self];
    return valid;
}

-(BOOL)isNum
{
    NSString *match=@"[0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    bool valid = [predicate evaluateWithObject:self];
    return valid;
}

-(BOOL)isEn
{
    NSString *match=@"[\\s]*[A-Za-z]+[\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
    return [predicate evaluateWithObject:self];
}

-(BOOL)isOnlyEnOrNum
{
    NSString *match = @"[A-Za-z0-9]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
    return [predicate evaluateWithObject:self];
}


-(BOOL) isValidSBCWithString
{
    for (int i = 0;i <self.length; i++)
    {
        const char *p;
        NSString * isChar = [self substringWithRange:NSMakeRange(i, 1)];
        if(![isChar isValidCN]){
            p = [isChar UTF8String];
            // 判断是不是全角字符
            if ((*p)&0x80) {
                return YES;
            }
        }
    }
    return NO;
}

-(BOOL)isValidCN
{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
    return [predicate evaluateWithObject:self];
}


-(BOOL)isValidEMail
{
    NSString *match=@"\\S+@(\\S+\\.)+[\\S]{1,6}";
    //  NSString *match=@"[a-zA-Z0-9_.-]+@([a-zA-Z0-9]+\\.)+[a-zA-Z]{1,6}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    bool valid = [predicate evaluateWithObject:self];
    
    return valid;
}


-(BOOL) isMobileNumber:(NSString *) mobile
{
    bool isMobile = false;
    
    if(mobile != nil && mobile.length == 11)
    {
        NSString *numberStr = @"^((13[0-9])|(15[^4,\\D])|(17[0,6-8])|(147)|(145)|(18[0-9]))\\d{8}$";
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberStr];
        
        isMobile = [pred evaluateWithObject:mobile];
    }
    return isMobile;
}



-(BOOL) verifyID:(NSString *)idcard
{
    if(idcard == nil || [idcard isEqualToString:@""])
    {
        return false;
    }
    
    idcard = [idcard stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(idcard.length == 15)
    {
        // 15位时只做长度验证
        return true;
    }
    
    if (idcard.length != 18)
    {
        return false;
    }
    
    NSString *verify = [idcard substringFromIndex:17];//idcard.substring(17, 18);
    //  if (verify.equalsIgnoreCase(getVerify(idcard)))
    verify = [verify uppercaseString];
    if([verify isEqualToString:[self getVerify:idcard]])
    {
        return true;
    }
    
    return false;
}


#pragma mark - private function
/**
 *  @brief 计算身份证最后一位
 *
 *  @param eighteen <#eighteen description#>
 *
 *  @return <#return value description#>
 */
-(NSString *) getVerify:(NSString *)eighteen
{
    int remain = 0;
    int ai[18];
    int wi[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 };
    char vi[] = { '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2' };
    
    if(eighteen == nil || [eighteen isEqualToString:@""])
    {
        return @"";
    }
    
    if (eighteen.length == 18)
    {
        eighteen = [eighteen substringToIndex:17];//eighteen.substring(0, 17);
    }
    
    if (eighteen.length == 17)
    {
        int sum = 0;
        for (unsigned int i = 0; i < 17; i++)
        {
            //            NSString k = eighteen.substring(i, i + 1);
            //            NSRange range = NSMakeRange(i, 1);
            NSString *k = [eighteen substringWithRange:NSMakeRange(i, 1)];
            //            if (@"-1".equalsIgnoreCase(k))
            if(k == nil || [k isEqualToString:@""])
            {
                return @"";
            }
            
            ai[i] = [k intValue];//toInt(k);
        }
        
        for (unsigned int i = 0; i < 17; i++)
        {
            sum += wi[i] * ai[i];
        }
        
        remain = sum % 11;
    }
    
    if (remain >= 0)
    {
        //      return remain == 2 ? @"x" : vi[remain];//String.valueOf(vi[remain]);
        return [NSString stringWithFormat:@"%c",vi[remain]];
    }
    else
    {
        return @"";
    }
}

@end
