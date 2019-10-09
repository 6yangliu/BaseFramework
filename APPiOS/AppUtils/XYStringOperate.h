//
//  StringOperate.h
//  CLFZS
//  字符串操作类
//  Created by jysd on 14/12/17.
//  Copyright (c) 2014年 jysd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CTStringAttributes.h>
#import <CoreText/CoreText.h>
#import "sys/utsname.h"

#define ScreenWidthPrt  [[UIScreen mainScreen]bounds].size.width/375 //各设备宽的比例 以375为参照
#define ScreenPrt(P) ScreenWidthPrt*P


@interface XYStringOperate : NSObject

+ (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label;//根据label返回 每一行的text

+ (NSString *)htmlToText:(NSString *)htmlString;//转义字符格式化

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
//自适应label 的高度
+ (CGSize)getLabelSizeWithText:(NSString *)text Size:(CGSize)size font:(UIFont *)font;
//自适应label 的高度 带行间距字间距
+ (CGSize)getLabelSizeWithText:(NSString *)text Size:(CGSize)size font:(UIFont *)font paraStyle:(NSMutableParagraphStyle*)paraStyle KernSize:(CGFloat)kernSize;

//获取字符串（不折行）宽度
+ (CGSize)getLabelWidthWithText:(NSString *)text Size:(CGSize)size font:(UIFont *)font;

+(NSString *) md5:(NSString *)str;

//获得指定长度的不唯一字符串
+(NSString *)GetRandomString:(NSString *)str lenght:(int)len;

//根据屏幕宽高比获取字体大小(适配屏幕)
+(CGFloat)GetFontSizeByScreenWithPrt:(CGFloat)FontSize;

//人民币转大写
+(NSString *)RMBChangetoCapital:(NSString *)numstr;
//金额 千分位
+ (NSString *)moneyFormat:(NSString *)money;
//金额 去千分位
+ (NSString *)deletMoneyFormat:(NSString *)money;
//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString;


//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString;

+(NSMutableAttributedString *)plainStringToAttributedUnits:(NSString *)string :(UIFont *)font1 :(UIFont *)font2 :(NSRange)smallRange;

+ (NSString*)getDeviceName;
+(NSString *)unitStringFromString:(NSString *)numberStr;

@end
