//
//  JsonTransformUtil.h
//  iFuWoBuildiPhone
//
//  Created by 凌海龙 on 2016/12/13.
//  Copyright © 2016年 com.fuwo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonTransformUtil : NSObject

+ (NSString *)jsonStr:(id)jsonObj;

+ (id)jsonObj:(NSString *)jsonStr;

+ (NSDictionary *)withJson:(id)json;

@end
