//
//  UserManager.m
//  EveryDay
//
//  Created by Krisc.Zampono on 15/6/25.
//  Copyright (c) 2015年 Krisc.Zampono. All rights reserved.
//

#import "UserManager.h"
#import <objc/runtime.h>
#import "SXToolsMacro.h"

#define USER_MANAGER    @"user_manager_1.1.0"
#define LOGIN_MANAGER    @"login_manager_1.1.0"

@implementation UserManager

+ (UserManager*)sharedUserManager{
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserManager alloc] init];
        [manager initUser];
    });
    return manager;
}

- (void)initUser{
    self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[UserDefaults objectForKey:USER_MANAGER]];
    if(!self.userInfo)self.userInfo=[[UserModel alloc] init];
    self.loginInfo=[NSKeyedUnarchiver unarchiveObjectWithData:[UserDefaults objectForKey:LOGIN_MANAGER]];
    if(!self.loginInfo)self.loginInfo=[[LoginModel alloc] init];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = vars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(vars);
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    unsigned int count = 0;
    if (self = [super init]) {
        Ivar *vars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar var = vars[i];
            const char *name = ivar_getName(var);
            //归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(vars);
    }
    return self;
}



- (BOOL)isLogin{
    NSString *sessionid = [UserDefaults objectForKey:@"api_token"];
    if (sessionid.length > 0) {
        return YES;
    }
    return NO;
}

//退出登录
- (void)logout{
    [UserDefaults setValue:@"" forKey:@"api_token"];
    [UserDefaults setValue:[NSKeyedArchiver archivedDataWithRootObject:[LoginModel new]] forKey:LOGIN_MANAGER];
    self.userInfo=nil;
    self.loginInfo.token=nil;
    [UserDefaults synchronize];
}
//登录信息
- (void)updateLoginInfo:(LoginModel *)loginModel{
    self.loginInfo = [LoginModel mj_objectWithKeyValues:loginModel];
    [UserDefaults setValue:[NSKeyedArchiver archivedDataWithRootObject:self.loginInfo] forKey:LOGIN_MANAGER];
    [UserDefaults setValue:self.loginInfo.token forKey:@"api_token"];
    [UserDefaults synchronize];
}
//用户信息
- (void)updateUserInfo:(UserModel *)userModel{
    self.userInfo = [UserModel mj_objectWithKeyValues:userModel];
    [UserDefaults setValue:[NSKeyedArchiver archivedDataWithRootObject:self.userInfo] forKey:USER_MANAGER];
    [UserDefaults synchronize];
}


@end
