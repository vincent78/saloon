//
//  SNAppHelperDelegate.m
//  saloon
//
//  Created by vincent on 15/12/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import "SNAppHelperDelegate.h"

@implementation SNAppHelperDelegate

-(FTNavigateWidget *) prepareNavigateBar
{
    FTNavigateWidget *navWidget  =  [[FTNavigateWidget alloc] initWithFrame:CGRectMake(0,0,[FTSystemHelper screenWidth],[FTSystemHelper navBarHeight])];
    navWidget.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    
    return navWidget;
}

-(void) appInit
{
    
}

-(void) appRelease
{
    
}

@end
