//
//  XYUtils.m
//  GangQinEJia
//
//  Created by ly on 15/12/3.
//  Copyright © 2015年 kedll. All rights reserved.
//

#import "XYUtils.h"

@implementation XYUtils


+(id)GetSharedObj:(int)cmd{
    UIApplication *app=[UIApplication sharedApplication];
    if (cmd==0) return app;
    else if(cmd==1) return [[app windows] objectAtIndex:0];
    return nil;
}

@end
