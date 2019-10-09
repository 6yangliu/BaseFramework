//
//  LoginViewController.h
//  APPiOS
//
//  Created by liuy on 2018/6/20.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    UIView *phoneleftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenPrt(40), KScreenPrt(40))];
    UIImageView *phoneICON=[[UIImageView alloc] initWithFrame:CGRectMake(phoneleftView.width/2-KScreenPrt(22)/2, phoneleftView.height/2-KScreenPrt(22)/2, KScreenPrt(22), KScreenPrt(22))];
    phoneICON.image=[UIImage imageNamed:@"phone_icon"];
    [phoneleftView addSubview:phoneICON];
    
    UITextField *phoneNumField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width, KScreenPrt(40))];
    phoneNumField.borderStyle = UITextBorderStyleNone;
    phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumField.placeholder = ALS(@"请输入您的手机号码");
    phoneNumField.font = [UIFont systemFontOfSize:KScreenPrt(16)];
    [phoneNumField setValue:RGB(174, 187, 199) forKeyPath:@"_placeholderLabel.textColor"];
    [phoneNumField setValue:[UIFont boldSystemFontOfSize:KScreenPrt(14)] forKeyPath:@"_placeholderLabel.font"];
    phoneNumField.textColor=UIColorFromRGB(0x0F3652);
    phoneNumField.keyboardType=UIKeyboardTypeNumberPad;
   
    phoneNumField.leftView=phoneleftView;
    phoneNumField.leftViewMode=UITextFieldViewModeAlways;
    phoneNumField.layer.cornerRadius=KScreenPrt(6);
    phoneNumField.layer.borderColor=UIColorFromRGB(0xE8E8E8).CGColor;
    phoneNumField.layer.borderWidth=0.5;
    self.phoneNumField = phoneNumField;
    [self addSubview:self.phoneNumField];
 
   
    UIView *pwdleftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenPrt(40), KScreenPrt(40))];
    UIImageView *pwdICON=[[UIImageView alloc] initWithFrame:CGRectMake(pwdleftView.width/2-KScreenPrt(22)/2, pwdleftView.height/2-KScreenPrt(22)/2, KScreenPrt(22), KScreenPrt(22))];
    pwdICON.image=[UIImage imageNamed:@"pwd_icon"];
    [pwdleftView addSubview:pwdICON];
    
    
    UITextField *passWordField = [[UITextField alloc] initWithFrame:CGRectMake(0, phoneNumField.bottom+KScreenPrt(10), self.width, KScreenPrt(40))];
    passWordField.borderStyle = UITextBorderStyleNone;
    passWordField.secureTextEntry = YES;
    passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordField.placeholder = ALS(@"8-16位由字母和数字组成的密码");
    passWordField.font = [UIFont boldSystemFontOfSize:KScreenPrt(16)];
    [passWordField setValue:RGB(174, 187, 199) forKeyPath:@"_placeholderLabel.textColor"];
    [passWordField setValue:[UIFont boldSystemFontOfSize:KScreenPrt(14)] forKeyPath:@"_placeholderLabel.font"];
    self.passWordField = passWordField;
    
    passWordField.leftView=pwdleftView;
    passWordField.leftViewMode=UITextFieldViewModeAlways;
    passWordField.layer.cornerRadius=KScreenPrt(6);
    passWordField.layer.borderColor=UIColorFromRGB(0xE8E8E8).CGColor;
    passWordField.layer.borderWidth=0.5;
    
    
    UIView *pwdrightView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenPrt(40), KScreenPrt(40))];
    UIButton *lookPawButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenPrt(24), KScreenPrt(24))];
    [lookPawButton setBackgroundImage:IMAGENAMED(@"eyesDisabled") forState:UIControlStateNormal];
    [pwdrightView addSubview:lookPawButton];
    lookPawButton.center=CGPointMake(pwdrightView.width/2, pwdrightView.height/2);
    passWordField.rightView=pwdrightView;
    passWordField.rightViewMode=UITextFieldViewModeAlways;
    self.lookPawButton=lookPawButton;
    
    [self addSubview:self.passWordField];
   
    
    UIButton *loginButton = [[UIButton alloc] init];
    [loginButton setTitle:ALS(@"登录") forState:UIControlStateNormal];
    [loginButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    loginButton.titleLabel.font =[UIFont systemFontOfSize:KScreenPrt(17)];
    loginButton.layer.cornerRadius = KScreenPrt(4);
    loginButton.layer.masksToBounds = YES;
    self.loginButton = loginButton;
    
    self.loginButton.width=self.width;
    self.loginButton.height=KScreenPrt(44);
    self.loginButton.left=0;
    self.loginButton.top=passWordField.bottom+KScreenPrt(20);
    [self addSubview:loginButton];
    
    UIButton *findPasswordButton = [[UIButton alloc] init];
    [findPasswordButton setTitle:ALS(@"忘记密码") forState:UIControlStateNormal];
    [findPasswordButton setTitleColor:UIColorFromRGB(0x3092FC) forState:UIControlStateNormal];
    findPasswordButton.titleLabel.font = [UIFont systemFontOfSize:KScreenPrt(14)];
    self.findPasswordButton = findPasswordButton;
    [self.findPasswordButton sizeToFit];
    
    self.findPasswordButton.right=self.width;
    self.findPasswordButton.top=self.loginButton.bottom+KScreenPrt(16);
    [self addSubview:findPasswordButton];
    
    UIButton *regButton = [[UIButton alloc] init];
    [regButton setTitle:ALS(@"新用户注册") forState:UIControlStateNormal];
    [regButton setTitleColor:UIColorFromRGB(0x3092FC) forState:UIControlStateNormal];
    regButton.titleLabel.font = [UIFont systemFontOfSize:KScreenPrt(14)];
    self.regButton = regButton;
    [self.regButton sizeToFit];
    
    self.regButton.left=0;
    self.regButton.top=self.loginButton.bottom+KScreenPrt(8);
    [self addSubview:regButton];
    
    self.findPasswordButton.right=self.width;
    self.findPasswordButton.top=self.loginButton.bottom+KScreenPrt(8);
    [self addSubview:findPasswordButton];
    
    self.height=self.findPasswordButton.bottom;
    
}

@end

