//
//  SXBackPower.m
//  APPiOS
//
//  Created by liuy on 2018/5/18.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import "SXBackPower.h"

@implementation SXBackPower
{

    
}
+(SXBackPower *)instance{
    static SXBackPower *backPower;
    if(!backPower){
        backPower=[[SXBackPower alloc] init];
    }
    return backPower;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getUserInfo];
    }
    return self;
}

#pragma mark-数据区

//获取个人信息
- (void)getUserInfo{
    
    NSString *url= [NSString stringWithFormat:@"%@%@?token=%@",BASE_URL,api_user_userinfo,[UserManager sharedUserManager].loginInfo.token];
    KDNetHttpReqCenter *req=[[KDNetHttpReqCenter alloc] init];
    [req sendHttpReq:self sendDic:nil URL:url responseDWay:1 api:api_user_userinfo nsl:NO stl:NO];
    
}
#pragma mark-网络回调
-(void)OnHttpErrorBack:(NSMutableDictionary*)api response:(NSURLResponse*)rep{
    
}

- (void)OnHttpDataBack:(NSString *)api responseDWay:(int)dw data:(NSData *)data userInfo:(id)userInfo response:(NSURLResponse *)rep{
    //用户信息
    if([api isEqualToString:api_user_userinfo]){
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if(jsonDict){
            ErrorModel *errModel = [ErrorModel getDataWithDict:data];
            if (errModel.code==SuccessCode) {
                if(jsonDict[@"data"]){
                    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:jsonDict[@"data"]];
                    [[UserManager sharedUserManager] updateUserInfo:[UserModel mj_objectWithKeyValues:dic]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(self.updateUserInfoBlock){
                            self.updateUserInfoBlock([UserManager sharedUserManager].userInfo);
                        }
                    });
                }
            }
        }
    }
    
    //
    
    
}

//查找当前ViewController
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (void)dealloc
{
    
}
@end
