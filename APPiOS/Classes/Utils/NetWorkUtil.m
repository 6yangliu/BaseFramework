//
//  NetWorkUtil.m
//  AJJ-Measure
//
//  Created by myhome3d on 16/9/19.
//
//

#import "NetWorkUtil.h"



@implementation NetWorkUtil

+(instancetype)shareNetWorkUtil
{
    static NetWorkUtil *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        NSURL *baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", BASE_URL]];
        
        manager = [[NetWorkUtil alloc] initWithBaseURL:baseUrl];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"application/json;charset=UTF-8",nil];
        // 设置发送的数据格式为 json
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置30秒超时 - 取消请求
        manager.requestSerializer.timeoutInterval = REQUESTTIMEOUT;
    });
    return manager;

}

@end
