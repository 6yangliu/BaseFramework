//
//  XYButton.h
//  AppleDP
//  自定义按钮
//  Created by ly on 15/8/19.
//  Copyright (c) 2015年 kedll. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, XYButtonClickStyle) {
   XYButtonClickStyle1=0,
   XYButtonClickStyle2
};

@interface XYButton : UIButton
{
    
}
@property (nonatomic, strong) UIColor *orignalbgColor;//原始背景色
@property (nonatomic, strong) UIColor *touchedColor;//点击后背景色
@property (nonatomic, assign) XYButtonClickStyle clickStyle;

@end
