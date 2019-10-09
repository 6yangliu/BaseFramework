//
//  ErrorModel.h
//  APPiOS
//  Created by 天 on 2017/7/7.
//  Copyright © 2017年 tianyingxinxi. All rights reserved.
//

#import "JSONModel.h"

#define SuccessCode 2000

@interface ErrorModel : JSONModel

@property (nonatomic,assign) NSInteger code;

@property (nonatomic,copy) NSString *msg;

+(instancetype)getDataWithDict:(NSData *)data;

@end



