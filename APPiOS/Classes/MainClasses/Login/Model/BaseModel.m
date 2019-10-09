//
//  BaseModel.m
//  APPiOS
//
//  Created by liuy on 2019/1/21.
//  Copyright © 2019 shengxi. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

MJCodingImplementation


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"Id":@"id",
             @"descrip":@"description",
             @"values":@"value",
             @"Operator":@"operator",
             };
}


@end
