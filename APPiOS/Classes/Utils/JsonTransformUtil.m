//
//  JsonTransformUtil.m
//  iFuWoBuildiPhone
//
//  Created by 凌海龙 on 2016/12/13.
//  Copyright © 2016年 com.fuwo. All rights reserved.
//

#import "JsonTransformUtil.h"

@implementation JsonTransformUtil

+ (NSString *)jsonStr:(id)jsonObj
{
    //isValidJSONObject 判断是否能转成json对象
    if (jsonObj&&[NSJSONSerialization isValidJSONObject:jsonObj]) {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObj options:NSJSONWritingPrettyPrinted error:&error];
        if (!error&&data) {
            return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

+ (id)jsonObj:(NSString *)jsonStr
{
    if (jsonStr&&jsonStr.length) {
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        if (!error&&obj) {
            return obj;
        }
    }
    return nil;
}

+ (NSDictionary *)withJson:(id)json{
    if (json) {
        return [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:json options:0 error:nil]];
    }
    return nil;
}

@end
