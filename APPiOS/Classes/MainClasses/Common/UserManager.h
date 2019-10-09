//
//  UserManager.h
//  EveryDay
//
//  Created by Krisc.Zampono on 15/6/25.
//  Copyright (c) 2015年 Krisc.Zampono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "LoginModel.h"
@interface UserManager : NSObject

@property (nonatomic, strong) UserModel *userInfo;

@property (nonatomic, strong) LoginModel *loginInfo;

//单例
+ (UserManager*)sharedUserManager;

//是否已经登录
- (BOOL)isLogin;
//退出登录
- (void)logout;
//登录信息
- (void)updateLoginInfo:(LoginModel *)loginModel;
//用户信息
- (void)updateUserInfo:(UserModel *)userModel;

@end
