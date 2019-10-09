//
//  UITableView+Addtions.m
//  课
//
//  Created by KEKE on 16/1/14.
//  Copyright © 2016年 KEKE. All rights reserved.
//

#import "UITableView+Addtions.h"

@implementation UITableView (Addtions)
//隐藏多余的cell
- (void)hideEmptyCells
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}
//补全分割线（uitalbleViewcell方法也要实现）
- (void)hideSeparatorLeftInset
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}
//隐藏分割线（uitalbleViewcell方法也要实现）
- (void)hideSeparator
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self setSeparatorInset:UIEdgeInsetsMake(0, kScreen_width, 0, 0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self setLayoutMargins:UIEdgeInsetsMake(0, kScreen_width, 0, 0)];
    }
}
@end
