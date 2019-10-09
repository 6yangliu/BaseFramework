//
//  UITableView+Addtions.h
//  课
//
//  Created by KEKE on 16/1/14.
//  Copyright © 2016年 KEKE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Addtions)
/**
 *  隐藏多余的cell
 */
- (void)hideEmptyCells;
/**
 *  补全分割线（uitalbleViewcell方法也要实现）
 */
- (void)hideSeparatorLeftInset;
/**
 *  隐藏分割线（uitalbleViewcell方法也要实现）
 */
- (void)hideSeparator;
@end
