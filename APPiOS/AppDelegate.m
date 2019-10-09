//
//  AppDelegate.m
//  APPiOS
//
//  Created by 丁洋洋 on 2018/4/24.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "AppDelegate.h"
#import "MYTabBarController.h"
#import "IQKeyboardManager.h"
#import <UMShare/UMShare.h>
#import "UserManager.h"
#import "ErrorModel.h"
#import "LoginViewController.h"

@interface AppDelegate ()<KDNetURCProtocol>
@property (nonatomic, strong) ErrorModel *errModel;
@property (nonatomic, strong) SXBackPower *backPower;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //加载App主题配色方案
    [[SXColorScheme Instance] loadScheme:COLOR_SCHEME_BLACK];
    [NSThread sleepForTimeInterval:1];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.layer.cornerRadius = 5;
    self.window.layer.masksToBounds = YES;
    
    if([UserManager sharedUserManager].isLogin){
        [self loadRootCtrl];
    }else{
        [self loadOtherCtrl];
    }
    
    //后台数据中心
    self.backPower=[SXBackPower instance];
    //添加网络监听
    [GLobalRealReachability startNotifier];

    //配置键盘
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    application.statusBarHidden = NO;
    
    /* 设置友盟appkey */
    [UMConfigure initWithAppkey:UmengAppkey channel:@"ios"];
    // U-Share 平台设置
    [self configUSharePlatforms];
    [UMConfigure setLogEnabled:YES];//开发YES
    
    #ifdef __PROD__
        //友盟统计初始化友盟所有组件(生产环境有效)
        [MobClick setCrashReportEnabled:YES];
        [MobClick setScenarioType:E_UM_NORMAL];
        [UMConfigure setLogEnabled:NO];//线上NO
        [UMConfigure setEncryptEnabled:YES];//设置是否对统计信息进行加密传输, 默认NO(不加密).
        NSString* deviceID =  [UMConfigure deviceIDForIntegration];
        NSLog(@"集成测试的deviceID:%@",deviceID);
    #else
    #endif
    
    //推送
    UIApplication *app=[UIApplication sharedApplication];
    [app setIdleTimerDisabled:YES];//控制是否取消应用程序空闲时间
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [app registerUserNotificationSettings:mySettings];
    [app registerForRemoteNotifications];
    
    self.IO_RemoteNotification=[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    //极光推送    isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppkey
                          channel:nil
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginNotification:) name:kJPFNetworkDidLoginNotification object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
   
    return YES;
}
-(void)loadRootCtrl{
    self.tabBarVC = [[MYTabBarController alloc] init];
    self.window.rootViewController = self.tabBarVC;
    [self.window makeKeyAndVisible];
}
-(void)loadOtherCtrl{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = loginNav;
    [self.window makeKeyAndVisible];
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    [self RegisterForRemoteNotifications:deviceToken];
    [JPUSHService registerDeviceToken:deviceToken];
}
-(void)didLoginNotification:(NSNotification *)userinfo{
    
    if ([JPUSHService registrationID]) {
        self.mBPushChannelId= [JPUSHService registrationID];
        NSLog(@"get RegistrationID");
    }
    
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    [self FailToRegisterNotifications:application Error:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    [JPUSHService handleRemoteNotification:userInfo];
}
-(void)RegisterForRemoteNotifications:(NSData*)deviceToken{
    NSString *deviceTokenStr =[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""];
    deviceTokenStr=[deviceTokenStr stringByReplacingOccurrencesOfString: @">" withString: @""];
    deviceTokenStr=[deviceTokenStr stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSMutableDictionary *AppConfigDic=[FileManager LoadLocData:DB_AppConfig];
    [AppConfigDic setObject:deviceTokenStr forKey:@"dtoken"];
    [FileManager SaveLocData:DB_AppConfig dic:AppConfigDic];
}
-(void)FailToRegisterNotifications:(UIApplication*)application Error:(NSError*)error{
    NSLog(@"Failed to get devicetoken:%@", error);
    NSMutableDictionary *AppConfigDic=[FileManager LoadLocData:DB_AppConfig];
    [AppConfigDic setObject:@"IOSSimulator" forKey:@"dtoken"];
    [FileManager SaveLocData:DB_AppConfig dic:AppConfigDic];
}

//禁用第三方键盘
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    return NO;
    
}
#pragma mark-UMShare
- (void)configUSharePlatforms
{
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx36909d90a6904ad1" appSecret:@"4c48209844b6206d6011107717a1b0bc" redirectURL:nil];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1108007379"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [[UMSocialManager defaultManager]  handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_rotation_Style == 1) {//如果是1就让屏幕强制横屏
        return UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
    }
    else
    {
        return (UIInterfaceOrientationMaskPortrait);
    }
}

@end
