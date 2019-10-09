//
//  LoginViewController.h
//  APPiOS
//
//  Created by liuy on 2018/6/20.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "ForgetPwdView.h"

@implementation ForgetPwdView

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
 
    
    UIView *verCodeleftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenPrt(40), KScreenPrt(40))];
    UIImageView *vercodeICON=[[UIImageView alloc] initWithFrame:CGRectMake(verCodeleftView.width/2-KScreenPrt(22)/2, verCodeleftView.height/2-KScreenPrt(22)/2, KScreenPrt(22), KScreenPrt(22))];
    vercodeICON.image=[UIImage imageNamed:@"vercode_icon"];
    [verCodeleftView addSubview:vercodeICON];
    
    
    UITextField *verCodeField = [[UITextField alloc] initWithFrame:CGRectMake(0, phoneNumField.bottom+KScreenPrt(10), self.width, KScreenPrt(40))];
    verCodeField.borderStyle = UITextBorderStyleNone;
    verCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    verCodeField.placeholder = ALS(@"请输入验证码");
    verCodeField.font = [UIFont boldSystemFontOfSize:KScreenPrt(16)];
    [verCodeField setValue:RGB(174, 187, 199) forKeyPath:@"_placeholderLabel.textColor"];
    [verCodeField setValue:[UIFont boldSystemFontOfSize:KScreenPrt(14)] forKeyPath:@"_placeholderLabel.font"];
    self.verCodeField = verCodeField;
    
    verCodeField.leftView=verCodeleftView;
    verCodeField.leftViewMode=UITextFieldViewModeAlways;
    verCodeField.layer.cornerRadius=KScreenPrt(6);
    verCodeField.layer.borderColor=UIColorFromRGB(0xE8E8E8).CGColor;
    verCodeField.layer.borderWidth=0.5;
    
    
    UIView *verCoderightView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenPrt(80), KScreenPrt(40))];
    JKCountDownButton *sendCodeBtn = [[JKCountDownButton alloc] initWithFrame:CGRectMake(0, 0, KScreenPrt(80), KScreenPrt(40))];
    
    [sendCodeBtn setTitle:@"发送验证码" forState:0];
    [sendCodeBtn setTitleColor:RGB(174, 187, 199) forState:0];
    sendCodeBtn.titleLabel.font=[UIFont systemFontOfSize:KScreenPrt(14)];
    [verCoderightView addSubview:sendCodeBtn];
    sendCodeBtn.center=CGPointMake(verCoderightView.width/2, verCoderightView.height/2);
    verCodeField.rightView=verCoderightView;
    verCodeField.rightViewMode=UITextFieldViewModeAlways;
   
    self.verCodeField = verCodeField;
    [self addSubview:self.verCodeField];
    self.sendCodeBtn=sendCodeBtn;
    
    UIView *pwdleftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenPrt(40), KScreenPrt(40))];
    UIImageView *pwdICON=[[UIImageView alloc] initWithFrame:CGRectMake(pwdleftView.width/2-KScreenPrt(22)/2, pwdleftView.height/2-KScreenPrt(22)/2, KScreenPrt(22), KScreenPrt(22))];
    pwdICON.image=[UIImage imageNamed:@"pwd_icon"];
    [pwdleftView addSubview:pwdICON];
    
    
    UITextField *passWordField = [[UITextField alloc] initWithFrame:CGRectMake(0, verCodeField.bottom+KScreenPrt(10), self.width, KScreenPrt(40))];
    passWordField.borderStyle = UITextBorderStyleNone;
    passWordField.secureTextEntry = YES;
    passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordField.placeholder = ALS(@"请输入新密码");
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
    passWordField.rightView=lookPawButton;
    passWordField.rightViewMode=UITextFieldViewModeAlways;
    self.lookPawButton=lookPawButton;
    
    [self addSubview:self.passWordField];
   
    
    UIButton *regButton = [[UIButton alloc] init];
    [regButton setTitle:ALS(@"重置密码") forState:UIControlStateNormal];
    [regButton setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    regButton.titleLabel.font =[UIFont systemFontOfSize:KScreenPrt(17)];
    regButton.layer.cornerRadius = KScreenPrt(4);
    self.regButton = regButton;
    
    self.regButton.width=self.width;
    self.regButton.height=KScreenPrt(44);
    self.regButton.left=0;
    self.regButton.top=passWordField.bottom+KScreenPrt(20);
    [self addSubview:regButton];
    self.height=self.regButton.bottom;
}

@end

