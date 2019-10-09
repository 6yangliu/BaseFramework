//
//  FileManager.h
//
//  文件操作工具类
//  Created by kedll on 2015年11月18日.
//  Copyright (c) 2014年 ly. All rights reserved.
//


#import "FileManager.h"
@implementation FileManager

//写入文件到沙盒
+(BOOL)SaveLocData:(NSString *)file dic:(NSMutableDictionary *)dic{
    NSString * filepath = [self GetRuntimeFP:file];
     BOOL success=[NSKeyedArchiver archiveRootObject:dic toFile:filepath];
    if(success){
      NSLog(@"SaveLocData:文件写入成功");
    }else{
        NSLog(@"SaveLocData:文件写入失败");
    }
    return success;
}

//获取沙盒下文件
+(NSMutableDictionary *)LoadLocData:(NSString*)file{
    NSMutableDictionary *dic;
    NSString * filepath = [self GetRuntimeFP:file];
    dic= [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:filepath]];
    if (dic==nil) dic=[[NSMutableDictionary alloc] init] ;
    return dic;
}
//GetRuntimeFilePath-获取运行时文件路径
+(NSString *)GetRuntimeFP:(NSString *)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//Documents目录
    NSMutableString * filepath = [NSMutableString stringWithCapacity:10];
    [filepath appendString:documentsDirectory];
    [filepath appendString:@"/"];
    [filepath appendString:file];
    return filepath;
}

@end
