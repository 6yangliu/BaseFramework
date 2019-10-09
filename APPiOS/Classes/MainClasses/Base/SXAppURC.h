//
//  SXAppURC.h
//  APPiOS
//  App后台数据中心
//  Created by liuy on 2018/5/18.
//  Copyright © 2018年 shengxi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ErrorModel.h"

@interface SXAppURC:NSObject
{
    
}

+(SXAppURC *)instance;


-(BOOL)Parser:(NSString*)api delt:(id)delt data:(NSData*)data userinfo:(id)info ;


@end


