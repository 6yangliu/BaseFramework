//
//  UIViewController+loadingAnimation.h
//  APPiOS
//
//  Created by 刘吉星 on 2018/7/10.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (loadingAnimation)

- (void)wh_showHintOnViewWithText:(NSString *)text;
//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay;

@end
