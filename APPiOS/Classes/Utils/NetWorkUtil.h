//
//  NetWorkUtil.h
//  AJJ-Measure
//
//  Created by myhome3d on 16/9/19.
//
//

#import "AFHTTPSessionManager.h"

#define REQUESTTIMEOUT 30.0f

@interface NetWorkUtil : AFHTTPSessionManager

+ (instancetype) shareNetWorkUtil;


@end
