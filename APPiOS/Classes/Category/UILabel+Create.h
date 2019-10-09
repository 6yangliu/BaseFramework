//
//  UILabel+Create.h
//  APPiOS
//
//  Created by 凌海龙 on 2018/6/11.
//  Copyright © 2018年 shengxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Create)

+ (UILabel *)createLabelWithFrame:(CGRect)frame withText:(NSString *)textString withTextColor:(UIColor *)color withFont:(int)font withAlignment:(NSTextAlignment)alignment;

+ (UILabel *)createLabelWithText:(NSString *)textString withTextColor:(UIColor *)color withFont:(int)font withAlignment:(NSTextAlignment)alignment;

@end
