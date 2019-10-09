//
//  SXMJRefreshHeader.m
//  APPiOS
//
//  Created by liuy on 2018/5/30.
//  Copyright © 2018年 shengxi. All rights reserved.
//


#import "SXMJRefreshHeader.h"

@implementation SXMJRefreshHeader


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
+ (void)load
{
    // 交换MJ的国际化方法
    Method mjMethod = class_getClassMethod([NSBundle class],@selector(mj_localizedStringForKey:value:));
    Method myMethod = class_getClassMethod(self, @selector(hook_mj_localizedStringForKey:value:));
    method_exchangeImplementations(mjMethod, myMethod);
}

/// hook刷新控件的提示文字
+ (NSString *)hook_mj_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    
    NSString *language = [NSLocale preferredLanguages].firstObject;
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:SXUserLanguage]){
        language=[[NSUserDefaults standardUserDefaults] valueForKey:SXUserLanguage];
    }else{
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        
        if ([language hasPrefix:@"en"]) {
            language = @"en";
        } else if ([language hasPrefix:@"zh"]) {
            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                language = @"zh-Hans"; // 简体中文
            } else { // zh-Hant\zh-HK\zh-TW
                language = @"zh-Hant"; // 繁體中文
            }
        } else {
            language = @"en";
        }
    }
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
    return [bundle localizedStringForKey:key value:nil table:@"Localizable"];
}

@end
