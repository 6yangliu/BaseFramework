//
//  UIViewController+loadingAnimation.m
//  APPiOS
//
//  Created by 刘吉星 on 2018/7/10.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "UIViewController+loadingAnimation.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#import "MBProgressHUD+Show.h"
@implementation UIViewController (loadingAnimation)

- (void)setHUD:(MBProgressHUD *)HUD {
    objc_setAssociatedObject(self, @"_HUD", HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (MBProgressHUD *)HUD {
    return objc_getAssociatedObject(self, @"_HUD");
}
// *  吐丝提示
// *
// *  @param text 提示内容
// */
- (void)wh_showHintOnViewWithText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = SXFont(18);
    hud.margin = 15;
    hud.backgroundView.alpha = 0.8;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.0];
}

//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
@end
