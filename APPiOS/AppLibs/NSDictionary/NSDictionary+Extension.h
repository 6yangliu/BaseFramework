//
//  NSDictionary+Extension.h
//  facetalk
//
//  Created by yang on 16/6/3.
//  Copyright © 2016年 dyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)


/**
 字符串转成字典

 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
