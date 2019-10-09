//
//  LoginViewController.m
//  APPiOS
//
//  Created by liuy on 2018/6/20.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "RegisterViewController.h"
#import "TYAttributedLabel.h"
#import "CommonWebController.h"

#import "RegisterView.h"
#import "DSUtils.h"
#import "YBBKeychain.h"


@interface RegisterViewController ()<UITextFieldDelegate,TYAttributedLabelDelegate>
{
    NSString *ctoken;
    
}
@property (nonatomic, strong) RegisterView *registerView;
@property (nonatomic, strong) ErrorModel *errModel;


@end

@implementation RegisterViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=ALS(@"注册");
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
    [self baseSetup:PageGobackTypeDismiss];
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
    
    RegisterView *registerView = [[RegisterView alloc] initWithFrame:CGRectMake(KScreenPrt(16), KScreenPrt(45), self.view.width-KScreenPrt(16)*2, 0)];
    self.registerView = registerView;
    
    [registerView.regButton setBackgroundColor:UIColorFromRGB(0x3092fc) forState:UIControlStateNormal];
    [registerView.regButton setBackgroundColor:UIColorFromRGB(0x3092fc) forState:UIControlStateHighlighted];
    
    registerView.phoneNumField.delegate = self;
    registerView.passWordField.delegate = self;
    [registerView.sendCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [registerView.lookPawButton addTarget:self action:@selector(lookPaw:) forControlEvents:UIControlEventTouchUpInside];
    [registerView.regButton addTarget:self action:@selector(didRegButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerView];
   
    //  协议label
    TYAttributedLabel *protocalLabel = [[TYAttributedLabel alloc]init];
    protocalLabel.characterSpacing = 0;
    protocalLabel.delegate = self;
    protocalLabel.textAlignment=2;
    //    protocalLabel.lineBreakMode = UILineBreakModeWordWrap;
    protocalLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:protocalLabel];
    //    注册即表示同意《服务协议》《隐私条款》《法律声明》
    NSString *text = [NSString stringWithFormat:@"*%@*****",ALS(@"注册即表示同意")];
    NSArray *textArray = [text componentsSeparatedByString:@"*"];
    NSInteger index = 0;
    protocalLabel.numberOfLines = 0;
    for (NSString *text in textArray) {
        if (index == 2) {
            // 追加链接信息
            [protocalLabel appendLinkWithText:[NSString stringWithFormat:@"《%@》",ALS(@"保密及商业行为守则协议")] linkFont:[UIFont systemFontOfSize:14] linkColor:UIColorFromRGB(0x3092fc) underLineStyle:kCTUnderlineStyleNone linkData:ALS(@"服务协议")];
        }
        else
        {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedString addAttributeTextColor:DEEP_Text_Color];
            [attributedString addAttributeFont:[UIFont systemFontOfSize:KScreenPrt(14)]];
            [protocalLabel appendTextAttributedString:attributedString];
        }
        index++;
    }
    protocalLabel.width=self.registerView.width;
    protocalLabel.height=KScreenPrt(20);
    protocalLabel.top=self.registerView.bottom+KScreenPrt(10);
    protocalLabel.left=self.registerView.left;
    [protocalLabel sizeToFit];
}
#pragma mark-数据区
-(void)getVerCode{
    NSString *url= [NSString stringWithFormat:@"%@%@",BASE_URL,api_sms_sendCode];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.registerView.phoneNumField.text forKey:@"mobile"];
    [dic setObject:@"register" forKey:@"type"];
    KDNetHttpReqCenter *req=[[KDNetHttpReqCenter alloc] init];
    [req sendHttpReq:self sendDic:dic URL:url responseDWay:1 api:api_sms_sendCode nsl:NO stl:NO];
}
-(void)checkVerCode{
    
    [self showLoading:@""];
    
    NSString *url= [NSString stringWithFormat:@"%@%@",BASE_URL,api_sms_checkCode];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.registerView.phoneNumField.text forKey:@"mobile"];
    [dic setObject:self.registerView.verCodeField.text forKey:@"code"];
    [dic setObject:@"register" forKey:@"type"];
    KDNetHttpReqCenter *req=[[KDNetHttpReqCenter alloc] init];
    [req sendHttpReq:self sendDic:dic URL:url responseDWay:1 api:api_sms_checkCode nsl:NO stl:NO];
    
}
- (void)submitLoginData {
    NSString *url= [NSString stringWithFormat:@"%@%@",BASE_URL,api_user_register];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setObject:self.registerView.phoneNumField.text forKey:@"mobile"];
    [dic setObject:self.registerView.passWordField.text forKey:@"password"];
    [dic setObject:ctoken forKey:@"ctoken"];
    KDNetHttpReqCenter *req=[[KDNetHttpReqCenter alloc] init];
    [req sendHttpReq:self sendDic:dic URL:url responseDWay:1 api:api_user_register nsl:NO stl:NO];
    
}

#pragma mark- 本类代理回调

#pragma mark-登录按钮点击
-(void)didRegButtonClick:(UIButton *)button{
    
    if (kStringIsEmpty(self.registerView.phoneNumField.text)) {
        [self showMessage:ALS(@"请输入手机号")];
        return;
    }
    if (kStringIsEmpty(self.registerView.verCodeField.text)) {
        [self showMessage:ALS(@"请输入验证码")];
        return;
    }
    if (kStringIsEmpty(self.registerView.passWordField.text)) {
        [self showMessage:ALS(@"请输入密码")];
        return;
    }
    if (![self.registerView.passWordField.text wh_isPasswordNumber]) {
        [self showMessage:ALS(@"请输入8-16位由字母和数字组成的密码")];
        return;
    }
    
    [self checkVerCode];
}
//  获取验证码
- (void)getCodeBtnClick:(UIButton *)btn{
    
    [self.registerView.phoneNumField resignFirstResponder];
    if (self.registerView.phoneNumField.text.length == 0)
    {
        [self showMessage:ALS(@"请输入手机号")];
        return;
    }
   
    [self getVerCode];
    
}
-(void)verCodeSendSuccess{
    [self.registerView.sendCodeBtn startWithSecond:60];
    [self.registerView.sendCodeBtn didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"%ds",second];
        countDownButton.enabled = NO;
        return title;
    }];
    [self.registerView.sendCodeBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return ALS(@"重新获取");
    }];
}
// 显示密码
- (void)lookPaw:(UIButton *)btn {
    
    if (self.registerView.passWordField.secureTextEntry == YES) {
        self.registerView.passWordField.secureTextEntry = NO;
        [btn setBackgroundImage:IMAGENAMED(@"AccordingPwdOpen") forState:UIControlStateNormal];
    }else if(self.registerView.passWordField.secureTextEntry == NO) {
        self.registerView.passWordField.secureTextEntry = YES;
        [btn setBackgroundImage:IMAGENAMED(@"eyesDisabled") forState:UIControlStateNormal];
    }
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point
{
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        CommonWebController *webCtrl=[[CommonWebController alloc] init];
        webCtrl.title=ALS(@"注册协议");
        webCtrl.activityUrl=[NSString stringWithFormat:@"%@%@?type=user_register",BASE_URL,api_spa_page];
        [self.navigationController pushViewController:webCtrl animated:YES];
    }
}

- (void)successRegist{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
                [self verCodeSendSuccess];
            }else{
                [self showMessage:self.errModel.msg];
            }
        }
    }
    
    if([api isEqualToString:api_sms_checkCode]){
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [self hideLoading];
        
        if(jsonDict){
            self.errModel = [ErrorModel getDataWithDict:data];
            if (self.errModel.code==SuccessCode) {
               
                ctoken=jsonDict[@"data"][@"ctoken"];
                [self submitLoginData];
            }else{
               
                [self showMessage:self.errModel.msg];
            }
        }
    }
    
    if([api isEqualToString:api_user_register]){
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [self hideLoading];
        if(jsonDict){
            self.errModel = [ErrorModel getDataWithDict:data];
            if (self.errModel.code==SuccessCode) {
                [self successRegist];
            }else{
                [self showMessage:self.errModel.msg];
            }
        }
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == self.registerView.passWordField) {
        if (!kStringIsEmpty(toBeString)) {
            [self.registerView.regButton  setHighlighted:YES];
            
        }else {
            [self.registerView.regButton setHighlighted:NO];
            
        }
    }
    return YES;
}


@end
