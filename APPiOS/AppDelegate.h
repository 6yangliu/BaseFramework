//
//  AppDelegate.h
//  APPiOS
//
//  Created by 丁洋洋 on 2018/4/24.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTabBarController.h"
#import "SXBackPower.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,assign)NSInteger rotation_Style;//是否横屏

@property (nonatomic, strong) MYTabBarController *tabBarVC;
    
@property(nonatomic,strong) NSDictionary *IO_RemoteNotification;

@property (nonatomic, strong) NSString *mBPushChannelId;

-(void)loadRootCtrl;

-(void)loadOtherCtrl;

@end

