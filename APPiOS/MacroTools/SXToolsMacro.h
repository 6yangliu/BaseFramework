//
//  SXToolsMacro.h
//  APPiOS
//
//  Created by 丁洋洋 on 2018/4/24.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#ifndef SXToolsMacro_h
#define SXToolsMacro_h

/**
 *  预处理工具
 */

//** DEBUG LOG *********************************************************************************
#ifdef DEBUG
#define NSLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NSLog( s, ... )
#endif


//iphone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)

#define IS_IPHONE_X MAX(kScreen_width,kScreen_height)==812.0f||MAX(kScreen_width,kScreen_height)==896.0f


#define KHeight_NavContentBar 44.0f

#define KHeight_StatusBar ((IS_IPHONE_X==YES)?44.0f: 20.0f)

#define KHeight_NavBar ((IS_IPHONE_X==YES)?88.0f: 64.0f)

#define KHeight_TabBar ((IS_IPHONE_X==YES)?83.0f: 49.0f)

#define CELL_SLT_BG_ALPHA 0.4

#define SXpi 3.14159265359

//屏幕适配比例
#ifndef KScreenWidthPrt
#define KScreenWidthPrt  MIN([[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height)/375 //各设备宽的比例 以375为参照
#define KScreenPrt(P) KScreenWidthPrt*P
#endif

#define KEYWINDOW       ([UIApplication sharedApplication].keyWindow)
///度数
#define DEGREES_TO_RADIANS(degress) ((pi * degress)/180)

//宏定义检测block是否可用
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

#define DB_UserConfig              @"UserConfig.archive"
#define DB_AppConfig               @"AppConfig.archive"

#import "AppDelegate.h"

#define SXAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define theAppPower [SXBackPower instance]

#define WEAK  @weakify(self);

#define STRONG  @strongify(self);

#define kWeakSelf(type)__weak typeof(type)weak##type = type;

#define kStrongSelf(type)__strong typeof(type)type = weak##type;

#define WEAKSELF __weak typeof(self) weakSelf = self
#define SsSELF __strong typeof(self)  ssSelf = self
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

#define SXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define BlackTextColor SXColor(40,40,40,1)
///字体定义
#define numberFont @"Arial"
#define numberBoldFont @"Arial-BoldMT"
#define SXFont(font) [UIFont systemFontOfSize:(font)]

#define SXBFont(font) [UIFont boldSystemFontOfSize:(font)]

//屏幕宽高
#define kScreen_width ([[UIScreen mainScreen] bounds].size.width)

#define kScreen_height ([[UIScreen mainScreen] bounds].size.height)


#define UserDefaults    [NSUserDefaults standardUserDefaults]
// 在宏的参数前加上一个#，宏的参数会自动转换成c语言的字符串
#define MRKeyPath(objc,keyPath) @(((void)objc.keyPath, #keyPath))

//** 加载xib ***********************************************************************************
#define SX_LoadNib(x) [[NSBundle mainBundle] loadNibNamed:@(x) owner:nil options:nil][0]

#define SX_Nib(x) [UINib nibWithNibName:x bundle:nil]


// 本地化字符串
///** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
//#define LocalString(x, ...)     NSLocalizedString(x, nil)
///** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
//#define ALS(x, ...)  NSLocalizedStringFromTable(x, @"SXLocalizable", nil)



//**语言本地化***********************************************************************************
//策略:判断用户是否设置语言
//1.设置 >加载语言包 （加载语言包失败加载默认语言包）
//2.未设置>根据手机系统语言加载语言包（加载语言包失败加载默认语言包）
#define SXUserLanguage @"SXUserLanguage"
#define SXUserLanguageBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSUserDefaults standardUserDefaults] valueForKey:SXUserLanguage] ofType:@"lproj"]]

#define LocalString(x, ...) [[NSUserDefaults standardUserDefaults] valueForKey:SXUserLanguage] ==nil ? NSLocalizedString(x, nil) :[SXUserLanguageBundle localizedStringForKey:(a) value:@"" table:@"SXLocalizable"]

#define ALS(x, ...)  [[NSUserDefaults standardUserDefaults] valueForKey:SXUserLanguage] ==nil ? NSLocalizedStringFromTable(x, @"SXLocalizable", nil) : [SXUserLanguageBundle localizedStringForKey:(x) value:@"" table:@"SXLocalizable"]
//**********************************************************************************************


//获取字典的key对应的String value
#define DSStringValue(x) x == nil?@"":x 
//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO || [str isEqualToString:@"<null>"])
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define kCurrentLanguage  [[NSUserDefaults standardUserDefaults] valueForKey:SXUserLanguage] !=nil ? [[NSUserDefaults standardUserDefaults] valueForKey:SXUserLanguage] :([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#define SIMULATOR 1
#endif

#if TARGET_IPHONE_SIMULATOR

//模拟器
#endif


//颜色
#define viewlineColor [UIColor colorWithRed:222.0/255.0 green:223.0/255.0 blue:224.0/255.0 alpha:1]//线条颜色
#define commonWhite [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]//通用的白色
#define commonBlack [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]//通用的黑色
#define Color_backgroundColor [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0f]//页面背景颜色


// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define HKUIColorFromRGB(rgbValue,p)  [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:(p)]
// 随机色
#define kRandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define kColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

//返回码
#define requestSuccessCode @"2000"

#endif /* SDToolsMacro_h */
