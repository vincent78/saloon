/*********************************************************************
 文件名称 : FieldInfo.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 字段类型model类
 *********************************************************************/

#import "FTFieldInfo.h"

@implementation FTFieldInfo
@synthesize fieldName;
@synthesize fieldType;

- (id)init
{
    if (self = [super init])
    {
        self.fieldName = @"";
        self.fieldType = eNIL;
    }
    return self;
}





@end
