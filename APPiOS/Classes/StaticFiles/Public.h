//
//  Public.h
//  MaiYafq
//
//  Created by NeverMore on 16/6/13.
//  Copyright © 2016年 NeverMore. All rights reserved.
//

#ifndef Public_h
#define Public_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define REQUESTSUCCESS @"Success"

#define RMB  @"CNY"

#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define kMainScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KStatusBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define KNavBarHeight  (self.navigationController.navigationBar.frame.size.height)
#define kNAVStatusBarHeight (KStatusBarHeight + KNavBarHeight)
#define kTabBarHeight (self.tabBarController.tabBar.frame.size.height)

#define kMainScreen [UIScreen mainScreen].bounds
#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)
#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

#define uanguangAppStoreUrl @"https://itunes.apple.com/us/app/uanguang-pinjaman-uang-online/id1339549674?l=zh&ls=1&mt=8"
#define UmSocialAppKey @"5a4de241f29d92" //  友盟
#define FaceBookAppKey @"1135363236600238" //  faceBook

#define JPushAppkey @"d98908a5f79ac71da12b8ba7" //JPush 推送
#define UmengAppkey @"5c6a222eb465f5484d000030" //umeng appkey


#import "AppDelegate.h"
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/** 底部tab高度 */
#define kBottomTabHeight  44
/** 顶部Nav高度+指示器 */
#define kTopNavHeight  64

#define kOther [[NSUserDefaults standardUserDefaults] objectForKey:@"OTHER"]

#define Scale [UIScreen mainScreen].bounds.size.width/375

#define FitCount(count) count*[UIScreen mainScreen].bounds.size.width/375.0

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//分割线颜色
#define CutLine_Color     RGBA(233, 239, 233, 1)
// view背景色
#define Base_View_Color   RGBA(249, 249, 249, 1)
// textfield placeHolder 颜色
#define Text_PlaceHolder_Color   RGBA(209, 209, 209, 1)

// 橙色
#define YELLOW_COLOR  RGBA(255, 189, 86, 1)

//深色字体颜色
#define DEEP_Text_Color   [UIColor colorWithRed:72/255.0f green:77/255.0f blue:80/255.0f alpha:1.0]
//Uang Uang浅色字体
#define SHALLOW_Text_Color  RGBA(155, 155, 155, 1)
//浅色字体颜色
#define LIGHT_Text_Color   [UIColor colorWithRed:135/255.0f green:143/255.0f blue:147/255.0f alpha:1.0]
//黄色背景色
#define YELLOW_BG_COLOR RGBA(255, 214, 67, 1)
// 蓝色背景色
#define BLUE_COLOR [UIColor colorWithRed:0/255.0f green:180/255.0f blue:231/255.0f alpha:1.0]
//红色背景
#define RED_BACKGROUND RGBA(239, 6, 0, 1)
//浅灰色字体
#define Gray_Text_Color  RGBA(102, 102, 102, 1)
//浅黑色字体
#define Black_Text_Color  RGBA(51, 51, 51, 1)

#define PICKER_DATA_COLOR  RGBA(246, 246, 246, 1)

#define BIGER_TITLE_COLOR  RGBA(15, 54, 82, 1)

#define BIGER_HEADER_COLOR  RGBA(247,248,250,1)

#define BIGER_RED_COLOR  RGBA(229, 85, 65, 1)

#define BIGER_GREEN_COLOR  RGBA(0, 206, 125, 1)

#define BIGER_SHALLOW_COLOR  RGBA(143, 157, 170, 1)

#define BIGER_BACKGROUND_COLOR  RGB(48, 146, 252)

#define BIGER_GRAY_COLOR  RGB(239, 243, 245)

#define BIGER_BLACK_COLOR  RGB(0, 0, 0)

#define BIGER_RISE  RGB(7, 192, 135)

#define BIGER_FALL  RGB(238, 113, 74)

#define BIGER_CELL_LINE_COLOR  RGBA(191, 191, 191, 1)
#define BIGER_TEXTFIlED_COLOR  RGBA(174, 187, 199, 1)

#define BIGER_PROGESS  RGB(216, 216, 216)

//深色字体颜色
#define WHITE_COLOR   RGBA(255, 255, 255, 1)

//打印方法名
#define LOGFUNC NSLog(@"%s", __func__);

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//背景颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//设置字体的大小
#define FONT(font) [UIFont systemFontOfSize:font]

//设置图片的时候
#define IMAGENAMED(NAME)        [UIImage imageNamed:NAME]

#define COMPLETEIMAGE  @"conplete_video_identify"

#define HARI @"hari"

//服务器返回的通用字段字段
#define MESSAGE @"message"
#define SUCCESS @"success"
#define DATA @"data"
#define BOTTONBUTTON @"MULAI MEMINJAM"

#define BTC   @"101"
#define BCH   @"102"
#define LTC   @"103"
#define ETH   @"104"
#define ETC   @"105"
#define USDT  @"106"
#define DASH  @"107"

#define HELPCENTRE @"HTML_HELP_CENTER"
#define FACESKILL  @"HTML_FACE_SKILL"
#define ABOUTUS    @"HTML_ABOUT_US"
#define WORKTIME   @"HTML_WORK_TIME"
#define WORKPHONE  @"HTML_TELE_PHONE"
#define LOGINPROTOCOL  @"HTML_LOAN_AGREEMENT"
#define BANKPROTOCOL   @"HTML_REGIST_AGREEMENT"

#define VERITY_SUCCESS  @"Verifikasi berhasil"

#define VERITY_FAILURE  @"Verifikasi gagal"
//#define VERITY_FAILURE  @""

//   xcode 8 ios10打印不全
#ifdef DEBUG
#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

// font
#define kFont8 [UIFont systemFontOfSize:8]
#define kFont9 [UIFont systemFontOfSize:9]
#define kFont10 [UIFont systemFontOfSize:10]
#define kFont11 [UIFont systemFontOfSize:11]
#define kFont12 [UIFont systemFontOfSize:12]   //行高17
#define kFont13 [UIFont systemFontOfSize:13]
#define kFont14 [UIFont systemFontOfSize:14]
#define kFont15 [UIFont systemFontOfSize:15]   //行高21
#define kFont16 [UIFont systemFontOfSize:16]
#define kFont17 [UIFont systemFontOfSize:17]   //行高24
#define kFont18 [UIFont systemFontOfSize:18]
#define kFont19 [UIFont systemFontOfSize:19]
#define kFont20 [UIFont systemFontOfSize:20]
#define kFont21 [UIFont systemFontOfSize:21]
#define kFont22 [UIFont systemFontOfSize:22]   //行高30
#define kFont24 [UIFont systemFontOfSize:24]
#define kFont28 [UIFont systemFontOfSize:28]
#define kFont36 [UIFont systemFontOfSize:36]
#define kFont45 [UIFont systemFontOfSize:45]

//设备
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size):NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size):NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size):NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size):NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size):NO)


#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#ifdef DEBUG
#define ZLOG(...)  printf("function:%s line:%d\n%s\n", __FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String])

#else
#define MLOG(...)
#define NSLog(...) {}
#endif
#endif /* Public_h */
