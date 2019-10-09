//
//  LoginViewController.m
//  APPiOS
//
//  Created by liuy on 2018/6/20.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterViewController.h"
#import "ForgetPwdController.h"
#import "DSUtils.h"
#import "YBBKeychain.h"
#import "UserModel.h"
//#import "ForgetPasswordViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) ErrorModel *errModel;


@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
    [self initData];
    [self reloadUIData];
}

-(void)initUI{
    [self initSubView];
}
-(void)initData{
    
}
-(void)reloadUIData{
    
}
#pragma mark-UI区
- (void)initSubView{
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenPrt(16), KScreenPrt(KStatusBarHeight+10), KScreenPrt(24), KScreenPrt(24))];
    [closeButton setBackgroundImage:IMAGENAMED(@"login_close") forState:UIControlStateNormal];
    [closeButton addActionHandler:^(NSInteger tag) {
        [self dismissVC];
    }];
    [self.view addSubview:closeButton];
    closeButton.hidden=YES;
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-KScreenPrt(70))/2.0, KNavBarHeight+KScreenPrt(140), KScreenPrt(70), KScreenPrt(70))];
    logoImage.image = [UIImage imageNamed:@"app_logo"];
    logoImage.layer.cornerRadius=KScreenPrt(8);
    logoImage.clipsToBounds=YES;
    [self.view addSubview:logoImage];
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:CGRectMake(KScreenPrt(16), logoImage.bottom+KScreenPrt(40), self.view.width-KScreenPrt(16)*2, 0)];
    self.loginView = loginView;
    
   
    [_loginView.loginButton setBackgroundColor:UIColorFromRGB(0x3092fc) forState:UIControlStateNormal];
    [_loginView.loginButton setBackgroundColor:UIColorFromRGB(0x3092fc) forState:UIControlStateHighlighted];
    
    loginView.phoneNumField.delegate = self;
    loginView.passWordField.delegate = self;
    
    loginView.phoneNumField.text=@"18571525727";
    loginView.passWordField.text=@"ly123456";
    
    [loginView.regButton addTarget:self action:@selector(didRegBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginView.lookPawButton addTarget:self action:@selector(lookPaw:) forControlEvents:UIControlEventTouchUpInside];
    [loginView.loginButton addTarget:self action:@selector(didLoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginView.findPasswordButton addTarget:self action:@selector(didFindPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginView];
    
    UILabel *copyRightlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height-KScreenPrt(40), self.view.width, KScreenPrt(40))];
    if(IS_IPHONE_X){
        copyRightlabel.top=copyRightlabel.top-KScreenPrt(34);
    }
    copyRightlabel.textAlignment=1;
    copyRightlabel.font=[UIFont systemFontOfSize:KScreenPrt(12)];
    copyRightlabel.textColor=[SXColorScheme getColor:COLOR_FuTextColor];
    copyRightlabel.text=ALS(@"©Copyright上海锐速展示服务有限公司");
    [self.view addSubview:copyRightlabel];
}
#pragma mark-数据区
- (void)submitLoginData {
    NSString *url= [NSString stringWithFormat:@"%@%@",BASE_URL,api_user_login];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    UIDevice *device = [UIDevice currentDevice];
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    [dic setObject:self.loginView.passWordField.text forKey:@"password"];
    [dic setObject:self.loginView.phoneNumField.text forKey:@"username"];
    [dic setObject:KClient_id forKey:@"client_id"];
    
    
    NSMutableDictionary *AppConfigDic=[FileManager LoadLocData:DB_AppConfig];
    NSString *dtoken=AppConfigDic[@"dtoken"];
    if(dtoken){
        [dic setObject:dtoken forKey:@"imei"];
    }
    [dic setObject:device.systemVersion forKey:@"osversion"];
    [dic setObject:infoDict[@"CFBundleVersion"] forKey:@"version"];
    [self showLoading:@""];
    KDNetHttpReqCenter *req=[[KDNetHttpReqCenter alloc] init];
    [req sendHttpReq:self sendDic:dic URL:url responseDWay:1 api:api_user_login nsl:NO stl:NO];
    
}

#pragma mark- 本类代理回调
#pragma mark-找回密码按钮点击
-(void)didFindPasswordButtonClick:(UIButton *)button{
    
    ForgetPwdController *ctrl=[[ForgetPwdController alloc] init];
    MYNavViewController *nav=[[MYNavViewController alloc] initWithRootViewController:ctrl];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
#pragma mark-登录按钮点击
-(void)didLoginButtonClick:(UIButton *)button{
    
    if (kStringIsEmpty(self.loginView.phoneNumField.text)) {
        [self showMessage:ALS(@"请输入手机号")];
        return;
    }
    if(![self.loginView.phoneNumField.text wh_isMobileNumber]){
        [self showMessage:ALS(@"请输入正确的手机号")];
        return;
    }
    if (kStringIsEmpty(self.loginView.passWordField.text)) {
        [self showMessage:ALS(@"请输入密码")];
        return;
    }
    if(![self.loginView.passWordField.text wh_isPasswordNumber]){
        [self showMessage:ALS(@"请输入8-16位由字母和数字组成的密码")];
        return;
    }
    [self submitLoginData];
    
}
// 显示密码
- (void)lookPaw:(UIButton *)btn {
    
    if (_loginView.passWordField.secureTextEntry == YES) {
        _loginView.passWordField.secureTextEntry = NO;
        [btn setBackgroundImage:IMAGENAMED(@"AccordingPwdOpen") forState:UIControlStateNormal];
    }else if(_loginView.passWordField.secureTextEntry == NO) {
        _loginView.passWordField.secureTextEntry = YES;
        [btn setBackgroundImage:IMAGENAMED(@"eyesDisabled") forState:UIControlStateNormal];
    }
}

// 跳转注册
- (void)didRegBtnClick:(UIButton *)btn{
    
    RegisterViewController *ctrl=[[RegisterViewController alloc] init];
    MYNavViewController *nav=[[MYNavViewController alloc] initWithRootViewController:ctrl];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}


//登录成功会的跳转
-(void)loginSuccessWork{
    [appDelegate loadRootCtrl];
}
#pragma mark-数据回调
- (void)OnHttpErrorBack:(NSMutableDictionary *)api response:(NSURLResponse *)rep{
    [self hideLoading];
    [self showMessage:ALS(@"网络异常")];
}

- (void)OnHttpDataBack:(NSString*)api responseDWay:(int)dw data:(NSData*)data userInfo:(id)userInfo response:(NSURLResponse *)rep{
   
    if([api isEqualToString:api_user_login]){
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [self hideLoading];
        if(jsonDict){
            self.errModel = [ErrorModel getDataWithDict:data];
            if (self.errModel.code==SuccessCode) {
                if(jsonDict[@"data"]){
                    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:jsonDict[@"data"]];
                    [dic setObject:self.loginView.phoneNumField.text forKey:@"phone"];
                    [[UserManager sharedUserManager] updateLoginInfo:[LoginModel mj_objectWithKeyValues:dic]];
                    [self loginSuccessWork];
                    [theAppPower getUserInfo];
                    theAppPower.updateUserInfoBlock = ^(UserModel *userinfo) {
                        [[UserManager sharedUserManager] updateUserInfo:userinfo];
                    };
                    
                }
            }else{
                [self showMessage:self.errModel.msg];
            }
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == self.loginView.passWordField) {
        if (!kStringIsEmpty(toBeString)) {
            [self.loginView.loginButton  setHighlighted:YES];
            
        }else {
            [self.loginView.loginButton setHighlighted:NO];
            
        }
    }
    return YES;
}


@end
