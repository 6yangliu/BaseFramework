//
//  SXRequestApi.h
//  APPiOS
//
//  Created by liuy on 2018/4/24.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#ifndef SXRequestApi_h
#define SXRequestApi_h

#ifdef __DEV__
    #define  BASE_URL @"https://front.bptcoin.com/" //api
#elif defined __QA__
    #define  BASE_URL   @"https://front.bptcoin.com/" //QA、https://front.bptcoin.com/
#elif defined __PROD__
    #define  BASE_URL @"https://front.bptcoin.com/" //生产
#else//默认生产环境
    #define  BASE_URL @"https://front.bptcoin.com/" //生产 https://front.bptcoin.com/
#endif


#define KClient_id @"ios"


#define ServiceImage(url)  [url containsString:@"http://"]||[url containsString:@"https://"] ? url:[NSString stringWithFormat:@"%@%@",BASE_URL,url]


#define api_sms_sendCode @"api/v1/sms/send-code"
#define api_sms_checkCode @"api/v1/sms/check-code"
#define api_user_login @"api/v1/user/login"
#define api_user_register @"api/v1/user/register"
#define api_user_forgotPassword @"api/v1/user/forgot-password"
#define api_user_changePassword @"api/v1/user/change-password"
#define api_user_logout @"api/v1/user/logout"
#define api_user_userinfo @"api/v1/user/info"
#define api_spa_page @"api/v1/spa/page"

#endif /* SXRequestApi_h */
