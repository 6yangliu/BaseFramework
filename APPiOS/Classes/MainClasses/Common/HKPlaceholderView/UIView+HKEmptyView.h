//
//  HKPlaceholderView.h
//  HKPlaceholderView
//  占位View
//  Created by leon on 2017/4/13.
//  Copyright © 2017年 tk_leon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadBlock)(id obj);

/** UIView的占位图类型 */
typedef NS_ENUM(NSInteger, HKPlaceholderViewType) {
    /** 没网 */
    HKPlaceholderViewTypeNoNetwork,
    /** 没数据 */
    HKPlaceholderViewTypeNoData,
    /** 暂停业务 */
    HKPlaceholderViewTypeStopService,
    /** 服务商 */
    HKPlaceholderViewTeam,
    /** 认证 */
    HKPlaceholderViewAuthorized,
    /** 认证 中*/
    HKPlaceholderViewAuthorizing,
    /** 审核不通过*/
    HKPlaceholderViewAuthorizRefuse,
    
    /** 服务商 认证失败 */
    HKPlaceholderViewTeamRefuse
};

@interface UIView (HKEmptyView)

/** 占位图 */
@property (nonatomic, strong, readonly) UIView *placeholderView;

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
#pragma mark - 展示占位图
/**
 展示UIView及其子类的占位图，大小和view一样（本质是在这个view上添加一个自定义view）

 @param type 占位图类型
 @param reloadBlock 重新加载回调的block
 */
- (void)showPlaceholderViewWithType:(HKPlaceholderViewType)type msg:(NSString *)msg :(ReloadBlock)reloadBlock;

#pragma mark - 主动移除占位图
/**
 主动移除占位图
 占位图会在你点击“重新加载”按钮的时候自动移除，你也可以调用此方法主动移除
 */
- (void)removePlaceholderView;

@end
