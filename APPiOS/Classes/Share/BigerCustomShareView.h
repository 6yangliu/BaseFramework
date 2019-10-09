//
//  BigerCustomShareView.h
//  APPiOS
//
//  Created by 刘吉星 on 2018/6/22.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EShareType){
    /**默认*/
    EShareType_default,
    /**快讯*/
    EShareType_fastnews,
};

typedef NS_ENUM(NSInteger, EShareButtonType){
    /** 复制链接*/
    EShareButtonCopy=1000,
    /** 分享到微信好友 */
    EShareButtonWechat,
    /** 分享到微信朋友圈 */
    EShareButtonWechatSocial,
    /** 分享到QQ */
    EShareButtonQQ,
    /** 分享到QQ空间 */
    EShareButtonQQZone,
    /** 分享到Sina */
    EShareButtonSina,
    /** 分享到Email */
    EShareButtonEmail,
    /** 分享到Facebook */
    EShareButtonFacebook,
    /** 分享到Twitter */
    EShareButtonTwitter,
    /** 保存图片 */
    EShareButtonSaveImage,
};
@protocol ShareCustomDelegate <NSObject>      //协议
@required
- (void)shareWithType:(EShareButtonType)buttonType;

@optional
- (void)didShareViewHide;

@end

@interface BigerCustomShareView : UIView

@property(nonatomic,retain)id <ShareCustomDelegate> shareDelegate; //代理

+ (instancetype)createCustomShareViewWithShareType:(EShareType)type;

- (void)show;

@end
