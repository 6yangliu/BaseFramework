//
//  ErrorModel.m
//  APPiOS
//  Created by 天 on 2017/7/7.
//  Copyright © 2017年 tianyingxinxi. All rights reserved.
//

#import "ErrorModel.h"

@implementation ErrorModel

+ (instancetype)getDataWithDict:(NSData *)data{
    ErrorModel *model = [ErrorModel mj_objectWithKeyValues:data];
    return model;
}

@end


