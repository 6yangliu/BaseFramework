//
//  HKLineProgressView.h
//  HKedllAP
//
//  Created by ly on 16/9/8.
//  Copyright © 2016年 kedll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKLineProgressView : UIView

@property (strong,nonatomic) UIView *firstView;
@property (strong,nonatomic) UIView *secondView;
@property (strong,nonatomic) UILabel *progressLabel;

//你还可以根据自己的需要创建其他的属性
@property (strong,nonatomic) UIColor *progressBackGroundColor;       //背景色
@property (strong,nonatomic) UIColor *progressTintColor;             //进度条颜色
@property (assign,nonatomic) CGFloat progressValue;                  //进度条进度的值
@property (assign,nonatomic) NSInteger progressCornerRadius;         //进度条圆角
@property (assign,nonatomic) NSInteger progressBorderWidth;          //进度条边宽度


+ (instancetype)initCommenProgressView;  //初始化构造方法

@end
