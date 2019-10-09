//
//  BaseViewController.m
//  APPiOS
//
//  Created by 清阳 on 2018/5/9.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "BaseViewController.h"
#import "UserManager.h"
#import "SXToolsMacro.h"
#import "LoginViewController.h"

#define kBtnChoosePictureHeight         50

#define Font_Choose_PictureItem         FontSystem(17.0f)
#define Color_Moments_ChooseBg          UIColorFromRGB(0xe5e5e5)

@interface BaseViewController () {
    BOOL isNotShowStatusBar;
    UIImageView *navBarHairlineImageView;
}

@property (strong, nonatomic) MBProgressHUD             *progressHud;
@property (assign, nonatomic) BOOL                      isHeadQuarter;

@end

@implementation BaseViewController
@synthesize navigationBar;
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [MobClick beginLogPageView:[self description]];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [MobClick endLogPageView:[self description]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNetNotification];
    //设置页面背景
    self.view.backgroundColor =[SXColorScheme getColor:COLOR_MainViewBackColor];
    [self reSetNavigationBar];
    self.isRequestProcessing = NO;
    _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    self.progressHud.bezelView.alpha = 0.5;
    
    if(![self isConnectionAvailable]){
        [self showNoNetWorkAlert];
    }
    
}
//设置UINavigationbar
- (void)reSetNavigationBar{
    //设置导航栏Title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[[SXColorScheme Instance] getColor:COLOR_NavTitleColor],
                                            NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;

    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[[SXColorScheme Instance] getColor:COLOR_NavColor]] forBarMetrics:0];
    [self.navigationController.navigationBar setShadowImage:[self createImageWithColor:[[SXColorScheme Instance] getColor:COLOR_NavColor]]];
    
    UIImageView *lineImgView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    lineImgView.hidden = YES;
    
}
-(void)addNetNotification{
    // 网络变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
}
//找到UINavigationBar下面的线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)NeedRefreshFatherCtrl:(id)obj{
    
}

- (void)OnSubCtrlCallRC:(id)obj{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showMessage:(NSString *)msg{
    [self hideLoading];
    if ([msg isEqualToString:@""]) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = msg;
    hud.detailsLabel.font = SXFont(18);
    hud.margin = 15;
    hud.backgroundView.alpha = 0.8;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.0];
}

- (void)showLoading:(NSString *)msg{
    
    [self hideLoading];
    self.loadingHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.loadingHud.label.text = ALS(@"加载中");
    self.loadingHud.backgroundView.alpha = 0.8;
}

- (void)hideLoading{
    
    [self.loadingHud hideAnimated:YES];
}
#pragma mark-本类事件回调
-(BOOL)isConnectionAvailable{
    BOOL isConnectTheInternet = YES;
    Reachability *reachConnect = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reachConnect currentReachabilityStatus]) {
        case NotReachable:
            isConnectTheInternet = NO;
            break;
        case ReachableViaWiFi:
            isConnectTheInternet = YES;
            break;
        case ReachableViaWWAN:
            isConnectTheInternet = YES;
            break;
        default:
            break;
    }
    return isConnectTheInternet;
}
#pragma mark ==================网络变化监听事件的回调==================
- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    if(status==RealStatusViaWiFi&&_netStatus==HKNetWorkStatusWifi){
        return;
    }
    if(status==RealStatusViaWiFi&&_netStatus==HKNetWorkStatusFlow){
        return;
    }
    if(status==RealStatusViaWWAN&&_netStatus==HKNetWorkStatusWifi){
        return;
    }
    if(status==RealStatusViaWWAN&&_netStatus==HKNetWorkStatusFlow){
        return;
    }
    
    switch (status) {
        case RealStatusNotReachable:
            _netStatus=HKNetWorkStatusNoInternet;
            break;
        case RealStatusViaWiFi:
            _netStatus=HKNetWorkStatusWifi;
            break;
        case RealStatusViaWWAN:
            _netStatus=HKNetWorkStatusFlow;
            break;
        default:
            break;
    }
    if([[self currentViewController] isKindOfClass:[self class]]){
        [self baseNetStateChanged:_netStatus];
    }
    
    
}
#pragma mark ==================网络状态改变==================
-(void)baseNetStateChanged:(NSInteger)state{
    if(state==HKNetWorkStatusNoInternet){
//        [self showNoNetWorkAlert];
    }
}
-(void)showNoNetWorkAlert{
    //子类实现
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:ALS(@"提示") message:ALS(@"无网络链接，请检查网络设置") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:ALS(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:ALS(@"设置") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark- 横竖屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return YES;
}


#pragma --mark 页面基本设置
/**
 *  页面基本设置,页面背景颜色、页面是否包含返回按钮、对返回按钮做相应的处理
 *
 *  @param gobackType 页面返回类型
 */
- (void)baseSetup:(PageGobackType)gobackType{
    
    //设置返回按钮
    if (gobackType != PageGobackTypeNone) {
        _btnLeft = [[XYButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        
        [_btnLeft setTitle:@"" forState:UIControlStateNormal];
        UIImage *image=[UIImage imageNamed:[SXColorScheme getImageName:@"NavLeftBack"]];
        [_btnLeft setImage:image forState:UIControlStateNormal];
        _btnLeft.contentMode = UIViewContentModeScaleAspectFit;
        [_btnLeft setImageEdgeInsets:UIEdgeInsetsMake(5,5,5,5)];
        
        if(self.leftActionBlock){
            [_btnLeft addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        }else{
            if (gobackType == PageGobackTypePop) {
                [_btnLeft addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
            }else if (gobackType == PageGobackTypeDismiss){
                [_btnLeft addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
            }else if (gobackType == PageGobackTypeRoot){
                [_btnLeft addTarget:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
       
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_btnLeft];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -5;
        (self.navigationItem).leftBarButtonItems = @[negativeSpacer,leftItem];
    }else{
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        (self.navigationItem).leftBarButtonItem = leftItem;
    }
}

/**
 *  dimiss页面
 */
- (void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.tabBarController.tabBar.hidden = NO;
}

/**
 *返回任意一个页面
 */
- (void)popToViewControllerAtIndex:(NSInteger)index{
    if (self.navigationController.viewControllers.count > index) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index] animated:YES];
    }
}

/**
 *popToRoot页面
 */
- (void)popToRoot{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  pop页面
 */
- (void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dsPushViewController:(UIViewController*)vc animated:(BOOL)animated{
    if (self.navigationController.viewControllers.count == 1) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRealReachabilityChangedNotification object:nil];
    NSLog(@"%@dealloc",[self description]);

}

-(void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number {
    NSString *numberKey = @"__ct__";
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:attributes];
    [mutableDictionary setObject:[number stringValue] forKey:numberKey];
}
//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

//设置导航栏右边按钮
- (void)setRightButtonWithTitle:(NSString *)title withImageName:(NSString *)imgName withFrame:(CGRect)frame withBlock:(void (^)(void))block{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:frame];
    if (title) {
        [rightButton setTitle:title forState:UIControlStateNormal];
    }
    if (imgName) {
        [rightButton setBackgroundImage:IMAGENAMED(imgName) forState:UIControlStateNormal];
    }
    rightButton.titleLabel.font = FONT(15);
    [rightButton setTitleColor:BIGER_TITLE_COLOR forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.rightActionBlock = block;
}

//设置导航栏左边按钮
- (void)setLeftButtonWithTitle:(NSString *)title withImageName:(NSString *)imgName withFrame:(CGRect)frame withBlock:(void (^)(void))block{
    XYButton *leftButton = [[XYButton alloc] initWithFrame:frame];
    if (title) {
        [leftButton setTitle:title forState:UIControlStateNormal];
    }
    if (imgName) {
        [leftButton setBackgroundImage:IMAGENAMED(imgName) forState:UIControlStateNormal];
    }
    leftButton.titleLabel.font = FONT(15);
    [leftButton setTitleColor:BIGER_TITLE_COLOR forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftActionBlock = block;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)rightClick{
    if (self.rightActionBlock) {
        self.rightActionBlock();
    }
}

- (void)leftClick{
    if (self.leftActionBlock) {
        self.leftActionBlock();
    }
}
//通过颜色生成图片
- (UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//跳转首页
- (void)jumpToHome{
    
    MYTabBarController *tabbar=(MYTabBarController *)SXAppDelegate.tabBarVC;
    [tabbar selectController:tabbar.tabbarView.tabBtn01];
    [tabbar setSelectedIndex:0];
    
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
//跳转登录
-(LoginViewController *)jumpToLogin{
    [appDelegate loadOtherCtrl];
    return nil;
}
//销毁上一个控制器
- (void)destroyMiddleController
{
    if (self.navigationController.viewControllers.count >= 3) {//viewControllers.count大于3 才有中间页面
        NSMutableArray *ctrls = self.navigationController.viewControllers.mutableCopy;
        NSMutableArray *newCtrls = [NSMutableArray array];
        for (int i=0; i<ctrls.count;i++) {
            if(i!=ctrls.count-2){
                [newCtrls addObject:ctrls[i]];
            }
        }
        [self.navigationController setViewControllers:newCtrls animated:NO];
    }
}

- (UIViewController*)currentViewController;
{
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController* currentViewController =window.rootViewController;
    
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
        currentViewController = currentViewController.presentedViewController;
    } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController* )currentViewController;
        currentViewController = [navigationController.childViewControllers lastObject];
    } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController* )currentViewController;
        currentViewController = tabBarController.selectedViewController;
    } else {
        NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

@end
