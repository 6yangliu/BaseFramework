//
//  CommonWebController.m
//  APPiOS
//
//  Created by liuy on 2018/6/29.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "CommonWebController.h"
@interface CommonWebController ()<UIWebViewDelegate>

@end

@implementation CommonWebController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf=self;
    self.leftActionBlock = ^{
        if (weakSelf.webView.canGoBack==YES) {
            [weakSelf.webView goBack];
            return;
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self initView];
    [self baseSetup:2];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)initView {
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, self.view.width,self.view.height-KHeight_NavBar)];
    _webView.opaque=NO;
    _webView.scalesPageToFit = YES;
    _webView.delegate=self;
    _webView.backgroundColor=UIColorFromRGB(0xF6F5FC);
    [self.view addSubview:_webView];
   
    
    NSString* ranURL;
    ranURL = [NSString stringWithFormat:@"%@",_activityUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ranURL]];
    
    [self.webView loadRequest:request];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self startLoading];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self stopLoading];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self stopLoading];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if(!self.title.length){
        self.title=title;
    }
}

@end
