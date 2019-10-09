//
//  UIViewController+share.m
//  APPiOS
//
//  Created by 刘吉星 on 2018/6/22.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "UIViewController+share.h"
#import <objc/runtime.h>
#import "UIWindow+Extensions.h"
#import "UIViewController+loadingAnimation.h"
@implementation UIViewController (share)

- (void)setShareModel:(BigerShareModel *)model friendModel:(BigerShareModel *)friendModel shareType:(EShareType)shareType{
    self.shareType=shareType;
    self.currentShareModel = model;//朋友
    self.friendModel = friendModel;//朋友圈
}

- (void)showShareWithModel:(BigerShareModel *)model friendModel:(BigerShareModel *)friendModel shareType:(EShareType)shareType{
    [self setShareModel:model friendModel:friendModel shareType:shareType];
    BigerCustomShareView * shareView = [BigerCustomShareView createCustomShareViewWithShareType:shareType];
    shareView.shareDelegate = self;
    [shareView show];
}


- (void)shareWithType:(EShareButtonType)buttonType{
    if(self.shareType==EShareType_default){
        [self shareWithType_default:buttonType];
    }
    if(self.shareType==EShareType_fastnews){
        [self shareWithType_fastnews:buttonType];
    }
}
//默认的分享
-(void)shareWithType_default:(EShareButtonType)buttonType{
    BigerShareModel * shareModel = self.currentShareModel;//朋友
    BigerShareModel * friendModel = self.friendModel;//朋友圈
    
    UIViewController * delegate = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:ALS(@"提示") message:ALS(@"分享内容获取失败~~请稍后重试!!") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:ALS(@"确定") style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    switch (buttonType) {
        case EShareButtonWechat: {
            if (shareModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            if([self respondsToSelector:@selector(sendAddRouletteCount)]){
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAddRouletteCount) name:@"shareSuccess" object:nil];
            }
            
            [[BigerShareManager shareManage] wxShareWithModel:shareModel delegate:delegate];
            
            break;
        }
        case EShareButtonWechatSocial: {
            if (friendModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            if([self respondsToSelector:@selector(sendAddRouletteCount)]){
               [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAddRouletteCount) name:@"shareSuccess" object:nil];
            }
            
            UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
            [currentPresentedVC wh_showHintOnViewWithText:ALS(@"分享内容已复制到剪切板，请手动粘贴")];
            
            [currentPresentedVC performBlock:^{
                
                [[BigerShareManager shareManage] wxFriendShareWithModel:friendModel  delegate:delegate];
                
            } afterDelay:1];
            
            break;
        }
        case EShareButtonQQ: {
            if (shareModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            if([self respondsToSelector:@selector(sendAddRouletteCount)]){
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAddRouletteCount) name:@"shareSuccess" object:nil];
            }
            
            [[BigerShareManager shareManage] qqShareWithModel:shareModel delegate:delegate];
            break;
        }
        case EShareButtonCopy: {
            if (friendModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            if([self respondsToSelector:@selector(sendAddRouletteCount)]){
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAddRouletteCount) name:@"shareSuccess" object:nil];
            }
            
            [[BigerShareManager shareManage] pasteboard:friendModel delegate:delegate];
            break;
        }
        case EShareButtonEmail: {
            if (friendModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            if([self respondsToSelector:@selector(sendAddRouletteCount)]){
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAddRouletteCount) name:@"shareSuccess" object:nil];
            }
            
            [[BigerShareManager shareManage] emailShareWithModel:friendModel delegate:delegate];
            break;
        }
        case EShareButtonTwitter: {
            if (friendModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            if([self respondsToSelector:@selector(sendAddRouletteCount)]){
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendAddRouletteCount) name:@"shareSuccess" object:nil];
            }
            [[BigerShareManager shareManage] twitterShareWithModel:friendModel delegate:delegate];
            break;
        }
    }
    
}
//快讯模块的分享
-(void)shareWithType_fastnews:(EShareButtonType)buttonType{
    BigerShareModel * shareModel = self.currentShareModel;//朋友
    BigerShareModel * friendModel = self.friendModel;//朋友圈
    
    UIViewController * delegate = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:ALS(@"提示") message:ALS(@"分享内容获取失败~~请稍后重试!!") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:ALS(@"确定") style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    
    switch (buttonType) {
        case EShareButtonSaveImage: {
            if (shareModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            [[BigerShareManager shareManage] fastnews_saveImage:shareModel delegate:delegate];
            break;
        }
        case EShareButtonWechat: {
            if (shareModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            [[BigerShareManager shareManage] fastnews_wxShareWithModel:shareModel delegate:delegate];
            break;
        }
        case EShareButtonWechatSocial: {
            if (friendModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            [[BigerShareManager shareManage] fastnews_wxFriendShareWithModel:friendModel  delegate:delegate];
            break;
        }
        case EShareButtonQQ: {
            if (shareModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            [[BigerShareManager shareManage] fastnews_qqShareWithModel:shareModel delegate:delegate];
            break;
        }
        case EShareButtonCopy: {
            break;
        }
        case EShareButtonEmail: {
            if (friendModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            [[BigerShareManager shareManage] fastnews_emailShareWithModel:friendModel delegate:delegate];
            break;
        }
        case EShareButtonTwitter: {
            if (friendModel == nil) {
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            [[BigerShareManager shareManage] fastnews_twitterShareWithModel:friendModel delegate:delegate];
            break;
        }
        case EShareButtonQQZone: {
            break;
        }
        case EShareButtonSina: {
            break;
        }
        case EShareButtonFacebook: {
            break;
        }
            
    }
    
}

-(EShareType)shareType
{
    NSNumber *shouldIgnoreScrollingAdjustment = objc_getAssociatedObject(self, @selector(shareType));
    return [shouldIgnoreScrollingAdjustment integerValue];
}

-(void)setShareType:(EShareType)shareType
{
    objc_setAssociatedObject(self, @selector(shareType), @(shareType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




- (void)setCurrentShareModel:(BigerShareModel *)currentShareModel {
    objc_setAssociatedObject(self, "_currentShareModel", currentShareModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BigerShareModel *)currentShareModel {
    return objc_getAssociatedObject(self, "_currentShareModel");
}

- (void)setFriendModel:(BigerShareModel *)friendModel{
    objc_setAssociatedObject(self, "_friendModel", friendModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BigerShareModel *)friendModel {
    return objc_getAssociatedObject(self, "_friendModel");
}


@end
