//
//  LoginViewController.h
//  APPiOS
//
//  Created by liuy on 2018/6/20.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"
@interface ForgetPwdView : UIView

@property (nonatomic, strong) UITextField *phoneNumField;

@property (nonatomic, strong) UITextField *verCodeField;

@property (nonatomic, strong) UITextField *passWordField;

@property (nonatomic, strong) UIButton *regButton;

@property (nonatomic, strong) JKCountDownButton *sendCodeBtn;

@property (nonatomic, strong) UIButton *lookPawButton;


@end
