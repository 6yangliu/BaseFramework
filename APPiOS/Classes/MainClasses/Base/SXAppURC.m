//
//  SXAppURC.h
//  APPiOS
//  App应用HTTP数据解析中心
//  Created by liuy on 2018/5/18.
//  Copyright © 2018年 shengxi. All rights reserved.
//


#import "SXAppURC.h"


@implementation SXAppURC

+(SXAppURC *)instance{
    
    static SXAppURC *backPower;
    if(!backPower){
        backPower=[[SXAppURC alloc] init];
        
    }
    return backPower;
}


-(BOOL)Parser:(NSString*)api delt:(id)delt data:(NSData*)data userinfo:(id)info{
   
    ErrorModel *errModel = [ErrorModel getDataWithDict:data];

    if(errModel.code==900102||errModel.code==900104){//拦截登录失效
//        BaseViewController *ctrl=(BaseViewController *)delt;
//        SXLoginViewController *vcLogin=[delt loginInvalidActivityWithController:delt param:nil];
//        vcLogin.loginBackBlock = ^(id *obj) {
//            [ctrl pushToHomeCtrl];
//        };
        return YES;
    }
    
    
    
    
    return YES;
}

@end

