//
//  ToolArc.m
//  
//
//  Created by muxi on 14-9-3.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import "CoreArchive.h"

@implementation CoreArchive

#pragma mark - 偏好类信息存储
//保存普通对象
+(void)setStr:(NSString *)str key:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setObject:str forKey:key];
    
    //立即同步
    [defaults synchronize];

}

//读取
+(NSString *)strForKey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSString *str=(NSString *)[defaults objectForKey:key];
    
    return str;

}

//删除
+(void)removeStrForKey:(NSString *)key{
    
    [self setStr:nil key:key];
}



//保存int
+(void)setInt:(NSInteger)i key:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setInteger:i forKey:key];
    
    //立即同步
    [defaults synchronize];

}

//读取
+(NSInteger)intForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSInteger i=[defaults integerForKey:key];
    
    return i;
}


/**
 *  删除int
 */
+(void)removeIntForKey:(NSString *)key{
    [self setInt:0 key:key];
}




//保存float
+(void)setFloat:(CGFloat)floatValue key:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setFloat:floatValue forKey:key];
    
    //立即同步
    [defaults synchronize];

}
//读取
+(CGFloat)floatForKey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    CGFloat floatValue=[defaults floatForKey:key];
    
    return floatValue;
}


/**
 *  删除float
 */
+(void)removeFloatForKey:(NSString *)key{
    [self setFloat:0 key:key];
}



/**
 *  保存double
 */
+(void)setDouble:(double)doubleValue key:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setDouble:doubleValue forKey:key];
    
    //立即同步
    [defaults synchronize];
}


/**
 *  读取double
 */
+(double)doubleForKey:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    double doubleValue=[defaults doubleForKey:key];
    
    return doubleValue;
}


/**
 *  删除
 */
+(void)removeDoubleForKey:(NSString *)key{
    [self setDouble:0 key:key];
}


//保存bool
+(void)setBool:(BOOL)boolValue key:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setBool:boolValue forKey:key];
    
    //立即同步
    [defaults synchronize];

}
//读取
+(BOOL)boolForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    BOOL boolValue=[defaults boolForKey:key];
    
    return boolValue;
}


/**
 *  删除
 */
+(void)removeBoolForKey:(NSString *)key{
    [self setBool:NO key:key];
}


#pragma mark - 文件归档
//归档
+(BOOL)archiveRootObject:(id)obj toFile:(NSString *)path{
   return [NSKeyedArchiver archiveRootObject:obj toFile:path];
}
//删除
+(BOOL)removeRootObjectWithFile:(NSString *)path{
    return [self archiveRootObject:nil toFile:path];
}
//解档
+(id)unarchiveObjectWithFile:(NSString *)path{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}






@end
