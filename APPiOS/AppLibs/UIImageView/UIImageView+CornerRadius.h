//
//  UIImageView+CornerRadius.h
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)
//创建带有圆角的imageView
- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

//设置带有圆角的imageView
- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

//设置圆形的imageView
- (instancetype)initWithRoundingRectImageView;

//设置圆形的imageView
- (void)zy_cornerRadiusRoundingRect;

//设置边框
- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;


@end
