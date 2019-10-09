//
//  CacheManager.h
//  GangQinEJia
//  缓存管理
//  Created by ly on 15/12/9.
//  Copyright © 2015年 kedll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

//遍历文件夹获得文件夹大小，返回多少M
+ (float )folderSizeAtPath:(NSString*) folderPath;
//单个文件的大小
+ (long long)fileSizeAtPath:(NSString*) filePath;
//删除文件缓存
+(void)clearCache:(NSString *)path;


@end
