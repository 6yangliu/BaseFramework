//
//  LoginViewController.m
//  APPiOS
//
//  Created by liuy on 2018/6/20.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "UpdatePwdController.h"
#import "TYAttributedLabel.h"
#import "CommonWebController.h"
#import "ForgetPwdView.h"

#import "DSUtils.h"
#import "YBBKeychain.h"

@interface UpdatePwdController ()<UITextFieldDelegate,TYAttributedLabelDelegate>
{
    NSString *ctoken;
}
@property (nonatomic, strong) ForgetPwdView *forgetPwdView;
@property (nonatomic, strong) ErrorModel *errModel;


@end

@implementation UpdatePwdController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=ALS(@"修改密码");
        
        ctoken=@"";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self baseSetup:PageGobackTypePop];
    
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
    
    ForgetPwdView *forgetPwdView = [[ForgetPwdView alloc] initWithFrame:CGRectMake(KScreenPrt(16), KScreenPrt(45), self.view.width-KScreenPrt(16)*2, 0)];
    self.forgetPwdView = forgetPwdView;
    
    [forgetPwdView.regButton setBackgroundColor:UIColorFromRGB(0x3092fc) forState:UIControlStateNormal];
    [forgetPwdView.regButton setBackgroundColor:UIColorFromRGB(0x3092fc) forState:UIControlStateHighlighted];
    
    forgetPwdView.phoneNumField.delegate = self;
    forgetPwdView.passWordField.delegate = self;
    [forgetPwdView.sendCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPwdView.lookPawButton addTarget:self action:@selector(lookPaw:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPwdView.regButton addTarget:self action:@selector(didRegButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:forgetPwdView];
   
    NSString *phone=[UserManager sharedUserManager].userInfo.mobile;
    if(phone.length>=7){
        phone=[phone stringByReplacingCharactersInRange:NSMakeRange(3, phone.length-7) withString:@"****"];
    }
    forgetPwdView.phoneNumField.text=phone;
    forgetPwdView.phoneNumField.userInteractionEnabled=NO;
    
}
#pragma mark-数据区
-(void)getVerCode{
    NSString *url= [NSString stringWithFormat:@"%@%@",BASE_URL,api_sms_sendCode];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[UserManager sharedUserManager].userInfo.mobile forKey:@"mobile"];
    [dic setObject:@"change-password" forKey:@"type"];
    KDNetHttpReqCenter *req=[[KDNetHttpReqCenter alloc] init];
    [req sendHttpReq:self sendDic:dic URL:url responseDWay:1 api:api_sms_sendCode nsl:NO stl:NO];
}

- (void)submitLoginData {
    [self showLoading:nil];
    NSString *url= [NSString stringWithFormat:@"%@%@?token=%@",BASE_URL,api_user_changePassword,[UserManager sharedUserManager].loginInfo.token];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.forgetPwdView.passWordField.text forKey:@"password"];
    [dic setObject:self.forgetPwdView.verCodeField.text forKey:@"code"];
    KDNetHttpReqCenter *req=[[KDNetHttpReqCenter alloc] init];
    [req sendHttpReq:self sendDic:dic URL:url responseDWay:1 api:api_user_changePassword nsl:NO stl:NO];
    
}

#pragma mark- 本类代理回调

#pragma mark-登录按钮点击
-(void)didRegButtonClick:(UIButton *)button{
   
    if (kStringIsEmpty(self.forgetPwdView.verCodeField.text)) {
        [self showMessage:ALS(@"请输入验证码")];
        return;
    }
    if (kStringIsEmpty(self.forgetPwdView.passWordField.text)) {
        [self showMessage:ALS(@"请输入密码")];
        return;
    }
    if (![self.forgetPwdView.passWordField.text wh_isPasswordNumber]) {
        [self showMessage:ALS(@"请输入8-16位由字母和数字组成的密码")];
        return;
    }
    
    [self submitLoginData];
    
}
//  获取验证码
- (void)getCodeBtnClick:(UIButton *)btn{
    
    [self getVerCode];
}
-(void)verCodeSendSuccess{
    [self.forgetPwdView.sendCodeBtn startWithSecond:60];
    [self.forgetPwdView.sendCodeBtn didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"%ds",second];
        countDownButton.enabled = NO;
        return title;
    }];
    [self.forgetPwdView.sendCodeBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return ALS(@"重新获取");
    }];
}
// 显示密码
- (void)lookPaw:(UIButton *)btn {
    
    if (self.forgetPwdView.passWordField.secureTextEntry == YES) {
        self.forgetPwdView.passWordField.secureTextEntry = NO;
        [btn setBackgroundImage:IMAGENAMED(@"AccordingPwdOpen") forState:UIControlStateNormal];
    }else if(self.forgetPwdView.passWordField.secureTextEntry == NO) {
        self.forgetPwdView.passWordField.secureTextEntry = YES;
        [btn setBackgroundImage:IMAGENAMED(@"eyesDisabled") forState:UIControlStateNormal];
    }
}



#pragma mark-数据回调
- (void)OnHttpErrorBack:(NSMutableDictionary *)api response:(NSURLResponse *)rep{
    [self hideLoading];
    [self showMessage:ALS(@"网络异常")];
}

- (void)OnHttpDataBack:(NSString*)api responseDWay:(int)dw data:(NSData*)data userInfo:(id)userInfo response:(NSURLResponse *)rep{
    if([api isEqualToString:api_sms_sendCode]){
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        [self hideLoading];
        
        if(jsonDict){
            self.errModel = [ErrorModel getDataWithDict:data];
            if (self.errModel.code==SuccessCode) {
                [self showMessage:self.errModel.msg];
                [self verCodeSendSuccess];
            }else{
                [self showMessage:self.errModel.msg];
            }
        }
    }
   
    if([api isEqualToString:api_user_changePassword]){
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [self hideLoading];
        if(jsonDict){
            self.errModel = [ErrorModel getDataWithDict:data];
            if (self.errModel.code==SuccessCode) {
                [self showMessage:self.errModel.msg];
                [self performBlock:^{
                    [[UserManager sharedUserManager] logout];
                    [self jumpToLogin];
                } afterDelay:2];
            }else{
                [self showMessage:self.errModel.msg];
            }
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == self.forgetPwdView.passWordField) {
        if (!kStringIsEmpty(toBeString)) {
            [self.forgetPwdView.regButton  setHighlighted:YES];
            
        }else {
            [self.forgetPwdView.regButton setHighlighted:NO];
            
        }
    }
    return YES;
}


@end
