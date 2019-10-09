//
//  FileManager.h
//
//  文件操作工具类
//  Created by kedll on 2015年11月18日.
//  Copyright (c) 2014年 ly. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface FileManager : NSObject

//将字典写入到沙盒下
+(BOOL)SaveLocData:(NSString*)file dic:(NSMutableDictionary *)dic;

//读取文件
+(NSMutableDictionary *)LoadLocData:(NSString*)file;

//GetRuntimeFilePath-获取运行时文件路径
+(NSString *) GetRuntimeFP:(NSString *)file;

@end
