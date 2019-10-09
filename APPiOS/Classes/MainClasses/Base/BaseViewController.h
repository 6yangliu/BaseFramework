//
//  BaseViewController.h
//  APPiOS
//
//  Created by 清阳 on 2018/5/9.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SXCtrlProtocol.h"

typedef enum{
    PageGobackTypeNone,
    PageGobackTypeDismiss,
    PageGobackTypePop,
    PageGobackTypeRoot
}PageGobackType;


typedef NS_ENUM(NSUInteger, HKNetWorkStatus) {
    HKNetWorkStatusNoInternet,//没有网络
    HKNetWorkStatusFlow,//流量连接
   HKNetWorkStatusWifi //wifi链接
};
typedef void(^BackSucBlock)(id obj);

@class LoginViewController;
@interface BaseViewController : UIViewController<KDNetURCProtocol,SXCtrlProtocol>

@property(nonatomic,strong) id backData;

@property(nonatomic,weak) id<SXCtrlProtocol> dlt;
@property (nonatomic,assign) HKNetWorkStatus netStatus;
@property (assign, nonatomic) BOOL isRequestProcessing;//请求是否在处理中
@property (nonatomic, copy) void (^rightActionBlock)(void);
@property (nonatomic, copy) void (^leftActionBlock)(void);
@property (strong, nonatomic) MBProgressHUD *loadingHud;
@property (nonatomic, copy) BackSucBlock backSucBlock;
@property(nonatomic,strong)UINavigationBar *navigationBar;
@property(nonatomic,strong)XYButton *btnLeft;

/**
 *  页面基本设置
 *
 *  @param gobackType 页面返回类型
 */
- (void)baseSetup:(PageGobackType)gobackType;
/**
 *  外部调用设置
 *
 */
- (void)reSetNavigationBar;
/**
 *  现实提示信息
 *
 *  @param msg 要显示的消息内容
 */
- (void)showMessage:(NSString *)msg;

/**
 *  显示加载框
 *
 *  @param msg 提示内容
 */
- (void)showLoading:(NSString *)msg;

/**
 *  隐藏加载框
 */
- (void)hideLoading;

/**
 *  用于push vc 隐藏tabbar
 *
 *  @param vc       要push的vc
 *  @param animated 动画效果
 */
- (void)dsPushViewController:(UIViewController*)vc animated:(BOOL)animated;

/**
 *  dimiss页面
 */
- (void)dismissVC;

/**
 *popToRoot页面
 */
- (void)popToRoot;

/**
 *返回任意一个页面
 */
- (void)popToViewControllerAtIndex:(NSInteger)index;

/**
 *  pop页面
 */
- (void)popVC;


- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay;

//设置导航栏右边按钮
- (void)setRightButtonWithTitle:(NSString *)title withImageName:(NSString *)imgName withFrame:(CGRect)frame withBlock:(void (^)(void))block;

//设置导航栏左边按钮
- (void)setLeftButtonWithTitle:(NSString *)title withImageName:(NSString *)imgName withFrame:(CGRect)frame withBlock:(void (^)(void))block;

//通过颜色生成图片
- (UIImage*)createImageWithColor:(UIColor*) color;

//跳转首页
-(void)jumpToHome;
//跳转登录
-(LoginViewController *)jumpToLogin;

//销毁上一个控制器
- (void)destroyMiddleController;

-(void)baseNetStateChanged:(NSInteger)state;

-(BOOL)isConnectionAvailable;

- (UIViewController*)currentViewController;
@end
