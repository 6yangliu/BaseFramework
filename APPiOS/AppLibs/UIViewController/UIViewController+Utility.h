//
//  UIViewController+Utility.h
//  CaiGuanJia
//
//  Created by 清阳 on 2017/6/27.
//  Copyright © 2017年 tianyingxinxi. All rights reserved.

//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UIViewController (Utility)

//验证手机号码
- (BOOL)validateMobile:(NSString *)mobile;

//验证邮箱
- (BOOL)validateEmail:(NSString *)email;

- (BOOL) validateIdentityCard: (NSString *)identityCard;

//验证密码.(请输入6-16位只包括数字和英文字母的密码)
- (BOOL)validatePassWord:(NSString *)pwd;
-(void)addTitleView:(NSString *)title;
//压缩图片分辨率
- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
//Web图片自适应手机版本
- (void)javascripForWebView:(UIWebView*)webView;

@end
