//
//  BigerShareManager.h
//  APPiOS
//
//  Created by 刘吉星 on 2018/6/22.
//  Copyright © 2018年 shengxi. All rights reserved.
//


#define UM_APIKEY           @"54c87babfd98c5a133000873"
#define WX_APP_KEY          @"wx2e76d1b9af059873"
#define WX_APP_SECRET       @"7bd1775d847e4d90e6943248533e975d"
#define QQ_APP_KEY          @"1104255576"
#define QQ_APP_SECRET       @"VpvEQv7kFBPaWf8H"
#define SINA_APP_KEY        @""
#define SINA_APP_SECRET     @""
#define twitter_APP_KEY        @"KrLVsNV54SIln69wYUK8VXdYK"
#define twitter_APP_SECRET     @"BaVhor7zRKzUEyxRb7TsUb2jQqt3k9K35Ep69qBEYeWwlHVM6S"

#import <Foundation/Foundation.h>
#import "BigerShareModel.h"
@interface BigerShareManager : NSObject
+ (BigerShareManager *)shareManage;
//====================默认的分享板块(活动)====================
/**微信分享**/
- (void)wxShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**微信朋友圈*/
- (void)wxFriendShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**新浪微博分享**/
- (void)snShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**QQ分享**/
- (void)qqShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**QQ空间*/
- (void)qqSpaceShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**复制链接*/
- (void)pasteboard:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**邮件*/
- (void)emailShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate;
/**twitter*/
- (void)twitterShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate;
//===================================================

//====================快讯的分享板块====================
/**微信分享**/
- (void)fastnews_wxShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**微信朋友圈*/
- (void)fastnews_wxFriendShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**新浪微博分享**/
- (void)fastnews_snShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**QQ分享**/
- (void)fastnews_qqShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**QQ空间*/
- (void)fastnews_qqSpaceShareWithModel:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**保存图片*/
- (void)fastnews_saveImage:(BigerShareModel *)model delegate:(UIViewController *)delegate;
/**邮件*/
- (void)fastnews_emailShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate;
/**twitter*/
- (void)fastnews_twitterShareWithModel:(BigerShareModel *)model  delegate:(UIViewController *)delegate;




@property (nonatomic, strong) void (^coronaShareResult)(void);

@end
