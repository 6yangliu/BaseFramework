//
//  SXWalletController.h
//  APPiOS
//
//  Created by liuy on 2018/5/18.
//  Copyright © 2018年 shengxi. All rights reserved.
//
#if !__has_feature(objc_arc)
#error This module must be compiled USE ARC, -fobjc-arc
#endif

#import "SXColorScheme.h"

@implementation SXColorScheme
{
    NSMutableDictionary * m_colorDict;
	NSString * currentScheme;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        m_colorDict = [NSMutableDictionary dictionaryWithCapacity:32];
		currentScheme = COLOR_SCHEME_WHITE;
    }
    
    return self;
}

// 唯一实例
+ (SXColorScheme *) Instance
{
    static SXColorScheme* s_Instance = nil;
    @synchronized(self)
    {
        if (!s_Instance)
        {
            s_Instance = [[self alloc] init];
        }
    }
    return s_Instance;
}

// 加载配色方案
- (BOOL) loadScheme:(NSString *)scheme
{
    NSString * plistPath = [NSString stringWithFormat:@"%@/ColorScheme%@.plist", [[NSBundle mainBundle] resourcePath], scheme];
    NSDictionary * root = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSDictionary * global = [root objectForKey:@"Global"];
    
    [m_colorDict removeAllObjects];
    
    for (NSString *key in [global allKeys])
    {
        NSString *val = [global objectForKey:key];
        
        UIColor *color = [SXColorScheme colorWithHexString:val];
        
        NSAssert(val && color, @"error");
        [m_colorDict setObject:color forKey:[key uppercaseString]];
    }
    
    
    NSLog(@"加载%@本色方案成功， 颜色项：%d个。", scheme, (int)[m_colorDict count] );
	currentScheme = scheme;
	
	return YES;
}

// 取得颜色值
- (UIColor *) getColor : (NSString *)key
{
    UIColor *color = [m_colorDict objectForKey:[key uppercaseString]];
    if (color)
        return color;
    else
    {
        NSAssert(NO, @"调用getColor时传递了不存在的颜色代码:<%@>", key);
        return [UIColor whiteColor];
    }
}

+ (UIColor *) getColor : (NSString *)key
{
    return [[self Instance] getColor:key];
}

+ (BOOL) isBlack
{
	return [[self Instance]->currentScheme isEqualToString:COLOR_SCHEME_BLACK];
}

#define DEFAULT_VOID_COLOR [UIColor whiteColor]
//字符串转颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
    {
        NSAssert(NO, @"check plist 颜色值定义有误<%@>", stringToConvert);
        return DEFAULT_VOID_COLOR;
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6 && [cString length] != 8)
    {
        NSAssert(NO, @"check plist 颜色值定义有误<%@>", stringToConvert);
        return DEFAULT_VOID_COLOR;
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int alpha = 255;
    if (cString.length == 8)
    {
        range.location = 6;
        NSString *alphaString = [cString substringWithRange:range];
        [[NSScanner scannerWithString:alphaString] scanHexInt:&alpha];
    }
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) alpha / 255.0f)];
}

+ (NSString *)getImageName : (NSString *) name
{
	return [NSString stringWithFormat:@"%@%@", name, [self isBlack] ? @"-Black" : @""];
}
@end
