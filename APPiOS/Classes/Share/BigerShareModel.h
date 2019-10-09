//
//  BigerShareModel.h
//  APPiOS
//
//  Created by 刘吉星 on 2018/6/22.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigerShareModel : NSObject

/**  分享数据标识 */
@property (nonatomic, copy) NSString * entrance;

/** type:1 普通分享 2 朋友圈 */
@property (nonatomic, copy) NSString * type;

/** 分享的url */
@property (nonatomic, copy) NSString * shareUrl;
/** 分享的图片 */
@property (nonatomic, copy) NSString * shareImageUrl;
/** 分享图片*/
@property (nonatomic, strong) UIImage * shareImage;
/** 分享的标题 */
@property (nonatomic, copy) NSString * shareTitle;
/** 分享的内容 */
@property (nonatomic, copy) NSString * shareText;

@end
