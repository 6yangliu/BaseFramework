//
//  UIColor+Y_StockChart.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "UIColor+SXColor.h"

@implementation UIColor (SXColor)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

#pragma mark 所有图表的背景颜色
+(UIColor *)backgroundColor
{
    return [UIColor colorWithRGBHex:0xFFFFFF];
}


#pragma mark 辅助背景色
+(UIColor *)assistBackgroundColor
{
    return [UIColor colorWithRGBHex:0x1d2227];
}

#pragma mark 菜单类背景色
+(UIColor *)segMenuBackgroundColor{
    
    return [UIColor colorWithRGBHex:0xF4F5F9];
}
#pragma mark 主菜单类文字颜色
+(UIColor *)segMainMenuTextColor{
    
    return [UIColor colorWithRGBHex:0x0F3652];
    
}
#pragma mark seg菜单类文字普通颜色
+(UIColor *)segTextNomalColor{
    return [UIColor colorWithRGBHex:0x0F3652];
    
}

#pragma mark 菜单类选中文字颜色
+(UIColor *)segTextSelectColor{
     return [UIColor colorWithRGBHex:0xF4B90E];
}

#pragma mark 涨的颜色
+(UIColor *)increaseColor
{
    return [UIColor colorWithRGBHex:0x07C087];
}

#pragma mark 跌的颜色
+(UIColor *)decreaseColor
{
    return [UIColor colorWithRGBHex:0xEA6D43];
}

#pragma mark 主文字颜色
+(UIColor *)mainTextColor
{
    return [UIColor colorWithRGBHex:0x8F9DAA];
}

#pragma mark 辅助文字颜色
+(UIColor *)assistTextColor
{
    return [UIColor colorWithRGBHex:0x565a64];
}

#pragma mark 分时线下面的成交量线的颜色
+(UIColor *)timeLineVolumeLineColor
{
    return [UIColor colorWithRGBHex:0x2d333a];
}

#pragma mark 分时线界面线的颜色
+(UIColor *)timeLineLineColor
{
    return [UIColor colorWithRGBHex:0x49a5ff];
}

#pragma mark 长按时线的颜色
+(UIColor *)longPressLineColor
{
//    return [UIColor colorWithRGBHex:0xff5353];
    return [UIColor colorWithRGBHex:0xe1e2e6];
}

#pragma mark ma5的颜色
+(UIColor *)ma7Color
{
    return [UIColor colorWithRGBHex:0xff783c];
}

#pragma mark ma30颜色
+(UIColor *)ma30Color
{
    return [UIColor colorWithRGBHex:0x49a5ff];
}

#pragma mark BOLL_MB的颜色
+(UIColor *)BOLL_MBColor
{
    return [UIColor whiteColor];
}

#pragma mark BOLL_UP的颜色
+(UIColor *)BOLL_UPColor
{
    return [UIColor purpleColor];
}

#pragma mark BOLL_DN的颜色
+(UIColor *)BOLL_DNColor
{
    return [UIColor greenColor];
}

@end