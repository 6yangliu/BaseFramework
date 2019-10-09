//
//  CommonWebController.h
//  APPiOS
//   CommonWebController
//  Created by liuy on 2019/1/4.
//  Copyright © 2019 shengxi. All rights reserved.
//


#import "BaseWebViewController.h"

@interface CommonWebController : BaseWebViewController
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic,copy) NSString * activityUrl;
@property (nonatomic,copy) NSString * navigationName;

@end
