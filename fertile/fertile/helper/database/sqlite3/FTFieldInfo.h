/*********************************************************************
 文件名称 : FieldInfo.h
 作   者 :
 创建时间 : 2013-08-20
 文件描述 : 字段类型model类
 *********************************************************************/

#import <Foundation/Foundation.h>

//字段类型
typedef enum
{
    eNIL         = 0x0001,  //默认类型，空
    eDOUBLE      = 0x0003,  //double类型
    eINT         = 0x0004,  //int
    eFLOAT       = 0x0005,  //float
    eLONG        = 0x0006,  //long
    eSHORT       = 0x0007,  //Short
    eNSSTRING    = 0x0008,  //NSString
} eTypeOfProperty;

@interface FTFieldInfo : NSObject
{
    
}

@property (nonatomic,retain)NSString *fieldName; //字段名称
@property (nonatomic,assign)eTypeOfProperty fieldType; //字段类型






@end
