//
//  SXMJRefreshFooter.m
//  APPiOS
//
//  Created by liuy on 2018/5/30.
//  Copyright © 2018年 shengxi. All rights reserved.
//


#import "SXMJRefreshFooter.h"

@implementation SXMJRefreshFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"frame-%d", (int)i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<23; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"frame-%d", (int)i]];
        [refreshingImages addObject:image];
    }
    
    [self setImages:refreshingImages duration:0.5 forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:0.5 forState:MJRefreshStateRefreshing];
    
}


@end
