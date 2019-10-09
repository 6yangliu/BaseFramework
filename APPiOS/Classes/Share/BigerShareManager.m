//
//  BigerShareManager.m
//  APPiOS
//
//  Created by 刘吉星 on 2018/6/22.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "BigerShareManager.h"
#import <UShareUI/UShareUI.h>
#import "UIViewController+loadingAnimation.h"
#import <MessageUI/MessageUI.h>
@implementation BigerShareManager
static BigerShareManager *shareManage;
+ (BigerShareManager *)shareManage
{
    @synchronized(self)
    {
        if (shareManage == nil) {
            shareManage = [[self alloc] init];
        }
        return shareManage;
    }
}

//下载图片
- (void)resetModel:(BigerShareModel *)model {
    SDWebImageManager *manager = [SDWebImageManager sharedManager] ;
    if(model.shareImageUrl.length){
        model.shareImage=[manager.imageCache imageFromCacheForKey:[MD5Tool MD5ForLower32Bate:model.shareImageUrl]];
    }
    if(!model.shareImage){
        model.shareImage=[UIImage imageNamed:@"App_logo"];
    }
}
#pragma mark- 默认分享模块
/*
 UMSocialPlatformErrorType_Unknow            = 2000,            // 未知错误
 UMSocialPlatformErrorType_NotSupport        = 2001,            // 不支持（url scheme 没配置，或者没有配置-ObjC， 或则SDK版本不支持或则客户端版本不支持）
 UMSocialPlatformErrorType_AuthorizeFailed   = 2002,            // 授权失败
 UMSocialPlatformErrorType_ShareFailed       = 2003,            // 分享失败
 UMSocialPlatformErrorType_RequestForUserProfileFailed = 2004,  // 请求用户信息失败
 UMSocialPlatformErrorType_ShareDataNil      = 2005,             // 分享内容为空
 UMSocialPlatformErrorType_ShareDataTypeIllegal = 2006,          // 分享内容不支持
 UMSocialPlatformErrorType_CheckUrlSchemaFail = 2007,            // schemaurl fail
 UMSocialPlatformErrorType_NotInstall        = 2008,             // 应用未安装
 UMSocialPlatformErrorType_Cancel            = 2009,             // 取消操作
 UMSocialPlatformErrorType_NotNetWork        = 2010,             // 网络异常
 UMSocialPlatformErrorType_SourceError       = 2011,             // 第三方错误
 
 UMSocialPlatformErrorType_ProtocolNotOverride = 2013,   // 对应的    UMSocialPlatformProvider的方法没有实现
 UMSocialPlatformErrorType_NotUsingHttps      = 2014,   // 没有用https的请求,@see UMSocialGlobal isUsingHttpsWhenShareContent
 */

/**微信分享**/
- (void)wxShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    [self resetModel:model];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.shareTitle  descr:model.shareText thumImage:model.shareImage];
    //设置网页地址
    shareObject.webpageUrl =model.shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];

}

/**微信朋友圈*/
- (void)wxFriendShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    [self resetModel:model];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.shareTitle  descr:model.shareText thumImage:model.shareImage];
    //设置网页地址
    shareObject.webpageUrl =model.shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    UIPasteboard *pasteboard = [UIPasteboard   generalPasteboard];
    
    if(model.shareText){
        [pasteboard setString:model.shareText];
    }
   
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];
    
}


/**QQ分享**/
- (void)qqShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    [self resetModel:model];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.shareTitle  descr:model.shareText thumImage:model.shareImage];
    //设置网页地址
    shareObject.webpageUrl =model.shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];
}


/**QQ空间*/
- (void)qqSpaceShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    [self resetModel:model];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.shareTitle  descr:model.shareText thumImage:model.shareImage];
    //设置网页地址
    shareObject.webpageUrl =model.shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");

        }
    }];
}
/**复制链接*/
- (void)pasteboard:(BigerShareModel *)model delegate:(UIViewController *)delegate{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    if(model.shareUrl){
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string=model.shareText;
        UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
        [currentPresentedVC wh_showHintOnViewWithText:ALS(@"分享内容已复制到剪切板，请手动粘贴")];
    }else{
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string=@"";
        UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
        [currentPresentedVC wh_showHintOnViewWithText:ALS(@"分享内容已复制到剪切板，请手动粘贴")];
    }
}
/**Email*/
- (void)emailShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    [self resetModel:model];
   
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareEmailObject *shareObject=[[UMShareEmailObject alloc] init];
    shareObject.emailContent=[NSString stringWithFormat:@"%@  %@",model.shareText,model.shareUrl];
    shareObject.emailImage=model.shareImage;
    shareObject.subject=model.shareTitle;
    messageObject.shareObject=shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    
    if (![MFMailComposeViewController canSendMail]) {
        UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
        [currentPresentedVC wh_showHintOnViewWithText:ALS(@"请前往系统邮箱添加邮箱账户")];
        return;
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Email messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];
}
/**twitter*/
- (void)twitterShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    [self resetModel:model];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.shareTitle descr:model.shareText thumImage:model.shareImage];
    shareObject.webpageUrl=[NSString stringWithFormat:@"%@ %@",model.shareText,model.shareUrl];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Twitter messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
            if(error.code==187){
                UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
                [currentPresentedVC wh_showHintOnViewWithText:ALS(@"您已经分享过该内容了!")];
            }else{
                UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
                [currentPresentedVC wh_showHintOnViewWithText:ALS([NSString stringWithFormat:@"分享失败"])];
            }
            
        }else{
            UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
            [currentPresentedVC wh_showHintOnViewWithText:ALS(@"已分享到Twitter,请前往Twitter查看")];
        }
    }];
}
#pragma mark-快讯分享模块
/**微信分享**/
- (void)fastnews_wxShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.shareImage =model.shareImage;
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];
}



/**微信朋友圈*/
- (void)fastnews_wxFriendShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.shareImage =model.shareImage;
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];
    
}


/**QQ分享**/
- (void)fastnews_qqShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.shareImage =model.shareImage;
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];
}


/**QQ空间*/
- (void)fastnews_qqSpaceShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.shareImage =model.shareImage;
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];
}
/**保存图片*/
- (void)fastnews_saveImage:(BigerShareModel *)model delegate:(UIViewController *)delegate{
    UIViewController * ctrl = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
    if(model.shareImage){
        UIImageWriteToSavedPhotosAlbum(model.shareImage, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }else{
        [ctrl wh_showHintOnViewWithText:ALS(@"保存失败")];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIViewController * ctrl = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
    if(error){
        [ctrl wh_showHintOnViewWithText:ALS(@"保存失败,请开启相册权限")];
        return;
    }
    [ctrl wh_showHintOnViewWithText:ALS(@"保存成功")];
}

/**Email*/
- (void)fastnews_emailShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareEmailObject *shareObject=[[UMShareEmailObject alloc] init];
    shareObject.emailImage=model.shareImage;
    messageObject.shareObject=shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    
    if (![MFMailComposeViewController canSendMail]) {
        UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
        [currentPresentedVC wh_showHintOnViewWithText:ALS(@"请前往系统邮箱添加邮箱账户")];
        return;
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Email messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            
            NSLog(@"************Share fail with error %ld*********",error.code);
        }else{
            NSLog(@"分享成功！");
        }
    }];
}
/**twitter*/
- (void)fastnews_twitterShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate{
    [self resetModel:model];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.shareImage =model.shareImage;
    messageObject.shareObject = shareObject;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareSuccess" object:nil];
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Twitter messageObject:messageObject currentViewController:delegate completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %ld*********",error.code);
            if(error.code==187){
                UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
                [currentPresentedVC wh_showHintOnViewWithText:ALS(@"您已经分享过该内容了!")];
            }else{
                UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
                [currentPresentedVC wh_showHintOnViewWithText:ALS([NSString stringWithFormat:@"分享失败"])];
            }
            
        }else{
            UIViewController * currentPresentedVC = [[[UIApplication sharedApplication].delegate window] wh_currentViewController];
            [currentPresentedVC wh_showHintOnViewWithText:ALS(@"已分享到Twitter,请前往Twitter查看")];
        }
    }];
}

@end
