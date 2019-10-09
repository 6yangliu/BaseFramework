//
//  SXBackPower.h
//  APPiOS
//  App后台数据中心
//  Created by liuy on 2018/5/18.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

typedef void(^UpdateUserInfo)(UserModel * userinfo);

@interface SXBackPower : NSObject
{
   
}
@property (nonatomic,strong) NSDictionary*IO_RemoteNotification;

@property (nonatomic, copy)  UpdateUserInfo updateUserInfoBlock;

+(SXBackPower *)instance;

//获取个人信息
- (void)getUserInfo;

@end
