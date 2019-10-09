//
//  LoginViewController.h
//  APPiOS
//  登录
//  Created by liuy on 2018/6/20.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^LoginSucBlock)(id *obj);

@interface LoginViewController : BaseViewController

@property (nonatomic, copy) LoginSucBlock loginSucBlock;

@end
