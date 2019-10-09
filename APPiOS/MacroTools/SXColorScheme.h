//
//  SXWalletController.h
//  APPiOS
//
//  Created by liuy on 2018/5/18.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SXColorScheme : NSObject

// 唯一实例
+ (SXColorScheme *) Instance;

// 加载配色方案
- (BOOL) loadScheme:(NSString *)scheme;

// 取得颜色值
- (UIColor *) getColor : (NSString *)key;
+ (UIColor *) getColor : (NSString *)key;

// 当前是否黑色风格
+ (BOOL) isBlack;

+ (NSString *)getImageName : (NSString *) name;

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end

//--------------------------------------------
//--------------------------------------------

/* 示例：
// 第一次getColor之前需加载配色方案，此后如需更改配色方案时再次调用。
// 以下代码加载白底配色方案，方案名"White"对应配置文件"ColorSchemeWhite.plist"
[[ColorScheme Instance] loadScheme:@"White"];

// 以下代码取得价格上涨颜色值
UIColor * colorKlineUp = [[ColorScheme Instance] getColor:COLOR_PriceUp];
 */


// ======================================================================
// 全局配色
// ======================================================================


#define COLOR_ThemeColor @"ThemeColor"
#define COLOR_NavColor @"NavColor"
#define COLOR_NavTitleColor @"NavTitleColor"
#define COLOR_TabarColor @"TabarColor"
#define COLOR_MainViewBackColor @"MainViewBackColor"
#define COLOR_FuViewBackColor @"FuViewBackColor"
#define COLOR_MainTextColor @"MainTextColor"
#define COLOR_FuTextColor @"FuTextColor"
#define COLOR_TableViewCellColor @"TableViewCellColor"
#define COLOR_TableViewCellSelectColor @"TableViewCellSelectColor"
#define COLOR_SepLineColor @"SepLineColor"
#define COLOR_SubmitBtnNomalColor @"SubmitBtnNomalColor"
#define COLOR_BuyBtnNomalColor @"BuyBtnNomalColor"
#define COLOR_SellBtnNomalColor @"SellBtnNomalColor"


// ======================================================================
// 配色方案名
// ======================================================================
#define COLOR_SCHEME_WHITE      @"White"    // 白底色
#define COLOR_SCHEME_BLACK      @"Black"    // 黑底色

