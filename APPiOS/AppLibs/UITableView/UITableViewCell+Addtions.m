//
//  UITableViewCell+Addtions.m
//  课
//
//  Created by KEKE on 16/1/14.
//  Copyright © 2016年 KEKE. All rights reserved.
//

#import "UITableViewCell+Addtions.h"

@implementation UITableViewCell (Addtions)
- (void)hideSeparatorLeftInset
{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}
//隐藏分割线（uitalbleViewcell方法也要实现）
- (void)hideSeparator{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0, kScreen_width, 0, 0)];
    }
}
@end
