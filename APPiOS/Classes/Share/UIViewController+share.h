//
//  UIViewController+share.h
//  APPiOS
//
//  Created by 刘吉星 on 2018/6/22.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigerShareManager.h"
#import "BigerShareModel.h"
#import "BigerCustomShareView.h"

typedef void(^BackBlock)(id obj);
@interface UIViewController (share)<ShareCustomDelegate>



- (void)showShareWithModel:(BigerShareModel *)model friendModel:(BigerShareModel *)friendModel shareType:(EShareType)shareType;

- (void)setShareModel:(BigerShareModel *)model friendModel:(BigerShareModel *)friendModel shareType:(EShareType)shareType;

@end
