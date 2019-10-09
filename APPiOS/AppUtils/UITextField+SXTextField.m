//
//  UITextField+SXTextField.m
//  APPiOS
//
//  Created by liuy on 2018/8/13.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "UITextField+SXTextField.h"

@implementation UITextField (SXTextField)

/**
 
 *  创建UITextField 的catgory ，将此方法粘贴到.m文件。
 
 *  也就是重写长按方法 ,将长按的菜单关闭掉.
 
 *  @return 在需要使用的类直接引入.h文件即可 无需调用
 
 */

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(delete:))//禁止粘贴
    {
        return NO;
    }
//    if (action == @selector(paste:))//禁止粘贴
//    {
//        return NO;
//    }
//
//    if (action == @selector(select:))// 禁止选择
//    {
//        return NO;
//    }
//
//    if (action == @selector(selectAll:))// 禁止全选
//    {
//        return NO;
//    }

    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController)
        
    {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    
    return [super canPerformAction:action withSender:sender];

    
}




@end
